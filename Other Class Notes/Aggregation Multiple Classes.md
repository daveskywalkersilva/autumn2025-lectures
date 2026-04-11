### **I. The Hierarchy of Intelligence**
The AI technology is best understood as a series of nested layers, with each subsequent field being a specialized subset of the previous one. Currently, we have 3 main categories, mainly:

1.  **Artificial Intelligence (AI):** The broadest field. Its goal is to simulate human intelligence — specifically the ability to **learn, infer and reason** — using a computer [[01:31](http://www.youtube.com/watch?v=qYNweeDHiyU&t=91)].
    * **Logical Goal:** To match or exceed human cognitive functions.
    * **Setbacks:** These were rigid and only as smart as the rules a human wrote for them.
2.  **Machine Learning (ML):** A subset of AI where the machine "learns" from patterns in data, without being explicitly programmed for a specific task [[02:54](http://www.youtube.com/watch?v=qYNweeDHiyU&t=174)].
    * **Logical Goal:** Discovering hidden patterns and making predictions.
    * **Setbacks :** Highly dependent on training data and not able to process unusual outcomes (hence being known for anomaly detection and classification).
3.  **Deep Learning (DL):** A subset of ML that uses **multi-layered neural networks** to mimic the human brain’s structure to process complex data [[04:54](http://www.youtube.com/watch?v=qYNweeDHiyU&t=294)].
    * **Logical Goal:** Mimic the brain’s "unpredictable" yet highly effective processing power.
    * **Setbacks:** The black box logic, because there are so many layers, it is often difficult to decompose or explain exactly *why* a model reached a specific result.

---

### **II. The Foundation Model (The "Generalist" DL)**
From the Deep Learning Intelligence approach - usage of Neural networks - derived the concept of Foundational Model, which **shares the same Transformer algorithm**, but with an **increased neural depth**, a much **bigger training data pool** and a more **general knowledge** goal, leading to be defined as a massive Deep Learning algorithm that has finished its "General Education" (pre-training). 

$$\text{FM} = (\underbrace{\text{Large-Scale Data}}_\text{Modality} + \underbrace{\text{Transformer Architecture}}_\text{Deep Learning}) \times \underbrace{\text{Self-Supervised (Like NTP)}}_\text{Training Goal}$$

In summary, you can say that **a model is what an DL algorithm creates right after being trained with data** (what we call pre-trained). As such, its a persistent, reusable asset that can be adapted to hundreds of different tasks (process called "*finetunning*").
Below you can find a comparisson of both a traditional trained DL and a FM, like LLM:

| Feature | Traditional Deep Learning Model | Foundation Model (LLMs, etc.) |
| :--- | :--- | :--- |
| **Training Scope** | **Task-Specific:** You train a model specifically to detect "Hard Hats" in images. | **Generalist:** The model is trained on "everything" to understand the concept of images/text. |
| **Data Requirement** | Requires **Labeled Data** (e.g., thousands of photos tagged "Hard Hat"). | Uses **Self-Supervised Learning** on massive unlabeled data (the internet). |
| **Architectural Choice** | Can be many types (CNNs, RNNs, LSTMs). | Almost exclusively **Transformers** (a specific DL architecture). |
| **Reusability** | **Low.** A hard-hat detector can't suddenly write a poem. | **High.** One model (GPT-4) can write code, summarize text, and act as a logic engine. |

> Note: Self-Supervised Learning is when we grab the data and split it into training data and evaluation data. The goal is to train the model so it can predict the original data as the output. It's a type of supervised training.

The classification of Foundational Models as Deep Learning Models, instead of a subset of DL for instance, is based on still sharing these 3 specific technical characteristics:
    1. Same **Neural Network Architecture:** (like **Transformer architecture**) with many layers (hence "deep"), with the only difference being the scale of it - modern LLMs (like GPT-4 or Llama 3) have hundreds of layers and billions of parameters. This massive "depth" is what allows them to understand complex linguistic nuances.
    2. Same **Feature Representation Learning:** where in traditional ML there would be the need of a human to define "features" (e.g., in a house price model, features might be "square footage" or "zip code") - something that in Deep Learning, models learn to extract features themselves from raw data
    3. Same **Training Paradigm:** meaning that FMs utilize the same core mathematical engines of Deep Learning in training - **Backpropagation** and **Gradient Descent**. They learn by calculating the "error" (loss) between their predicted next word and the actual word in the training text, then updating their internal weights across all layers to minimize that error.

> If you tell a someone you are using a FM, you are describing the tier of technology (Scale + Transformer + Pre-training). If you however tell about using a LLM, you are defining the interface (Input = Text, Output = Text).

---

### **III. Foundation Models, Large Language Models and Generative AI**
The **Large Language models (LLMs)** are nothing more than a **subset of Foundational Models that interpret Language** (by splitting them into tokens and converting those into a number) to understand a prompt to reach a specific outcome. Kin to it, would be the Vision Foundation Models (for images) and the Audio Language Models (for Sound) that, together, would be enabled by a single **Large Multimodal Models (LMMs)**.

$$\text{LMM} = (\underbrace{\text{Multi-Modal Data (Text, Image, Audio)}}_\text{Modality} + \underbrace{\text{Transformer Architecture}}_\text{Deep Learning}) \times \underbrace{\text{Next-Token Prediction}}_\text{Training Goal}$$

Since both are subset types (on the LLM case of the *text-to-text* sort), we can see that its equation definition is simply a more limited yet paralel version of the one for FM:

$$\text{LLM} = (\underbrace{\text{Text Data}}_\text{Modality} + \underbrace{\text{Transformer Architecture}}_\text{Deep Learning}) \times \underbrace{\text{Next-Token Prediction}}_\text{Training Goal}$$

Digging more into the equation: similarly to how a database doesn't "understand" a string - it understands data types - the agnostic Foundation Model doesn't "read" and write text either, leading to the following components of the equation: 
* **The Modality ("Text-to-Input") phase:** This is the **Tokenizer** function. It translates human language into numerical vectors (embeddings) that the Foundation Model can process to both read and write.
* **The "Thinking/Understanding" phase:** This is the **Transformer** function. It uses its deep learning layers to calculate the relationship between those numbers across many layers.
* **Next "Prediction" (NTP) phase:** An objective function that drives the entire learning process of an LLM. It is a form of **Self-Supervised Learning** where the data provides its own targets and prediction, instead of human labeled data input like in traditional DL.
  
The model is not "taught" facts through the Next Token Prediction. Instead, it is given a massive corpus of text and asked millions of times: *"Given these $n$ tokens, what is the most statistically probable $(n+1)$ token?"*
* **Original Data to pre-train from:** "The Azure Architect deployed a service."
* **The Input:** "The Azure Architect deployed a..."
* **The Target:** "...service."
* **The Adjustment:** If the model guesses incorrectly, the **Deep Learning backpropagation** adjusts the internal weights to make the correct answer more likely next time.

It's in the Next Token Prediction (NTP) that lays the core distinction that makes an LLM Generative AI or the traditional type of AI, since the training can be used to either generate new combinations (generative) or to identify mistakes (discriminate).

> Whilst both LLM and LMM are subsets of Foundational Models (FM), both are "brothers" to each other. One is specific to Text only, the other is more of a generalist. They are just a different types of Foundational Models. 

---

### **IV. The Logical Distinction: Discriminative vs. Generative**
While all Foudational Models are Deep Learning Models, not all Deep Learning is Generative. 

| Feature | Discriminative DL (Traditional) | Generative DL (LLMs/GenAI) |
| :--- | :--- | :--- |
| **Objective** | **Classify or Predict:** Is this a cat or a dog? Is this transaction fraudulent? | **Create:** Write a poem about a cat; generate a Python script for an Azure Function. |
| **Logic** | Learns the **boundary** between data classes. | Learns the **probability distribution** of the data itself. |
| **Output** | A label or a numerical value ($y$). | New data that looks like the training data ($\hat{x}$). |

Because of these differences, notice that **Generative AI is any type of AI (including ML) that generates new content**, meaning that **it's a category** and not as much of a subset of DL per say - instances of these are the so called "Traditional Generative Models" of which the *Hidden Markov Models (HMM)*, *Gaussian Mixture Models (GMM)* and *Naive Bayes* are part of.

> For this reason, any LMM that generates new content can be defined as a GenAI Model. 

---

### **V. Foudational Model vs Generative AI**
On the same note as the last 2 chapters, It's important to highlight that these aren't the same thing. Foundation Model refers to the **architecture of the model** (Infrastructure), while Generative AI refers to the **capability of that model** to generate inexisting content (App). 

To better translate this, on Azure terms, is the same as comparing the Virtual Machine (that hosts applications) to the Web App (that is the product of being hosted on a VM, so basically a VM finetuned to run an app only). Its is a byproduct of the first persay and could be hosted on a Container instead (in this instance, an ML model):

| Feature | Foundation Model | Generative AI |
| :--- | :--- | :--- |
| **Focus** | **Base Infrastructure:** The "Pre-trained" state. | **Output Type:** The "Create" capability. |
| **Logic** | "One model, many tasks." | "New data from learned patterns." |
| **Azure Analogy** | **The Virtual Machine Image:** A base OS you can configure for any role. | **The Web App Service:** A specific function (serving content) provided to the user. |
| **Agentic Role** | Acts as the **Brain** (Reasoning engine). | Acts as the **Producer** (Writing the response). |

---

### **VI. Additional Knowledge Sources: RAG**
Wether generative or discriminative, an LMM’s knowledge is unfortunately frozen at its "training cutoff." To make use of it alongside your private or even current/new data, you need **Retrieval-Augmented Generation** (RAG). Think of RAG as giving the LMM an "Open Book" exam (in our case, a Vector Database) where he can look for answers within. Simply put:
* **The Problem to solve:** LLMs "hallucinate" when they don't know an answer.
* **The Solution (RAG):** 
    1. **Ingestion:** Take your PDFs, SQL data, and Wiki pages.
    2. **Embedding:** Convert that text into numbers (vectors) using an **Embedding Model**.
    3. **Vector Database:** Store these numbers in a specialized DB (like **Azure AI Search**).
    4. **Retrieval:** When a user asks a question, the system searches the DB for the most relevant "facts" and stuffs them into the LLM's prompt.

By storing data in the form of embeddings - which are numeric vectors representing the semantic meaning of the data - we enable semantic searches by performing mathematical operations to find similar content based on vector proximity (basically look-a-like content stays close in memory), with it being applicable to all sorts of data types like images, text, and audio files, enhancing search capabilities across domains.

> Alternatively, since RAG can prove itself complex to set, another available option is a Long Context Window, where up to 1 million plus tokens are available on prompt to enable addtional information regarding users queries. However it is very costly and has a higher latency.

---

### **VII. Integrating external systems: AI Workflows**
The next step of enabling Artificial Intelligence is, no doubt, the usage in AI Workflows, where LMMs are but components on it.

The AI Workflow can be described as a Logic App type of workflow where we're able to include multiple functions or, in this case, LMMs. By doing so, we enable API interaction, triggers and another tools usage.
It's similar to what Developers nowadays would do, by fetching data themselves and interate questions with it before copying and pasting to another systems - but with no human interaction.

```text
[ TRIGGER ] ──────────┐
(Daily @ 8am)         │
                      ▼
              [ READ EXCEL SHEET ]
              (Fetch links via Graph API)
                      │
                      ▼
              [ PERPLEXITY AI QUERY ]
              (Summarize Articles)
                      │
           ┌──────────┴──────────┐
           │ (Parallel 1)        │ (Parallel 2)
           ▼                     ▼
    [ POST LINKEDIN ]     [ POST INSTAGRAM ]
    (Draft for Review)    (Draft for Review)
           │                     │
           └──────────┬──────────┘
                      ▼
               [ REVIEW QUEUE ]
               (Human-in-the-loop)
```

However, notice that an AI Workflow still lacks autonomy compaired with the AI Agent, due to being a "Assembly Line" where the LLM is just a worker at different stations.

> Having "access" to a tool doesn't automatically make something an agent. It’s about **Agency** (the power to choose).

---

### **VIII. The Key Distinction to Agentic AI: Dynamic vs Static**
Here is a good definition based on their differences:
* **AI Workflow:** The LMM is a **component** in a predefined, hard-coded pipeline. You (the developer) define the steps in Python or a Logic App. The LLM just processes the text at each step.
* **AI Agent (LMM as Controller):** The LMM **is** the pipeline. You give it a goal, and it decides which steps to take and which tools to call.

Another set of differences are highlighted on the below table as well:

| Feature | **AI Workflow (LLM-Based)** | **AI Agent** |
| :--- | :--- | :--- |
| **Pathing** | **Deterministic:** Step A always leads to B. | **Probabilistic:** Path changes based on data. |
| **Logic** | Defined by **Code** (Python/Logic Apps). | Defined by **Reasoning** (LLM "Thoughts"). |
| **Autonomy** | Low (The "System" is in charge). | High (The "Agent" is in charge). |
| **Reliability** | High (Easier to test/predict). | Variable (Harder to "control" behavior). |
| **Tools** | Tools are called by the **Workflow code**. | Tools are called by the **LLM**. |

> Nonetheless, it's possible to integrate Agents in Workflows, by which we refer to as **Multi-Agent Collaboration** to highlight their join effort and distinction to AI Workflows.

---

### **IX. The Birth of AI Agents**
So while an **AI Workflow** is a set of "train tracks" designed by an architect, an **AI Agent** is the "autonomous vehicle" that decides which road to take to reach a destination. The "birth" of an agent occurs when we move the decision-making logic from the code/workflow into the LLM itself.

This means that an AI Agent can be defined as a Foundational Model based system that is capable of completing a goal by breaking it down into a series of steps, calling external tools, and evaluating its own progress, in an autonomous fashion using a thinking Loop:

$$Agent = \underbrace{ \left[ (LLM + Modality) \times \text{NTP} \right] }_{\text{GenAI (Brain or Engine)}} + \underbrace{Planning}_{\text{Skills}} + \underbrace{Memory}_{\text{Context/RAG}} + \underbrace{Tools\ Use}_{\text{Action Layer}}$$

We say **"Thinking" Loop:** because unlike a standard LMM that provides a single response by "running", an Agent follows a loop thinking process like the **ReAct (Reason + Act)** and **Plan-and-Execute** pattern:
    1. **Perceive:** The agent receives a goal or an observation from its last action.
    2. **Reason:** The LMM "thinks" about the current state (e.g. "I have the Excel links, but one is a dead 404 error.").
    3. **Plan:** It updates its internal to-do list (e.g. "I will skip the dead link and try to find a mirror site on Google.").
    4. **Act (Tool Use):** It invokes a tool (e.g., calling a Python script or a Search API).
    5. **Observe:** It looks at the tool output (e.g. "Google found the mirror link.").
    6. **Repeat:** The loop restarts until the goal is met.

In regards to the 
> "An Agent is a **Foundational Model** wrapped in a **Reasoning Loop** that leverages **Planning** and **Memory** to autonomously execute **Tools**."

Let's save time for Skills and Tools on the next chapter.


Therefore, Agents are the logical "Deployment" of the Foundation Model's inherent properties cafigured to take advantage of the Generative AI configuration/training:

* **From Foundation Model (The Knowledge):** The breakthrough occurred when Foundation Models became "deep" enough to understand **Intent** and **Schema**. Because they were trained on vast amounts of code (Python, SQL, Bash), they learned the "if-this-then-that" logic required for branching tasks.
* **From Generative AI (The Interface):** GenAI provided the ability to translate human language into **Structured Output (JSON/Function Calls)**. This is the "Integration" layer — the model doesn't just write code; it generates the exact payload needed to trigger an API.

This means that an agent is capable of:
* **Multi-step Reasoning:** The ability to decompose a high-level goal into a sequence of atomic tasks.
* **Tool Usage:** Using "Plugins" or "Functions" to interact with the real world (e.g., Azure SDK).
* **Self-Correction:** If an API returns a `403 Forbidden`, the agent can "reason" that it needs different credentials.

But that it also inherits the same setbacks from the Generative AI approach:
* **Hallucination in Logic:** The agent might "invent" an API parameter that doesn't exist.
  * **Infinite Loops:** An agent might get stuck in a reasoning cycle without reaching a "Stop" state.
  * **Context Window Saturation:** Agents generate a lot of internal "thought" metadata, which can quickly fill up the model's memory (Context Window).

---

#### **4. Features: Skills and Tools**
To make an Agent useful in an integration background, you must equip it with a **Toolbelt**.

* **Tools (External Integration):** These are the "Hands" of the agent. In Azure, these are typically **REST APIs**, **Python Scripts**, or **Database Connections**. You provide the agent with a JSON definition of the tool, and the LLM decides when to "invoke" it.
* **Skills (Internal Logic):** These are specialized prompts or fine-tuned behaviors. For example, an agent might have a "Cloud Security Skill" that forces it to always run a `Policy Check` before deploying a resource.
* **Memory:** * **Short-term:** The current session's conversation history.
    * **Long-term:** Usually implemented via **Vector Databases** (like Azure AI Search), allowing the agent to "remember" documentation or previous project configurations.

IMPORTANT:

LLM and LMMs are brothers.
One is specific to Test only, the other is more of a generalist.
They are just a different type of trained Foundational Modules.

The Objective (NTP/Self-Supervision): Instead of humans labeling data (expensive/slow), the model hides a part of the data from itself and tries to predict it.


* **LLM (Large Language Model):**
    $$LLM = Text \: Data \: (Modality) + Transformer \: (Architecture) + NTP \: (Goal)$$
* **LMM (Large Multimodal Model):**
    $$LMM = Multi\text{-}modal \: Data \: (Text, \: Image, \: Audio) + Transformer \: (Architecture) + Next\text{-}Token/Patch \: Prediction$$
* **Foundation Model (The Parent Class):**
    $$FM = Large\text{-}Scale \: Data + Transformer \: (Architecture) + Self\text{-}Supervised \: Learning \: (like \: NTP)$$

If you tell a stakeholder, "We are using a Foundation Model," you are describing the tier of technology (Scale + Transformer + Pre-training).
If you tell them, "We are using an LLM," you are defining the interface (Input = Text, Output = Text).



### **Communication Between Agents: MCP**
Talk also about API


(After the introduction of Agents)
### **Pratical Usage of Agents in a project: Tools and Skills**

### **Multi-Agents Workflows and Mixture of Experts**

---



### **VII. The Road to AI Agents**

An **AI Agent** is the evolution of AI from a "Communicator" to an "Actor", able to interact and do actions autonomously.


AI Agents
* AI agents operate autonomously to achieve specific goals, differing from traditional chatbots (LLMs) that respond to single prompts.
* They utilize a cycle of: 1. perception, 2. reasoning, 3. action and 4. observation to adapt and improve their performance.
* Applications include roles like travel agents, data analysts, and DevOps engineers, highlighting their versatility across various sectors.


Large Reasoning Models (LRMs)

* LRMs are specialized large language models (LLMs) fine-tuned for reasoning tasks, allowing for step-by-step problem solving.
* They are trained on problems with verifiable solutions, like math and coding challenges, enhancing their ability to generate correct answers.
* The reasoning process in LRMs is evident when chatbots pause to "think," indicating internal reasoning before responding.






Model Context Protocol (MCP)

* MCP standardizes the interaction between large language models and external data sources, facilitating more efficient connections.
* It allows LLMs to access various systems, such as databases or email servers, without needing custom integration for each application.
* This standardized approach simplifies the development process and broadens the utility of AI models across different platforms.


Mixture of Experts (MoE)

* MoE architecture divides a model into specialized subnetworks (experts) that are activated selectively based on the task requirements.
* This mechanism optimizes model performance by merging outputs from only the relevant experts, reducing computational costs.
* MoE frameworks, like IBM Granite's 4.0 series, allow extensive parameter counts while activating only a fraction during inference, enhancing efficiency.
