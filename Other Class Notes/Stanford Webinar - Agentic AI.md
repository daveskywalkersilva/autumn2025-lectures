These notes summarize the Stanford Webinar on **Agentic AI**, focusing on the progression from standard Large Language Models (LLMs) to autonomous agents.
**Watch the full webinar here:** [https://www.youtube.com/watch?v=kJLiOGle3Lw](https://www.youtube.com/watch?v=kJLiOGle3Lw)

### **I. Concept Definitions: From LLM to Agent**
The webinar defines Agentic AI not as a new technology, but as a **progression of usage**.

* **Large Language Model (LLM):** A machine learning model that predicts the next token in a sequence based on probabilities learned from a massive corpus [[00:46](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=46)].
* **Agentic AI:** An LLM system that can **interact with its environment**. Unlike a standard LLM (Text In $\rightarrow$ Text Out), an agent uses the LLM as a "reasoning engine" to perform actions, observe results, and iterate [[29:22](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=1762)].
* **The "ReAct" Pattern (Reason + Act):** The core logic of an agent. It **Reasons** (plans what to do) and then takes an **Action** (calls a tool or searches for info) [[31:05](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=1865)].

Notice that **Google Gemini 3.5** and **OpenAI’s GPT-5** are both LLMs because they still function on the same principles of LLMs, like:
* **Next-Token Prediction:** They are trained to predict the next piece of information in a sequence.
* **Transformers:** They use the transformer architecture (or evolved versions of it) to process and generate data.
* **Reasoning Engines:** In an agentic workflow, these models serve as the "brain" that handles the logic and planning. 

But they were also **designed specifically to support the Agentic AI** we are learning about (hence being also called **Agentic Foundation Models**):
* **Native Multimodality:** Unlike GPT-3.5, which was text-only, Gemini 3.5 and GPT-5 are "natively multimodal." They don't just translate images into text to understand them; they "see" pixels and "hear" audio directly.
* **Built-in "Agentic" Planning:** These models are fine-tuned for Advanced Reasoning (DeepThink). They are better at the "Plan" phase of the ReAct (Reason + Act) cycle, meaning they are less likely to get lost in complex, multi-step tasks.
* **Native Tool Use:** Older LLMs often struggled with the syntax of calling external APIs. These newer models are optimized for "Function Calling," making them much more reliable when your Python code needs to interact with Azure resources or databases. 

**In summary:** They are LLMs by definition, but they are Agentic Models by design. They are the "logic processors" you will use to build the autonomous systems on.

---

### **II. Addressing LLM Limitations**
In the webinar, its highlighted critical limitations of standalone LLMs and how architectural patterns solve them:

1.  **Hallucinations & Knowledge Cutoff:** Solved via **RAG (Retrieval-Augmented Generation)**. By providing a "reference" (private docs or web search), the model is forced to answer based on facts rather than memory [[23:36](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=1416)].
2.  **Lack of Computation Skills:** Solved via **Tool Usage**. The LLM generates a function call (e.g., `get_weather` or `calculator`) which an external software "scaffold" executes [[28:14](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=1694)].
3.  **Complex Task Failure:** Solved via **Chaining & Planning**. Breaking one big request into small, verifiable steps [[13:32](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=812)].

These additions were the turning point to the improved Agentic AI models, currently used.

---

### **III. Versus Scenarios: Standard vs. Agentic Workflow**

| Feature | Standard LLM Usage | Agentic AI Usage |
| :--- | :--- | :--- |
| **Interaction** | One-shot: Input $\rightarrow$ Output [[06:13](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=373)]. | Iterative: Loops until the task is done [[35:17](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=2117)]. |
| **Capabilities** | Limited to internal training data [[21:42](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=1302)]. | Can use external tools (APIs, Python, Search) [[27:14](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=1634)]. |
| **Reasoning** | Direct response (may hallucinate) [[10:31](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=631)]. | Breaks down complex tasks into a multi-step plan [[32:04](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=1924)]. |
| **Correction** | User must manually correct and re-prompt. | **Self-Reflection**: The agent reviews its own work and fixes it [[39:35](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=2375)]. |

For instance, compaired with the non-agentic model gpt-3.5, it lacks:
1. **Autonomy: The "Goal" Iteractive Behavior**
     * **GPT-3.5 (Standard LLM):** Acts like an **obedient intern**. It waits for a specific command ("Write a script to list VMs") and stops once the script is written. It has no concept of the "End Goal"—if the script fails to run, it's your job to tell it.
     * **Agentic Model:** Acts like an **autonomous contractor**. You give it a high-level goal ("Reduce our Azure dev costs by 20%"). It autonomously creates a plan, identifies idle resources, suggests a shutdown schedule, and asks for your approval to execute the changes. It manages the **state** of the project until the 20% goal is met.

2. **Capabilities: Tool Usage**
      * **GPT-3.5 (Standard LLM):** Acts like a **creative writer** trying to write code. It often "guesses" what an API looks like, leading to broken JSON or invented parameters. If an API returns an error, GPT-3.5 usually apologizes but repeats the same mistake in the next turn.
      * **Agentic Model:** Acts like a **senior developer**. It has a high "Tool Fidelity," meaning it treats function calls as strict protocols. If an Azure API returns a `403 Forbidden`, the agentic model doesn't just apologize; it proactively tries an alternative method, like checking the `Managed Identity` permissions.

3. **Reasoning: The "Thinking" Behavior**
     * **GPT-3.5 (Standard LLM):** Acts like a **fast typist**. It begins responding immediately, predicting the most likely next word. Because it doesn't "think ahead," it often commits to a logical path in the first sentence that leads to a dead end or a hallucination by the third sentence.
     * **Agentic Model:** Acts like a **chess player**. It uses "Inference-Time Reasoning" (DeepThink) to simulate multiple solutions internally before typing a single word. It will explicitly call out dependencies—for example, "I cannot migrate this database until I first verify the Azure region's vCPU quota."

---

### **IV. Agentic Design Patterns**
As an architect, these are the core architecture patterns to implement in your projects leveraging Agentic AI:

* **Reflection:** A pattern where the system asks the LLM to generate an initial draft, then asks it (or another model) to critique that draft, and finally produces a revised version [[40:27](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=2427)].
* **Planning:** The agent receives a high-level goal (e.g., "Research and write a report on Azure cost optimization"), creates a list of sub-tasks, and executes them sequentially [[31:58](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=1918)].
* **Multi-Agent Collaboration:** Assigning different "Personas" to different LLM calls (e.g., a "Coder" agent and a "Reviewer" agent) to work together on a single task [[42:05](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=2525)].

---

### **V. Logical Progression for Implementation**
The webinar suggests a "Start Simple" logic for developers [[53:30](http://www.youtube.com/watch?v=kJLiOGle3Lw&t=3210)]:
1.  **Playground:** Test your prompts in a UI first to see if the model can reason through the task.
2.  **API Calls:** Move to simple programmatic calls using standard prompting best practices (Chain of Thought, Few-Shot examples).
3.  **Agentic Frameworks:** Only move to complex agent frameworks (like LangChain or AutoGen) once you understand the underlying reasoning/action loop.
