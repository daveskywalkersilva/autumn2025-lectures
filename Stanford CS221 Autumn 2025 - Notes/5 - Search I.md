---

# Stanford CS221 — Lecture 5: Search I (Autumn 2025)
**Instructor:** Percy Liang | **Course:** Artificial Intelligence: Principles and Techniques

---

## Recap: Machine Learning

- A **predictor** reflexively maps percepts to outputs — it reacts, it doesn't plan
- Many real-world problems require **reasoning**: thinking ahead, problem-solving, planning over sequences of actions

This lecture introduces **Search** — the formal framework for reasoning in a deterministic world.

> *Rich Sutton's "The Bitter Lesson" (2019): "The two methods that seem to scale arbitrarily are search and learning."*

Search is increasingly important in modern AI — including **test-time compute** in language models.

---

## Why Search?

Examples of search problems:
- Finding the shortest path from A to B on a map
- Solving a Rubik's cube (finding a sequence of moves)
- A language model deciding what tokens to generate next

**Search vs. learning:** a predictor maps a single input to a single output. Search finds the best **sequence of actions** over time. Both are needed.

---

## Modeling a Search Problem

> *"Mindset: don't solve it! Formalise the problem first — because we want general methods that can solve any search problem."*

A **search problem** is formally defined by three components:

| Component | Definition |
|---|---|
| `start_state()` | The initial state |
| `successors(state)` | Given a state: the possible actions, their costs, and the resulting next states |
| `is_end(state)` | Whether the state is a terminal/goal state |

**Objective:** find a **solution** — a sequence of actions from start to an end state — that **minimises total cost**.

### What Belongs in the State?
- The state must contain **all information needed** to evaluate future actions, costs, and successors
- Example: if a constraint says "you can't take the tram twice in a row", the state must track the last action taken
- **Tradeoff:** more information in state = more correctness, but larger state space = slower algorithms
- Rule of thumb: include only what is necessary to make future decisions

---

## Exact Search Methods

### 1. Exhaustive Search

**Key definition — Future Cost:**

$$\text{future\_cost}(\text{state}) = \text{minimum cost to reach an end state from } \texttt{state}$$

**Recurrence:**

$$\text{future\_cost}(\text{state}) = \min_{\text{successor}} \left(\text{successor.cost} + \text{future\_cost}(\text{successor.state})\right)$$

**Base case:** if `is_end(state)`, `future_cost = 0`

**Algorithm:** recursively expand successors, compute future costs bottom-up, return the minimum-cost path.

**Complexity:**
- **Time:** worst case **exponential** in the number of states — the same state may be explored many times via different paths
- **Memory:** linear in the length of a solution (only the current recursion stack is kept)

**Assumption:** no cycles (A → B → C → A would cause infinite recursion). With cycles, the recurrence is undefined.

---

### 2. Dynamic Programming

**Definition:** Dynamic programming = exhaustive search + **caching** (also called memoisation).

The core insight: exhaustive search re-explores the same states multiple times through different paths. If we cache the result the first time we compute `future_cost(state)`, we never need to compute it again.

```
cache = {}
def future_cost(state):
    if state in cache: return cache[state]   # hit
    # compute as before...
    cache[state] = result
    return result
```

**Name origin:**
- *dynamic* = multiple actions over time
- *programming* = optimisation

| Property | Exhaustive Search | Dynamic Programming |
|---|---|---|
| Time complexity | Exponential in states | **Linear** in number of states |
| Memory complexity | Linear in solution length | **Linear in number of states** (cache) |
| Speed-up condition | — | When many paths lead to the same state |

**When to use DP:**
- When the number of states **fits in memory**
- When many different action sequences can arrive at the same state (so the cache is reused frequently)

**Limitation:** DP requires no cycles and that the number of states is tractable. For many real-world problems (e.g., state = set of locations, or state = sequence of words generated so far), the state space is astronomically large → exact search becomes infeasible.

---

## Approximate Search Methods

When the state space is too large for exact methods, we trade **optimality for efficiency** — find a "good enough" solution, not necessarily the best one.

### 1. Best-of-N Sampling

**Definition:** a **policy** is a function that selects an action given the current state and problem. Run the policy $n$ times from the start, collect $n$ complete solutions, return the best one.

```
for i in range(n):
    solution = rollout(problem, policy)   # follow policy to end
best = min(solutions, key=cost)
```

**Properties:**
- **Guarantee:** as $n \to \infty$, converges to the optimal solution — but may take exponentially long
- **Embarrassingly parallel:** each of the $n$ rollouts is completely independent — trivial to distribute
- Requires a **policy** as prior knowledge; the quality of the prior affects the quality of results
- Simple, scalable, widely used in modern LLM inference (test-time compute)

### 2. Beam Search

**Definition:** maintain a set of the $k$ best **partial solutions** (the "beam") at each step, expand all of them, then prune back to the best $k$.

```
beam = [empty solution]
for step in range(max_steps):
    candidates = expand all solutions in beam by one action
    beam = top-k candidates by cost so far
return best completed solution in beam
```

**Parameter:** `beam_width` $k$ controls the tradeoff:

| Beam Width | Behaviour |
|---|---|
| $k = 1$ | **Greedy search** — always take the single best action |
| $k = \infty$ | **Exhaustive search** |
| $1 < k < \infty$ | Approximation between the two |

**Properties:**
- Deterministic (unlike best-of-n which uses a random policy)
- Does not require a policy — uses costs directly
- More memory-efficient than exhaustive search
- Stochastic version: **particle filtering** (covered later in the course)

**Comparison:**

| Property | Best-of-N | Beam Search |
|---|---|---|
| Requires policy? | Yes | No |
| Parallelisable? | Easily | Less so |
| Uses costs or policy? | Policy (prior) | Costs |
| Randomness | Stochastic | Deterministic |

---

## Application: Test-Time Compute in Language Models

Search is directly applicable to **modern LLM inference**.

**Cast as a search problem:**
- **State:** prompt + prefix of the response generated so far
- **Action:** next token from the vocabulary
- **Cost:** negative log probability of the token under the language model (lower probability = higher cost); large bonus if a verifier confirms the response is correct

**Problem:** given a language model (which defines a distribution over next tokens) and a **verifier** (which checks if a response is correct), produce a response that is both highly probable under the model and passes the verifier.

**Test-time compute strategy:** instead of sampling one answer greedily, spend more computation at inference time:
- **Best-of-N:** sample $n$ complete responses, return the one the verifier approves
- **Beam search:** maintain $k$ partial responses, expand greedily at each token step

> *"Large Language Monkeys" (Brown et al., 2024): scaling the number of samples dramatically increases the chance of finding a correct answer.*

This is the mechanism behind OpenAI's o1/o3 reasoning models — more compute at inference time = better answers.

---

## Synergy: Learning + Search

Search and learning are complementary, not competing:
- **Learning** estimates the costs (e.g., how good is a partial solution?) from data
- **Search** uses those costs to find the best solution over a sequence of decisions

Modern AI systems (AlphaGo, o1, DeepSeek R1) combine both.

---

## Key Takeaways

1. **Search** is the framework for reasoning in a deterministic world — finding the optimal sequence of actions
2. A search problem is defined by **start state, successors function, and end condition**
3. **State design** is a modelling decision — include only what is necessary to determine future costs
4. **Exhaustive search** finds the optimal solution via the future-cost recurrence, but is exponentially slow
5. **Dynamic programming** = exhaustive search + caching — reduces time to linear in the number of states
6. DP is only practical when the **state space fits in memory** and many paths converge to the same states
7. **Best-of-N** and **Beam search** are approximate methods that sacrifice optimality for tractability
8. **Beam width** directly controls the tradeoff: $k=1$ is greedy, $k=\infty$ is exhaustive
9. Test-time compute in LLMs is search — generating more candidate responses and picking the best one