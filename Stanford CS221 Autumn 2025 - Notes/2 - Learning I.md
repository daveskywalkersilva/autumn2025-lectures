---

# Stanford CS221 — Lecture 2: Learning I (Autumn 2025)
**Instructor:** Percy Liang | **Course:** Artificial Intelligence: Principles and Techniques

---

## Recap: Tensors

- Tensors are the **atoms of modern machine learning** — used to represent everything: data, parameters, gradients, activations
- **`einsum`:** a single general operation that expresses most tensor computations (dot products, outer products, matrix multiplications) through named axis notation
- Rule: for each assignment of input axes, **multiply** the corresponding elements and **add** the result to the corresponding output element

---

## Gradients

> *"Gradients of objective functions tell us how to improve the function."*

### 1. The Derivative (1D)
- For $f(x) = x^2$, the derivative is $\frac{df}{dx} = 2x$
- **Definition:** as $\Delta x \to 0$, the derivative is $\frac{f(x + \Delta x) - f(x)}{\Delta x}$
- **Graphically:** the slope of the tangent line at point $x$

### 2. Partial Derivatives (Multi-dimensional)
- For a function $f(x_1, x_2)$, the **partial derivative** $\frac{\partial f}{\partial x_i}$ measures how much $f$ changes when we change only $x_i$
- Example: $f(x_1, x_2) = (x_1 + x_2)^2$ → $\frac{\partial f}{\partial x_1} = 2(x_1 + x_2)$

### 3. The Gradient
- The **gradient** $\nabla f$ is the full tensor of partial derivatives — it has the **same shape as the input**
- It points in the direction of **steepest increase** of the function
- To minimise a function: move in the **opposite direction** of the gradient

### 4. Where Gradients Are Used
- Optimising parameters of a deep learning model
- Optimising an input image to maximise error (**adversarial examples**)
- Optimising relative proportions across datasets

---

## Computation Graphs and Backpropagation

> *"Even the most complex functions are composed out of basic operations: addition, multiplication, exp, log, etc."*

### 1. The Problem
- Computing gradients manually for complex functions is tedious and error-prone
- We need a systematic, automatic method

### 2. Computation Graphs
- A **computation graph** is a directed acyclic graph (DAG) where:
  - **Leaf nodes** = inputs (fixed values, e.g., `x1`, `x2`)
  - **Non-leaf nodes** = primitive operations (Add, Multiply, Squared, etc.) performed on their dependencies
  - **Root node** = the final output (e.g., the loss)
- Each node stores:
  - `value` — computed during the **forward pass**
  - `grad` — accumulated during the **backward pass**

### 3. The Chain Rule
- The mathematical foundation of backpropagation
- For a composed function $f(g(x))$:

$$\frac{df}{dx} = \frac{df}{dg} \cdot \frac{dg}{dx}$$

- For multi-path graphs, partial derivatives from all paths into a node are **summed**

### 4. Backpropagation Algorithm
- First introduced by Werbos (1974); popularised by Rumelhart, Hinton & Williams (1986)
- **Two passes:**

| Pass | Direction | What Happens |
|---|---|---|
| **Forward pass** | Leaves → Root | Each node computes its `value` from its dependencies |
| **Backward pass** | Root → Leaves | Each node propagates `grad` back to its dependencies using the chain rule |

- **Initialisation:** root node's `grad = 1` (we want $\frac{d(\text{root})}{d(\text{root})} = 1$); all others start at `0`
- **`node.backward()`:** updates the partial derivatives of the node's dependencies, assuming `node.grad` and all `value`s are already computed
- Traversal order is determined by **topological sort**

### 5. Why This Works
- Every complex loss function is a composition of primitive ops
- Each primitive op knows its own local derivative
- Backpropagation chains these local derivatives together automatically
- Modern libraries (PyTorch, JAX) do this automatically — you define the forward pass and get gradients for free

---

## The Machine Learning Pipeline

> *"A learning algorithm takes training data and produces a predictor."*

The full ML pipeline has three core design decisions:

| Decision | Question | Answer |
|---|---|---|
| **Hypothesis class** | Which predictors are possible? | Defines the model architecture |
| **Loss function** | How good is a predictor? | Measures fit to training data |
| **Optimisation algorithm** | How do we find the best predictor? | Minimises the loss |

### 1. The Prediction Task
- A **predictor** is a function: input → output
- Example: predict exam score from hours studied
  - Input: number of hours (e.g., `3`)
  - Output: score (e.g., `70`)
- A predictor with fixed parameters is just one function; we need to **learn** the best one from data

### 2. Training Data
- A **training set** is a collection of $(x, y)$ pairs (input, output)
- The learning algorithm uses this data to select parameters
- More data generally leads to better generalisation

### 3. Hypothesis Class — *Which predictors are possible?*
- A **hypothesis class** is the set of all predictors the learning algorithm is allowed to consider
- Defined by a **model architecture** (the shape of the function) plus a free **parameter** vector $\mathbf{w}$
- **Linear predictor:** $f_\mathbf{w}(x) = w \cdot x + b$
  - Architecture = "linear function"
  - Parameters = weight $w$ and bias $b$
- Choosing a hypothesis class is a design decision: too simple → **underfitting**; too complex → **overfitting**

> *"Hypothesis class is a model architecture. A predictor is a model."*

### 4. Loss Function — *How good is a predictor?*
- A **loss function** measures how bad a predictor is on a single example
- For linear regression: **squared loss**

$$\text{loss}(\mathbf{w}, x, y) = (f_\mathbf{w}(x) - y)^2 = (\mathbf{w} \cdot x - y)^2$$

- The **training loss** (also called empirical risk) is the **average loss** over all training examples:

$$\mathcal{L}(\mathbf{w}) = \frac{1}{n} \sum_{i=1}^{n} (f_\mathbf{w}(x_i) - y_i)^2$$

- Lower training loss = parameters fit the data better

### 5. Optimisation Algorithm — *How do we find the best parameters?*

#### Gradient Descent

The key insight: the gradient $\nabla \mathcal{L}(\mathbf{w})$ points in the direction that **increases** the loss most. So to decrease loss, step in the **opposite direction**.

**Update rule:**

$$\mathbf{w} \leftarrow \mathbf{w} - \eta \cdot \nabla \mathcal{L}(\mathbf{w})$$

Where $\eta$ (eta) is the **learning rate** — a hyperparameter controlling step size.

**Algorithm:**
```
initialise w
repeat:
    compute gradient of training loss w.r.t. w
    update: w = w - learning_rate * gradient
until convergence
```

**Key properties:**
- **Learning rate** controls speed vs. stability: too high → overshoots; too low → slow convergence
- **Guaranteed to converge** for convex functions (e.g., linear regression with squared loss)
- **Not guaranteed** to find the global minimum for non-convex functions (e.g., deep networks)
- Variants: **SGD** (one example at a time), **mini-batch SGD**, **Adam** (adaptive learning rates)

---

## Summary

The **full ML pipeline** for linear regression connects all pieces:

1. Define a **hypothesis class** (linear functions parameterised by $\mathbf{w}$)
2. Define a **loss function** (squared loss, averaged over training data)
3. Run **gradient descent** using **backpropagation** to compute gradients efficiently
4. Output the learned **predictor** $f_{\mathbf{w}^*}$

---

## Key Takeaways

1. The **gradient** is the direction of steepest ascent — move opposite to it to minimise a function
2. **Computation graphs** decompose any complex function into primitive operations
3. **Backpropagation** = forward pass (compute values) + backward pass (propagate gradients via chain rule)
4. The **three design decisions** of ML: hypothesis class, loss function, optimisation algorithm
5. **Linear regression** = linear hypothesis class + squared loss + gradient descent
6. **Learning rate** is the most critical hyperparameter in gradient descent — it controls the speed/stability tradeoff
7. Modern autograd libraries (PyTorch, JAX) automate backpropagation — you only write the forward pass