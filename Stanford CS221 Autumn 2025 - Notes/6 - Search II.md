---

# Stanford CS221 — Lecture 6: Search II — UCS & A* (Autumn 2025)
**Instructor:** Percy Liang | **Course:** Artificial Intelligence: Principles and Techniques

---

## Recap: Search I

- **Search problem:** `start_state`, `successors(state)`, `is_end(state)` → find the minimum-cost sequence of actions
- **Exact methods:** exhaustive search, dynamic programming (caching)
- **Approximate methods:** best-of-n, beam search
- **Limitation of DP:** assumes **no cycles** in the state graph

This lecture: exact algorithms that **allow cycles** — as long as all costs are non-negative.

---

## Two Kinds of Cost

Before UCS, it helps to clearly distinguish two types of cost:

| Concept | Definition |
|---|---|
| **Past cost** | Minimum cost to reach state $s$ from the start state |
| **Future cost** | Minimum cost to reach an end state from state $s$ |

- **Dynamic programming** computes **future costs**, traversing from end states back to start (like backpropagation). This requires a **topological order** — impossible with cycles.
- **UCS** computes **past costs**, traversing from start state outward. This works with cycles.

---

## Uniform Cost Search (UCS)

*Dijkstra, 1956* — also known as Dijkstra's algorithm.

**Core idea:** process states in order of increasing past cost. A state whose past cost is confirmed minimal is **explored** and never revisited.

### The Three Zones

At any point during UCS, every state belongs to one of three zones:

| Zone | Meaning |
|---|---|
| **Explored** | Minimum past cost is confirmed and final |
| **Frontier** | Seen but not yet confirmed — still being updated |
| **Unexplored** | Not yet encountered |

### Algorithm

```
frontier = PriorityQueue()             # (past_cost, state)
frontier.add(start_state, priority=0)
explored = set()

while frontier is not empty:
    state, past_cost = frontier.remove_min()   # always the confirmed minimum
    if is_end(state): return solution
    for successor in successors(state):
        new_cost = past_cost + successor.cost
        frontier.update(successor.state, new_cost)   # only if improvement
```

- Uses a **priority queue** keyed by past cost
- **Backpointers** record how we arrived at each state → used to reconstruct the solution path at the end

### Correctness Theorem

> *When UCS moves a state $s$ from the frontier to explored, the priority of $s$ equals $\text{PastCost}(s)$.*

**Proof by induction:**
- **Base case:** start state has past cost = 0 ✓
- **Inductive step:** suppose all already-explored states have confirmed past costs. When we remove $s$ (minimum priority on frontier):
  - Any alternative path to $s$ must pass through some frontier state $u$
  - $\text{cost(alternative)} \geq \text{priority}(u) \geq \text{priority}(s)$
  - So no cheaper path exists → $\text{priority}(s) = \text{PastCost}(s)$ ✓

**Requirement:** all edge costs must be **non-negative**. Negative costs would allow cheaper paths to appear after a state is explored, invalidating the proof.

### Complexity

| Resource | UCS |
|---|---|
| Time | $O(n \log n)$ — each state explored once; priority queue operations are $O(\log n)$ |
| Memory | $O(n)$ — entire frontier kept in memory |

---

## A\* Search

*Hart, Nilsson & Raphael, 1968*

**Motivation:** UCS explores states in order of past cost alone, with **no knowledge of the goal direction**. It expands in all directions equally. Can we do better?

**Ideal ordering:** explore states in order of $\text{PastCost}(s) + \text{FutureCost}(s)$ — total path cost through $s$.

**Problem:** FutureCost is unknown (that's what we're trying to compute).

**A\* solution:** replace FutureCost with a **heuristic** $h(s)$ — an approximation of future cost.

### Modified Costs

A\* runs UCS on a **modified cost** function:

$$\text{Cost}'(s, a) = \text{Cost}(s, a) + h(\text{Succ}(s, a)) - h(s)$$

**Intuition:** add a penalty for actions that move **away from the goal** (increase $h$), and a bonus for actions that move **toward the goal** (decrease $h$).

The modified costs form a **telescoping sum** — summing modified costs along a path gives the original total cost minus $h(\text{start})$. So A\* finds the same optimal path as UCS, just explores fewer states.

### Consistency (Required for Correctness)

A heuristic $h$ is **consistent** (also called monotone) if:

$$\text{Cost}(s, a) + h(\text{Succ}(s, a)) - h(s) \geq 0 \quad \text{for all } s, a$$
$$h(\text{end}) = 0$$

This ensures the modified costs fed into UCS are **non-negative** — required for UCS correctness.

If $h$ is inconsistent, A\* may return a suboptimal solution.

### Admissibility (Weaker Condition)

A heuristic $h$ is **admissible** if it never overestimates:

$$h(s) \leq \text{FutureCost}(s) \quad \text{for all } s$$

- Consistency **implies** admissibility
- Admissibility alone is not sufficient for correctness with the general A\* formulation above

### Efficiency Proposition

A\* explores all states $s$ satisfying:

$$\text{PastCost}(s) \leq \text{PastCost}(\text{end}) - h(s)$$

Which means:
- If $h(s) = 0$ everywhere → A\* = UCS (no benefit)
- If $h(s) = \text{FutureCost}(s)$ exactly → A\* explores **only** states on the optimal path (perfect)
- In practice: $h$ is somewhere in between — the better the heuristic, the fewer states explored

---

## How to Design Heuristics — Relaxations

The key challenge: how do we construct a consistent heuristic $h$?

> *"Ideally, $h(s) = \text{FutureCost}(s)$, but that's just as hard as solving the original problem. So let's **relax** the problem to make it easier."*

### The Relaxation Principle

**Definition:** A **relaxation** of a search problem is a modified problem with the **same states and actions** but **lower costs**:

$$\text{Cost}_{\text{relaxed}}(s, a) \leq \text{Cost}(s, a) \quad \text{for all } s, a$$

**Theorem:** if $h(s) = \text{FutureCost}_{\text{relaxed}}(s)$, then $h$ is a **consistent heuristic** for the original problem.

**Proof** (triangle inequality + relaxation definition):

$$h(s) \leq \text{Cost}_{\text{relaxed}}(s, a) + h(\text{Succ}(s, a)) \leq \text{Cost}(s, a) + h(\text{Succ}(s, a))$$

### Three Ways to Relax a Problem

#### 1. Closed-Form Solution (Remove Constraints)
- **Example:** grid navigation with walls
- **Relaxation:** remove the walls
- **Result:** Manhattan distance becomes the heuristic — computable in $O(1)$

$$h(r, c) = |r_{\text{end}} - r| + |c_{\text{end}} - c|$$

#### 2. Fewer States (Simplify the State)
- **Example:** limited travel problem (tram allowed only $k$ times)
- **Relaxation:** ignore the ticket constraint → free tram
- **Result:** solve simpler problem once with DP, use its future costs as $h$
- Relaxed problem has fewer states → faster to solve

#### 3. Independent Subproblems (Break Apart)
- **Example:** 8-puzzle (tiles cannot overlap)
- **Relaxation:** allow tiles to overlap → each tile's problem is independent
- **Result:** $h(s) = \sum_{\text{tile}} \text{min moves for that tile}$
- Each subproblem can sometimes be solved in closed form

### Combining Multiple Heuristics

**Theorem:** if $h_1$ and $h_2$ are both consistent heuristics, then $h(s) = \max(h_1(s), h_2(s))$ is also consistent.

$$h(s) = \max(h_1(s), h_2(s)) \leq \text{Cost}(s, a) + \max(h_1(\text{Succ}), h_2(\text{Succ}))$$

This means you can define **multiple relaxations** and take the maximum — a strictly stronger heuristic than either alone, exploring fewer states.

---

## Summary: Search Algorithms Compared

| Algorithm | State Ordering | Handles Cycles? | Optimal? | Requires Heuristic? |
|---|---|---|---|---|
| **Exhaustive / DP** | Topological (future cost) | No | Yes | No |
| **UCS** | Increasing past cost | Yes | Yes (non-neg costs) | No |
| **A\*** | Increasing past cost + $h$ | Yes | Yes (if $h$ consistent) | Yes |
| **Beam search** | By cost so far, pruned | Yes | No (approximate) | No |

> *"You can't do better than UCS in general — A\* allows you to incorporate domain knowledge via heuristics to speed up search, not to improve the quality of the solution."*

---

## Key Takeaways

1. **UCS** solves the cycle problem that breaks DP by computing **past costs** in increasing order via a priority queue
2. **UCS correctness** relies entirely on **non-negative costs** — this is the essential requirement
3. **A\*** = UCS with modified costs based on a heuristic $h(s)$ pointing toward the goal
4. A heuristic must be **consistent** (modified costs non-negative) for A\* to be correct
5. A heuristic is **admissible** if it never overestimates future cost — consistency implies admissibility
6. Better heuristics (closer to true future cost) mean fewer states explored — but never affect solution quality
7. **Relaxations** are the principled way to design heuristics: remove constraints → solve easier problem → use its future cost as $h$
8. **Multiple heuristics can be combined** by taking the maximum — always consistent if each component is