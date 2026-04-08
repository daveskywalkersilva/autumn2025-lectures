---

# AI Agents Full Course 2026: Master Agentic AI — Notes

**Source:** [AI Agents Full Course 2026: Master Agentic AI (2 Hours)](https://www.youtube.com/watch?v=EsTrWCV0Ph4)
**Author:** Nick Saraev | **Published:** March 8, 2026 | **Duration:** 2h 13m
**Course Files:** [Google Drive](https://drive.google.com/drive/folders/1Sjo54rul7zJXDES-Zu8snNuhYS0SC-IL)

---

## Table of Contents

1. Course Overview
2. Core AI Agent Workflow Loop
3. AI Agent Architecture: What an Agent Really Is
4. The Three Major Agent Platforms
5. Self-Modifying System Prompts
6. Agent Skills: Standardizing Workflows
7. Multi-Agent Orchestration (MCP)
8. Video-to-Action Pipelines
9. Stochastic Multi-Agent Consensus
10. Agent Chat Rooms
11. Sub-Agent Verification Loops
12. Prompt Contracts
13. Reverse Prompting
14. Context Management & Token Optimization
15. Key Takeaways for an Azure Architect

---

## Chapter Timestamps

| Time | Topic |
|------|--------|
| 00:00 | Introduction to AI Agent Full Course |
| 02:14 | Multi-Agent Chrome MCP Workflow Demonstration |
| 04:28 | Core Agent Workflow |
| 09:09 | Understanding AI Agent Architecture |
| 13:18 | The Three Major AI Agent Platforms (Codex, Claude Code, Antigravity) |
| 22:29 | Platform-Specific Performance Insights |
| 25:43 | Self-Modifying System Prompts |
| 34:57 | Standardizing Workflows with Agent Skills |
| 39:03 | Multi-Agent Orchestration Strategies |
| 47:20 | Video-to-Action Pipeline |
| 56:07 | Implementing Stochastic Multi-Agent Consensus |
| 1:04:44 | Agent Suggestions Unveiled |
| 1:05:08 | Consensus Reports and Insights |
| 1:06:05 | Harnessing Multiple Agents |
| 1:07:41 | Agent Chat Rooms Explained |
| 1:10:34 | Debate and Collaboration Among Agents |
| 1:13:25 | Sub-Agent Verification Loops |
| 1:17:32 | The Mix (Advanced Combinations) |
| 1:21:25 | Prompt Contracts for Clarity |
| 1:27:40 | Reverse Prompting for Precision |

---

## 1. Course Overview

This is an **end-to-end, platform-agnostic** course on agentic AI. It covers **three modern agentic coding tools**: Codex (OpenAI), Claude Code (Anthropic), and Antigravity (Google). Regardless of which you use, the techniques apply equally.

> ⚡ **Core philosophy:** Agents are not just LLMs. They are LLMs *combined with* tools, reasoning loops, and memory — much like a human with infrastructure.

**What you will learn (no fluff):**
- Foundational AI agent design and architecture
- Advanced prompt engineering for agents
- Self-modifying agent instructions
- Multi-agent MCP orchestration
- Video-to-action pipelines
- Agent chatrooms and debate patterns
- Sub-agent verification loops
- Prompt contracts and reverse prompting
- Context management and token usage optimization

**The central advantage of agents: Parallelization.** Agents can run multiple instances simultaneously, compensating for individually lower accuracy with speed and volume.

---

## 2. Core AI Agent Workflow Loop

*[00:51]*

Every AI agent runs on a **three-step loop** that repeats continuously until the task is complete:

```
OBSERVE → REASON → ACT
    ↑                  ↓
    └──── (result fed back) ────┘
```

### Step-by-step breakdown

| Step | What Happens | How to Optimize |
|------|-------------|-----------------|
| **Observe** | Agent reads all context: files, previous tool calls, system prompts, research, memory | Manage context size carefully — include only what's relevant |
| **Reason** | Agent considers context and plans its next move | Give it clear goals and constraints so reasoning is focused |
| **Act** | Agent calls tools, edits files, or runs commands | Ensure tools are well-defined and outputs are predictable |

> ⚠️ **The loop only stops when the "Definition of Done" is met.** Without it, agents produce underwhelming or incomplete results.

### Definition of Done *[07:11]*

The **most commonly omitted** element in agent prompts. It defines:
- The exact constraints the result must satisfy
- The specification that signals the task is complete
- Failure conditions (what the agent should NOT do)

**Without it:** the agent may stop too early, loop forever, or produce partial output.
**With it:** the agent has a clear exit condition and produces deterministic, satisfying results.

---

## 3. AI Agent Architecture: What an Agent Really Is

*[09:09]*

> "AI agents are NOT just the LLMs themselves. They are the LLMs combined with **tools, reasoning loops, and memory** — much like a human with infrastructure." *[08:37]*

### The Agent = LLM + Infrastructure model

```
┌─────────────────────────────────────┐
│              AI AGENT               │
│                                     │
│  ┌─────────┐   ┌──────────────┐    │
│  │   LLM   │ + │    TOOLS     │    │
│  │(brain)  │   │(web, files,  │    │
│  └─────────┘   │ APIs, code)  │    │
│                └──────────────┘    │
│  ┌─────────────────────────────┐   │
│  │         MEMORY              │   │
│  │ (context window, files,     │   │
│  │  embeddings, past sessions) │   │
│  └─────────────────────────────┘   │
│  ┌─────────────────────────────┐   │
│  │      REASONING LOOP         │   │
│  │   (Observe → Reason → Act)  │   │
│  └─────────────────────────────┘   │
└─────────────────────────────────────┘
```

Understanding this architecture is what enables you to **combine agents using prompt architecture** — knowing how they work under the hood lets you design powerful multi-agent systems.

### Types of memory in agents

| Memory Type | Description | Example |
|-------------|-------------|---------|
| **In-context** | What's in the token window right now | Current conversation, file contents |
| **External files** | Markdown/text files the agent reads prepended to each session | `gemini.md`, `CLAUDE.md`, skills files |
| **Embeddings/Vector DB** | Semantic memory retrieved on demand | RAG systems, knowledge bases |

---

## 4. The Three Major Agent Platforms

*[13:18–24:57]*

The course covers three modern agentic coding platforms. The difference between them is **diminishing over time**, but each has distinct strengths.

| Platform | Made By | Strengths | Weaknesses |
|----------|---------|-----------|------------|
| **Codex** | OpenAI | Back-end programming, test-driven development, large app ecosystem | Less strong at design/front-end |
| **Claude Code** | Anthropic | Interpretable reasoning, excellent for orchestration/management roles | Slower, weaker at front-end design |
| **Antigravity** (Google) | Google | Superior at design/front-ends, strong multimodal abilities (video, images) | Inconsistent quality, less interpretable reasoning |

> 💡 **Key insight:** The gap between these models is small and keeps shifting with new releases. The techniques in this course are **platform-agnostic** — pick whichever you prefer.

### Practical orchestration implication
Because each model has different strengths, **multi-agent systems should route tasks** to the most suitable model:
- Claude Code as the **orchestrator/manager**
- Antigravity (Gemini) for **front-end/design** subtasks
- Codex for **back-end/testing** subtasks

---

## 5. Self-Modifying System Prompts

*[25:43]*

One of the most powerful techniques: allow the agent to **learn from its own mistakes** and improve over time by writing new rules to its own system prompt file.

### How it works

1. Create a file (e.g., `CLAUDE.md`, `gemini.md`, `agents.md`) that is **prepended to every conversation**
2. The file contains accumulated lessons, preferences, and rules
3. Build a **meta-prompt** that instructs the agent to update the file with new knowledge before finishing any task
4. When the agent makes a mistake or receives feedback → it writes a **new rule** for future sessions

```markdown
# Agent Memory File (CLAUDE.md)
<!-- The agent updates this file automatically -->

## Rules Learned from Past Sessions
- Always add error handling when writing file operations
- Use TypeScript interfaces, not `any` types
- When creating Azure resources, check quota limits first
- ...
```

### Global vs. Local files *[33:35]*

| Scope | Location | Purpose |
|-------|----------|---------|
| **Global** | User-level system config | User-wide preferences across all projects |
| **Local** | Project-specific directory | Project-specific rules, tech stack constraints |

> ✅ **Architect use case:** Create a global `CLAUDE.md` with your architecture patterns and standards (naming conventions, Azure resource tagging, security baselines), and local files for project-specific constraints.

---

## 6. Agent Skills: Standardizing Workflows

*[34:57]*

**Skills** are reusable instruction files that turn vague LLM outputs into **deterministic, repeatable execution paths**.

> "Skills standardize workflows, turning the vagueness of LLMs into deterministic paths for repeatable tasks across major platforms."

### What a skill looks like

A skill file is a structured markdown file telling the agent *exactly* how to perform a specific task type:

```markdown
# Skill: Create Azure Resource Group

## Goal
Create an Azure Resource Group with compliant naming and tagging.

## Steps
1. Ask user for: environment (dev/staging/prod), region, workload name
2. Generate name following convention: rg-{workload}-{env}-{region}
3. Add required tags: Owner, CostCenter, Environment, CreatedBy
4. Run: az group create --name {name} --location {region} --tags ...
5. Verify creation succeeded
6. Output: resource group ID and ARM resource details

## Constraints
- Never create in regions: australiaeast (quota limitation)
- Always apply tags before finishing
- Definition of Done: resource group exists and all tags are applied
```

> 💡 **Skills are the foundation for building reusable AI automation.** Once created, anyone on the team can invoke the same skill and get consistent results.

---

## 7. Multi-Agent Orchestration (MCP)

*[39:03]*

**Multi-agent MCP orchestration** is the pattern of using one agent as a **manager/router** that delegates subtasks to specialized agents, achieving parallelization and higher quality.

### Architecture pattern

```
                    ┌──────────────────┐
                    │   ORCHESTRATOR   │
                    │  (Claude Code)   │
                    └────────┬─────────┘
                             │ routes subtasks
             ┌───────────────┼───────────────┐
             ▼               ▼               ▼
     ┌──────────────┐ ┌──────────────┐ ┌──────────────┐
     │   AGENT A    │ │   AGENT B    │ │   AGENT C    │
     │(Antigravity) │ │  (Codex)     │ │(Specialized) │
     │ Front-end    │ │ Back-end     │ │ Testing/QA   │
     └──────────────┘ └──────────────┘ └──────────────┘
```

### How the router works *[40:43]*

A **router** divides tasks into subtasks and assigns them based on model strengths:
- Front-end tasks (UI, CSS, design) → Antigravity/Gemini
- Back-end tasks (APIs, databases, logic) → Codex
- Orchestration and reasoning → Claude Code

### Cost consideration *[45:30]*

> ⚠️ Multi-agent orchestration is **more expensive** due to splitting tokens across multiple models. Budget accordingly — justify the cost with the quality improvement.

> ✅ **Azure Architect use case:** Use this pattern in Azure AI Foundry when building multi-agent solutions. The orchestrator maps to the **primary agent**, and specialized sub-agents are optimized for specific domain knowledge (e.g., one for infrastructure-as-code, one for security review, one for cost estimation).

---

## 8. Video-to-Action Pipelines

*[47:20]*

Teach agents **by feeding them video tutorials**, converting visual demonstrations into step-by-step executable instructions.

### How it works

1. Take a video tutorial (e.g., a walkthrough of how to configure an Azure resource)
2. Pass the video to **Gemini API** (which has strong multimodal capabilities)
3. Gemini extracts step-by-step instructions from the video
4. Feed those instructions to the coding/action agent
5. Agent executes the workflow

> ✅ **Architect use case:** Record a screen walkthrough of how you perform a complex Azure configuration (e.g., setting up Private Endpoints, configuring Defender for Cloud), then use this pipeline to train an agent to automate that exact workflow for your team.

---

## 9. Stochastic Multi-Agent Consensus

*[56:07]*

Leverage the **inherent randomness (stochasticity)** of LLMs to generate a broader solution space and identify the best answers through statistical analysis.

### Core idea

LLMs return slightly different answers every time they're called, even with the same prompt. Rather than fighting this, **exploit it**:

1. Spawn **N agents** with slightly varied input prompts around the same task
2. Each agent independently explores the solution space
3. Collect all outputs
4. Statistically analyze: identify consensus ideas + outliers
5. Use the spread to:
   - Find the most robust/safe answer (consensus)
   - Discover creative/unexpected solutions (outliers)
   - Filter out hallucinations (low-frequency outliers)

```
Prompt Variant 1 → Agent → Answer A
Prompt Variant 2 → Agent → Answer B   →  Statistical Analysis  →  Consensus Report
Prompt Variant 3 → Agent → Answer C
Prompt Variant N → Agent → Answer N
```

### Best use cases *[61:28]*
- Decision-making and ranking
- Strategic analysis
- Architecture option evaluation
- Filtering hallucinations
- Brainstorming (maximizing idea diversity)

> ✅ **Architect use case:** Use this when evaluating architectural options (e.g., "What's the best approach for our data ingestion layer?"). Spin 5–10 agents with slightly different framings of the problem to get a fuller picture of the solution space.

---

## 10. Agent Chat Rooms

*[1:07:41]*

Create **centralized communication spaces** where multiple agents with different "personalities" or roles **debate and collaborate** to produce higher-quality answers.

### How it works *[1:10:34]*

- Create a shared context/file that multiple agents write to and read from
- Assign each agent a different role or perspective (e.g., "security-focused reviewer", "cost-optimization advocate", "developer advocate")
- Agents debate in the shared space, challenging each other's reasoning
- The result is **more nuanced, higher-quality answers** than any single agent would produce

```
Agent (Security Role):   "This approach exposes public endpoints. Recommend Private Link."
Agent (Cost Role):       "Private Link adds $0.01/GB. At this scale, consider Service Endpoints."
Agent (Arch Role):       "Agreed on Private Link for production; Service Endpoints acceptable for dev."
↓
CONSENSUS: Private Link in prod, Service Endpoints in dev/staging
```

> ✅ **Architect use case:** Simulate a design review board. One agent plays "security reviewer", one plays "cost optimizer", one plays "operations", one plays "developer experience". Have them debate your architecture proposal to surface blind spots before you present to stakeholders.

---

## 11. Sub-Agent Verification Loops

*[1:13:25]*

Use **separate agents to review each other's work** in real-time — exploiting the fact that a fresh agent is an unbiased reviewer.

### Why it works

An agent that just produced an output is "close to the work" and will often miss its own errors. A fresh agent reviewing the same output has **no attachment** to the solution and catches problems more reliably.

### Pattern

```
Producer Agent → Output → Reviewer Agent → Feedback → Producer Agent (revise)
                                                  ↓ (if passes)
                                              Final Output
```

> ✅ **Architect use case:** Use this for IaC (Infrastructure as Code) review pipelines. A Bicep/Terraform generating agent produces a template, a separate security-review agent checks it against Azure policies and CIS benchmarks, and a third cost-estimate agent calculates expected monthly spend — all before any human reviews it.

---

## 12. Prompt Contracts

*[1:21:25]*

**Prompt Contracts** are structured, explicit prompt definitions that leave zero ambiguity about what the agent needs to do.

### The four components of a Prompt Contract

| Component | Description | Example |
|-----------|-------------|---------|
| **Goals** | What the agent must achieve | "Create a Bicep module for an Azure Key Vault" |
| **Constraints** | What it must NOT do or must respect | "Do not use deprecated API versions; follow naming convention rg-{workload}-{env}" |
| **Format** | How the output must be structured | "Produce a single .bicep file with inline comments" |
| **Failure Conditions** | What constitutes an unacceptable output | "Fail if the Key Vault allows public network access" |

### Why this matters

Prompt contracts reduce:
- Ambiguous, half-correct outputs
- Repeated iterations due to vague scope
- Hallucinated "creative" solutions outside requirements

> ✅ **Architect use case:** Encode your organization's architecture standards into prompt contracts. This becomes a force-multiplier — anyone on the team (including junior engineers) can invoke a prompt contract and get architecture-compliant outputs.

---

## 13. Reverse Prompting

*[1:27:40]*

Instead of the user asking the agent questions, **make the agent ask you questions first** before it starts working.

### How it works

Instruct the agent with a meta-prompt like:
> *"Before starting this task, ask me at least 5 clarifying questions to uncover non-obvious preferences and constraints that would affect your approach."*

This surfaces:
- Preferences you didn't know you had
- Constraints you forgot to mention
- Assumptions you were making implicitly

### Why it's powerful

It **front-loads discovery** — catching misalignments before the agent invests compute and time in the wrong direction. It's especially valuable for complex, open-ended tasks.

> ✅ **Architect use case:** When using an agent to design an Azure architecture, reverse prompting will uncover requirements like disaster recovery RTO/RPO, compliance frameworks (SOC 2, ISO 27001), specific service tier constraints, or cost caps — all before the agent spends time generating an incompatible design.

---

## 14. Context Management & Token Optimization

*[05:01 and throughout]*

### Strategic Context Management

> "Optimize the observe step by managing context effectively, including files, tool calls, and system prompts, to improve agent output quality."

**What gets loaded into context affects everything:**
- Overly long context → agent loses focus, makes errors, and costs more
- Too thin context → agent makes wrong assumptions

**Best practices:**
- Be surgical: only include files directly relevant to the current task
- Use skills files as compressed, structured knowledge rather than raw documentation
- Split large tasks into phases rather than loading everything at once
- Use sub-agents to handle isolated subtasks (keeps each agent's context minimal)

### Token Cost Optimization

| Strategy | Impact |
|----------|--------|
| Use shorter, targeted system prompts | Reduces cost per call |
| Scope sub-agents to narrow tasks | Limits token consumption per agent |
| Cache frequently used context in skills files | Reduces redundant loading |
| Use cheaper models for low-complexity tasks | Use Codex or Gemini Flash for simpler steps |

> ⚠️ Multi-agent architectures multiply cost — monitor token usage in production, especially when running stochastic consensus with N agents.

---

## 15. Key Takeaways for an Azure Architect

### How to apply this today

| Agentic Technique | Azure Architect Application |
|-------------------|----------------------------|
| **Self-Modifying Prompts** | Maintain a `CLAUDE.md` with your org's naming conventions, Azure policies, tagging standards — the agent learns your environment |
| **Agent Skills** | Create skills for repeatable tasks: create resource group, deploy AKS cluster, configure Defender for Cloud, generate ARM/Bicep modules |
| **Stochastic Consensus** | Use for architecture decisions — run 5+ agents to evaluate landing zone options, choose networking topology, evaluate service trade-offs |
| **Sub-Agent Verification Loops** | Build automated IaC review pipelines: generate → security-scan → cost-estimate → policy-check, all agent-driven |
| **Agent Chat Rooms / Debate** | Simulate a design review board: security, cost, operations, and developer experience agents debate your proposed design |
| **Prompt Contracts** | Encode your Well-Architected Framework requirements into contracts — reliability, security, cost optimization, operational excellence |
| **Reverse Prompting** | Use before designing a solution — let the agent surface requirements you may have missed |
| **Video-to-Action Pipelines** | Record your own Azure configuration walkthroughs to train agents for team automation |
| **Multi-Agent Orchestration** | Build Azure AI Foundry solutions with a Claude-style orchestrator routing to specialized sub-agents per domain |
| **Parallelization** | Run multiple Azure architecture options in parallel — let agents produce 3 different viable designs simultaneously and compare |

### The core mindset shift

> Agents are not a smarter ChatGPT. They are **autonomous systems that act in iterative loops**. Your job, as an architect, is to design the *scaffolding*, *constraints*, and *verification mechanisms* around them — the same way you design governance and guardrails for cloud infrastructure.

### Related courses by Nick Saraev (for deeper dives)

| Course | Link | Duration |
|--------|------|---------|
| Claude Code Full Course | [YouTube](https://www.youtube.com/watch?v=QoQBzR1NIqI) | 4 hours |
| Agentic Workflows Full Course | [YouTube](https://www.youtube.com/watch?v=MxyRjL7NG18) | 6 hours |
| N8N Full Course | [YouTube](https://www.youtube.com/watch?v=2GZ2SNXWK-c) | 6 hours |
| Vibe Coding with Antigravity | [YouTube](https://www.youtube.com/watch?v=gcuR_-rzlDw) | 6 hours |

---

*Notes compiled from: [YouTube video](https://www.youtube.com/watch?v=EsTrWCV0Ph4), video description, chapter list, and content summaries. Date of notes: April 9, 2026.*

---

Here are the notes above — ready for you to paste into any Markdown editor (Obsidian, Notion, VS Code, etc.). A few highlights worth calling out for your context as an Azure Architect:

- **Skills files** are the most immediately actionable — start building a library of Azure-specific skills (e.g., deploy Key Vault, configure Private Endpoints, generate Bicep modules with policy compliance) and you'll have reusable, composable agent workflows
- **Sub-agent verification loops** map naturally onto your existing review checkpoints (security review, cost review, policy compliance) — agents can automate all of these before any human touches the output
- **Stochastic consensus** is underrated for architecture decisions — instead of one agent giving you one design, spawn 5 with slightly different framings and get a proper option space to evaluate
- The **Observe → Reason → Act loop** is the mental model you need when debugging why agents behave unexpectedly — most problems trace back to bad context in the Observe step