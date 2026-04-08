---

# Stanford CS221 — Lecture 1: Overview (Autumn 2025)
**Instructor:** Percy Liang | **Course:** Artificial Intelligence: Principles and Techniques

---

## What Is Artificial Intelligence?

### 1. Examples of AI Today
AI is everywhere around us:
- **AI Assistants:** ChatGPT, Claude, Gemini, Grok
- **Autonomous Vehicles:** Waymo, Wayve
- **Game Playing:** Deep Blue (chess), AlphaGo (Go), AlphaStar (StarCraft II)
- **Competition Math & Programming:** IMO, IOI, ICPC problem solving
- **Scientific Discovery:** AlphaFold for 3D protein structure prediction

### 2. Defining Intelligence
- **Artificial** = runs on a computer (or a robot)
- **Intelligence** = harder to define; the course seeks a definition from **general principles** rather than from human comparison

---

## The Ingredients of Intelligence

> *"What kinds of things should an intelligent agent be able to do?"*

There are four core capabilities, all illustrated by the **motivating example of a self-driving car**:

### 1. Perceive — Process Raw Inputs from the World
- Visual scene understanding
- Speech recognition
- Natural language understanding

### 2. Reason — Use Knowledge + Percepts to Draw Inferences
- **Uniform cost search** (in a deterministic world)
- **Value iteration** (decision-making under uncertainty)
- **Minimax** (for adversarial games)
- **Probabilistic inference** (in Bayesian networks)

### 3. Act — Output Actions That Affect the World
- Text and image generation
- Speech synthesis
- Robot manipulation

### 4. Learn — Update the Agent Based on Experience
- **Gradient descent**
- **Q-learning** (reinforcement learning)
- **Expectation Maximization / EM** (for Bayesian networks)

### 5. Resource Constraints (The Two Bottlenecks)
All four capabilities operate under two fundamental constraints:
- **Computation:** running time, memory, communication
- **Information:** available data/experience; what inputs are accessible in a given situation

---

## Goals: What Does the Developer (and Society) Want?

### 1. Developer Goals — Alignment
- An agent explicitly or implicitly encodes **values / goals / objectives / utility functions**
- **Alignment problem:** how do we make an agent's values correspond to what the developer (and humans) actually want?
- Example: ChatGPT aims to be informative, avoid hallucinations, and refuse harmful queries

### 2. Societal Goals
- **Issues:** privacy, copyright, jobs, inequality, geopolitics
- This is a deep **sociotechnical** problem — there is no single "we"
- Involves **fundamental tradeoffs** between different people's values
- **Unintended consequences** are real: social media's impact on mental health, AI's impact on education

---

## The History of AI: Three Intellectual Traditions

The current state of AI is the sum of previous almost-successful attempts.

> *"The history of AI is the story of three intellectual traditions: Symbolic, Neural, and Statistical."*
The three traditions have often been in conflict, but each contributed something essential.

### The Question That Started It All — Alan Turing (1950)

Alan Turing asked: **"Can machines think?"** — and reframed it into something testable: *How could you tell?*

His answer was the **Imitation Game (Turing Test):** a human judge converses in text with both a machine and a human. If the judge can't reliably distinguish them, the machine "passes."

**Significance:** Grounded a philosophical question in objective measurement. Left the *solution* deliberately open — machine learning? logic? Both were valid paths.

### 1. Symbolic AI ("GOFAI" — Good Old-Fashioned AI)

Founded at the **Dartmouth Workshop (1956)**, organised by John McCarthy — the same meeting that coined the term **"Artificial Intelligence"**.

The core bet: *intelligence = manipulating symbols according to rules.* Represent the world as symbols and relationships; write programs that reason over them using **search and logic**.

> *"Machines will be capable, within twenty years, of doing any work a man can do."* — Herbert Simon
> *"Within 10 years the problems of artificial intelligence will be substantially solved."* — Marvin Minsky
> *"I visualize a time when we will be to robots what dogs are to humans."* — Claude Shannon

The optimism didn't survive contact with reality, leading to the **First AI Winter ❄️ (1966)** and the **Second AI Winter ❄️ (1987)**. The missing ingredients:
- **Limited computation:** search spaces grew exponentially, outpacing hardware
- **Limited information:** the real world is vastly more complex than anticipated
- **Deterministic rules** couldn't handle the **uncertainty** of the real world

The main algorithmic legacy:
- **Search + heuristics** — explore a space of possible states to find a solution (Logic Theorist, 1955)
- **Expert Systems / Knowledge-Based Systems** — encode domain knowledge as structured rules (MYCIN, XCON, DENDRAL); first real industrial AI applications, but rules became unmaintainable at scale

### 2. Neural AI

The core bet: *intelligence = learning from data via networks of interconnected nodes inspired by the brain.*

Key algorithm milestones:
- **Perceptron (Rosenblatt, 1958):** A single layer of weights mapping inputs to a binary output. The first trainable classifier. Can only solve linearly separable problems.
- **Backpropagation (Rumelhart, Hinton, Williams, 1986):** Computes the gradient of a loss function through a multi-layer network using the chain rule, enabling training of **deep** (multi-layer) networks.
- **Convolutional Neural Networks / CNNs (LeCun, 1989):** Networks with local connectivity and shared weights, designed for grid-like data (images). A convolution layer scans a learned filter across the input to detect local patterns.
- **AlexNet (2012):** Deep CNN that won ImageNet by a large margin, igniting the deep learning revolution.

The movement **died twice:**
1. Minsky & Papert's *Perceptrons* (1969) proved single-layer networks can't solve XOR — killed research for ~15 years
2. SVMs and statistical methods dominated the 2000s — neural nets were considered unreliable

It was revived by **layer-wise pre-training (Hinton, 2006)** combined with the availability of GPUs and large datasets.

### 3. Statistical AI

The core bet: *intelligence = building probabilistic models of the world, grounded in mathematical rigour.*

Rather than hard rules or raw neural weights, statistical AI models **uncertainty explicitly** using probability distributions.

Key algorithms:
- **Linear Regression (Gauss/Legendre, 1801):** Fit a linear function to data by minimising squared error. The simplest supervised learning model.
- **Stochastic Gradient Descent / SGD (Robbins/Monro, 1951):** Update model parameters iteratively using the gradient of the loss on a single example (or mini-batch), rather than the full dataset. The backbone of all modern ML training.
- **Uniform Cost Search / Dijkstra (1956):** Find the lowest-cost path in a graph by expanding the cheapest frontier node first.
- **Markov Decision Processes / MDPs (Bellman, 1957):** Formalise sequential decision-making under uncertainty via a state space, action space, transition probabilities, and a reward function. Solved via **value iteration** or **policy iteration**.
- **Bayesian Networks (Pearl, 1985):** Directed graphical models encoding conditional independence between variables. Enable reasoning under uncertainty by computing posterior probabilities.
- **Support Vector Machines / SVMs (Cortes/Vapnik, 1995):** Find the maximum-margin hyperplane separating two classes. Grounded in statistical learning theory (VC dimension).
- **Conditional Random Fields / CRFs (Lafferty et al., 2001):** Discriminative probabilistic models for structured prediction (e.g., labelling sequences like part-of-speech tagging).

### Foundation Models and the Modern Era

The modern era merges all three traditions. Its defining characteristic: **scale + pretraining on broad data**.

Key concepts:
- **Transformer (Vaswani et al., 2017):** Architecture based entirely on **self-attention** — each token attends to every other token in the sequence. Replaced RNNs as the dominant architecture.
- **Self-attention:** For each position in a sequence, compute a weighted sum of all other positions, where weights are learned from the data. Allows the model to capture long-range dependencies.
- **Pretraining + Fine-tuning (BERT, 2018):** Train on massive unlabelled text first (pretraining), then adapt to a specific task with labelled data (fine-tuning). Dramatically reduces the labelled data needed.
- **In-context learning (GPT-3, 2020):** At inference time, provide a few examples in the prompt and the model generalises — **without weight updates**. Learning from context, not from gradient descent.
- **Scaling Laws (Kaplan et al., 2020):** Model performance improves predictably as a power law of compute, data, and parameters. This made scaling a deliberate engineering strategy.
- **Chain-of-thought / Reasoning Models (o1, DeepSeek R1):** Generate intermediate "thoughts" before a final answer, enabling multi-step reasoning. The model is trained to think before speaking.

### Synthesis: The Parting Thoughts

### 1. The Fierce Battles Between Traditions
- Minsky & Papert **promoted symbolic AI** and effectively **killed neural network** research in the late 60s
- Statistical ML in the 2000s thought neural networks were dead
- Each wave of AI believed the previous approaches were wrong

### 2. The Deeper Connections (What the History Really Shows)
- McCulloch & Pitts introduced artificial neural networks — but their paper was about how to **implement logical operations** in neural circuits
- **Go** is defined purely symbolically (rules), but **deep neural networks** are essential to playing the game
- Deep learning was initially about perception — but is now turning toward **reasoning** (the original goals of symbolic AI)

### 3. AI as a Melting Pot

| Tradition | Primary Contribution |
|---|---|
| **Symbolic AI** | Provided the **vision and ambition** |
| **Neural AI** | Provided the **model architectures** |
| **Statistical AI** | Provided the **rigour** (optimisation, generalisation theory) |

> CS221 covers elements of all three traditions.

---

## Mathematical Foundations: Tensors

### 1. Why Tensors?
- Tensors are the **atoms of modern machine learning**
- Used to represent: data, model parameters, gradients, activations, and more
- Appear across science and engineering — worth knowing generally

### 2. Tensor Ranks (Dimensions)

| Rank | Name | Example |
|---|---|---|
| 0 | Scalar | `np.array(42)` — shape `()` |
| 1 | Vector | `np.array([1, 2, 3])` — shape `(3,)` |
| 2 | Matrix | `np.array([[1,2,3],[4,5,6]])` — shape `(2, 3)` |
| 3+ | Tensor | Multi-dimensional array |

### 3. Key Principles
- Use tensors to represent **everything**
- Express computations using **few tensor operations** for efficiency — fewer ops = faster code
- Use **einops** to make complex tensor computations legible and less error-prone
- Practice — it is like learning a new language

### 4. Scale in the Real World
- DeepSeek v3 has parameters spanning hundreds of billions of values across its tensors
- Modern ML models are defined entirely by their tensor weights

---

## Course Structure Summary

### 1. What CS221 Covers
- **Machine Learning:** linear regression, classification, neural networks, backpropagation, generalisation, unsupervised learning (k-means)
- **Search:** tree search, dynamic programming, UCS, A*
- **Markov Decision Processes (MDPs):** policy evaluation, value iteration, reinforcement learning
- **Games:** minimax, expectimax, alpha-beta pruning
- **Bayesian Networks:** probabilistic graphical models, inference, learning
- **Logic:** propositional logic, first-order logic
- **Language Models** *(new in Autumn 2025)*
- **AI & Society / Economics of AI** *(new in Autumn 2025)*

### 2. Course Philosophy
- **Timeless foundations** (e.g., gradient descent) + **modern examples** (e.g., GPT solving ICPC problems)
- **Learn by doing:** grounded in building practical applications
- **Tensor-native** approach throughout; deep dive into societal impact (copyright, supply chains, policy)

### 3. Recommended Textbooks (not required)
- *Artificial Intelligence: A Modern Approach* — Russell & Norvig
- *Probabilistic Graphical Models* — Koller & Friedman
- *Reinforcement Learning: An Introduction* — Sutton & Barto
- *The Elements of Statistical Learning* — Hastie, Tibshirani, Friedman

---

## Key Takeaways

1. **AI = Perceive + Reason + Act + Learn**, all under constraints of Computation and Information
2. **Alignment** is central: building AI that does what we actually want is still an open problem
3. **Three traditions** shaped AI: Symbolic (vision), Neural (architecture), Statistical (rigour)
4. AI history is marked by **cycles of hype, winters, and breakthroughs** — humility is warranted
5. The **Transformer + scaling** is the current dominant paradigm, but the field is still evolving fast
6. **Tensors** are the mathematical substrate of all modern ML — learn to think in them
7. There is no single winning tradition — the best AI systems combine insights from all three