### **I. The Hierarchy of Intelligence**
The AI technology is best understood as a series of nested layers, with each subsequent field being a specialized subset of the previous one. Currently, we have 3 main categories, mainly:

1.  **Artificial Intelligence (AI):** The broadest field. Its goal is to simulate human intelligence—specifically the ability to **learn, infer, and reason**—using a computer [[01:31](http://www.youtube.com/watch?v=qYNweeDHiyU&t=91)].
    * **Logical Goal:** To match or exceed human cognitive functions.
    * **Setbacks:** These were rigid and only as smart as the rules a human wrote for them.
2.  **Machine Learning (ML):** A subset of AI where the machine "learns" from patterns in data without being explicitly programmed for a specific task [[02:54](http://www.youtube.com/watch?v=qYNweeDHiyU&t=174)].
    * **Logical Goal:** Discovering hidden patterns and making predictions.
    * **Setbacks :** Highly dependent on training data and not able to process unusual outcomes (hence being used to detect odd behaviour instead).
3.  **Deep Learning (DL):** A subset of ML that uses **multi-layered neural networks** to mimic the human brain’s structure to process complex data [[04:54](http://www.youtube.com/watch?v=qYNweeDHiyU&t=294)].
    * **Logical Goal:** Mimic the brain’s "unpredictable" yet highly effective processing power.
    * **Setbacks:** The black box logic, because there are so many layers, it is often difficult to decompose or explain exactly *why* a model reached a specific result.

---

### **II. The Foundation Model (The "Generalist" DL)**
From the Deep Learning Intelligence approach - usage of Neural networks - came the concept of Foundational Model, which shares the same algorithm, but with increased neural depth, a much bigger data pool (all text) and more general goal, leading to be defined as a massive Deep Learning model that has finished its "General Education" (pre-training). As such, its a persistent, reusable asset that can be adapted to hundreds of different tasks (called "*finetunning*").
Below you can find a comparisson of both:

| Feature | Traditional Deep Learning Model | Foundation Model (LLMs, etc.) |
| :--- | :--- | :--- |
| **Training Scope** | **Task-Specific:** You train a model specifically to detect "Hard Hats" in images. | **Generalist:** The model is trained on "everything" to understand the concept of images/text. |
| **Data Requirement** | Requires **Labeled Data** (e.g., thousands of photos tagged "Hard Hat"). | Uses **Self-Supervised Learning** on massive unlabeled data (the internet). |
| **Architectural Choice** | Can be many types (CNNs, RNNs, LSTMs). | Almost exclusively **Transformers** (a specific DL architecture). |
| **Reusability** | Low. A hard-hat detector can't suddenly write a poem. | **High.** One model (GPT-4) can write code, summarize text, and act as a logic engine. |

Although different, the classification of GenAI and LLMs (both based on Foundational Models) as Deep Learning is based on 3 specific technical characteristics:

#### **1. Neural Network Architecture**
Deep Learning is defined by the use of **artificial neural networks** with many layers (hence "deep"). 
* **LLMs:** These are built using the **Transformer architecture**, which is a specific type of deep neural network. 
* **Depth:** Modern LLMs (like GPT-4 or Llama 3) have hundreds of layers and billions of parameters. This massive "depth" is what allows them to understand complex linguistic nuances.

#### **2. Feature Representation Learning**
In traditional Machine Learning, a human often has to define "features" (e.g., in a house price model, features might be "square footage" or "zip code"). 
* **DL Characteristic:** Deep Learning models learn to extract features themselves from raw data. 
* **LLM Application:** An LLM doesn't need to be told what a "verb" or "sarcasm" is; it learns these abstract representations autonomously by processing trillions of tokens during training.

#### **3. The Training Paradigm**
GenAI and LLMs utilize the core mathematical engines of Deep Learning: **Backpropagation** and **Gradient Descent**.
* They learn by calculating the "error" (loss) between their predicted next word and the actual word in the training text, then updating their internal weights across all layers to minimize that error.

A good closing remark is that **AI is the Simulation Layer**, **ML the Pattern Layer**, **DL the Neural Layer** and **GenAI the Creative Layer**.

---

### **III. Foundation Models, Large Language Models and Generative AI**

The Large Language models (LLMs) are nothing more than a subset of Foundational Models that interpret Language (by splitting them into tokens and converting those into a number) to understand a prompt to reach a specific outcome. Kin to it, would be the Vision Foundation Models (for images) and the Audio Language Models (for Sound), that together would be enabled by Large Multimodal Models (LMMs).

$$\text{LLM} = \underbrace{\text{Text Data}}_\text{Modality} + \underbrace{\text{Transformer Architecture}}_\text{Deep Learning} + \underbrace{\text{Next-Token Prediction}}_\text{Training Goal}$$

Similarly to how a database doesn't "understand" a string - it understands data types - the Foundation Model doesn't "read" and write text either, leading to the following interpretation of the equation: 
* **The Modality ("Text-to-Input") phase:** This is the **Tokenizer** function. It translates human language into numerical vectors (embeddings) that the Foundation Model can process to both read and write.
* **The "Foundational" phase:** This is the **Transformer** function. It uses its deep learning layers to calculate the relationship between those numbers across many layers.
* **Next "Prediction" (NTP) phase:** An objective function that drives the entire learning process of an LLM. It is a form of Self-Supervised Learning where the data provides its own labels, instead of human labels like in traditional DL.
  
The model is not "taught" facts through the Next Token Prediction. Instead, it is given a massive corpus of text and asked millions of times: *"Given these $n$ tokens, what is the most statistically probable $(n+1)$ token?"*
* **The Input:** "The Azure Architect deployed a..."
* **The Target:** "...service."
* **The Adjustment:** If the model guesses incorrectly, the **Deep Learning** backpropagation adjusts the internal weights to make the correct answer more likely next time.

It's in the Next Token Prediction (NTP) that lays the core distinction between Generative AI and the traditional type of AI, since the training can be used to either generate new combinations (generative) or to identify mistakes (discriminate).

---

### **IV. The Logical Distinction: Discriminative vs. Generative**
While all Foudational Models are Deep Learning Models, not all Deep Learning is Generative. 

| Feature | Discriminative DL (Traditional) | Generative DL (LLMs/GenAI) |
| :--- | :--- | :--- |
| **Objective** | **Classify or Predict:** Is this a cat or a dog? Is this transaction fraudulent? | **Create:** Write a poem about a cat; generate a Python script for an Azure Function. |
| **Logic** | Learns the **boundary** between data classes. | Learns the **probability distribution** of the data itself. |
| **Output** | A label or a numerical value ($y$). | New data that looks like the training data ($\hat{x}$). |

Because of these differences, notice that **Generative AI is any type of DL that generates new content**, meaning that **it's a category** and not as much of a subset of DL per say.
Although, we can say that **LLMs are a subset of LMMs**.

---

### **V. Foudational Model vs Generative AI**
On the same note as before, It's important to highlight that these aren't the same thing. Foundation Model refers to the architecture of the model (Infrastructure), while Generative AI refers to the capability of that model to generate inexisting content (App). 

To better translate this, on Azure terms, is the same as comparing the Virtual Machine (that hosts applications) to a Web App (that is the product of being hosted on a VM):

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
    1.  **Ingestion:** Take your PDFs, SQL data, and Wiki pages.
    2.  **Embedding:** Convert that text into numbers (vectors) using an **Embedding Model**.
    3.  **Vector Database:** Store these numbers in a specialized DB (like **Azure AI Search**).
    4.  **Retrieval:** When a user asks a question, the system searches the DB for the most relevant "facts" and stuffs them into the LLM's prompt.

By storing data in the form of embeddings - which are numeric vectors representing the semantic meaning of the data - we enable semantic searches by performing mathematical operations to find similar content based on vector proximity (basically look-a-like content stays close in memory), with it being applicable to all sorts of data types like images, text, and audio files, enhancing search capabilities across domains.

> Alternatively, since RAG can prove itself complex to set, another available option is a Long Context Window, where up to 1 million plus tokens are available on prompt to enable addtional information regarding users queries. However it is very costly and has a higher latency.

---

### **VII. AI Workflows**
The next step of enabling LMMs is, no doubt, the usage in AI Workflows.


### **VII. Additional Knowledge Sources: Long Context Window**

---

Issues with RAG assisted LMMs: 

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





Retrieval-Augmented Generation (RAG)

* RAG leverages vector databases to enrich prompts sent to LLMs by retrieving relevant information to improve responses.
* It converts input prompts into vectors, performs similarity searches, and embeds the retrieved information back into the original prompt.
* This method enhances the context and relevance of AI-generated responses, particularly in specialized inquiries.
* The way it works is that Prompt is read by LLM -> Retriever <-> Embedding model (translates to a vector index) -> Vector DB


Model Context Protocol (MCP)

* MCP standardizes the interaction between large language models and external data sources, facilitating more efficient connections.
* It allows LLMs to access various systems, such as databases or email servers, without needing custom integration for each application.
* This standardized approach simplifies the development process and broadens the utility of AI models across different platforms.


Mixture of Experts (MoE)

* MoE architecture divides a model into specialized subnetworks (experts) that are activated selectively based on the task requirements.
* This mechanism optimizes model performance by merging outputs from only the relevant experts, reducing computational costs.
* MoE frameworks, like IBM Granite's 4.0 series, allow extensive parameter counts while activating only a fraction during inference, enhancing efficiency.
