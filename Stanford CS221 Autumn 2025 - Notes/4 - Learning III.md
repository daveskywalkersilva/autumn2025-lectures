---

# Stanford CS221 — Lecture 4: Learning III — Deep Learning (Autumn 2025)
**Instructor:** Percy Liang | **Course:** Artificial Intelligence: Principles and Techniques

---

## Recap: Linear Classification

- **Prediction task:** input → discrete label (one of $K$ classes)
- **Hypothesis class:** linear functions (logits) → softmax → probabilities
- **Loss function:** logistic / cross-entropy loss
- **Limitation:** linear models can only separate data with a hyperplane — they fail when data is **non-linearly separable**

This lecture: move beyond linear models to **deep neural networks**.

---

## PyTorch Basics

In practice, use **PyTorch** (or JAX) instead of raw NumPy + custom autograd:
- PyTorch = NumPy + **automatic differentiation** + **pre-defined modules**
- `torch.tensor` objects are nodes in the computation graph
- Gradients flow automatically: just call `.backward()` on the loss
- `requires_grad=True` marks which tensors are parameters to optimise
- Use `torch.no_grad()` at inference / test time — no gradient tracking needed
- Use `.detach()` to cut a node out of the computation graph (stop gradient flow there)

**The standard PyTorch ML loop:**
```
model  = nn.Linear(...)          # define architecture
loss_fn = nn.CrossEntropyLoss()  # define loss
optimizer = torch.optim.SGD(model.parameters(), lr=0.1)

for step in range(num_steps):
    logits = model(x)            # forward pass
    loss = loss_fn(logits, y)    # compute loss
    loss.backward()              # backward pass
    optimizer.step()             # update parameters
    optimizer.zero_grad()        # reset gradients
```

---

## Why Non-Linear Models?

Linear classifiers produce **hyperplane** decision boundaries. Real data is often not linearly separable.

**Key insight:** a linear classifier applied to a **non-linear feature map** $\phi(\mathbf{x})$ is effectively a non-linear classifier in the original input space.

$$\text{logit} = \mathbf{w} \cdot \phi(\mathbf{x}) + b$$

Example: map $(x_0, x_1) \to (x_0,\, x_1,\, x_0^2 + x_1^2)$ turns a circular boundary into a linear one in the transformed space.

**Drawback of fixed feature maps:** the features are hand-designed. Can we **learn the feature map** from data too?

---

## Multi-Layer Perceptron (MLP)

### 1. Why Two Linear Layers Are Still Linear

Adding a second linear layer on top of a first linear layer **does not increase expressivity:**

$$(\mathbf{x} \cdot W_1) \cdot W_2 = \mathbf{x} \cdot (W_1 W_2) = \mathbf{x} \cdot W$$

Matrix multiplication is associative — two stacked linear layers collapse into one. The composition of linear functions is linear.

### 2. The Fix: Non-linear Activation Functions

Insert a non-linear function between layers. This breaks the associativity and makes the model truly non-linear.

Popular activation functions:

| Activation | Definition | Notes |
|---|---|---|
| **Sigmoid** | $\sigma(x) = \frac{1}{1+e^{-x}}$ | Outputs $(0,1)$; vanishing gradients for large $\|x\|$ |
| **Tanh** | $\tanh(x)$ | Outputs $(-1,1)$; zero-centred |
| **ReLU** | $\max(0, x)$ | Simple, fast; risk of "dead neurons" |
| **Leaky ReLU / GeLU / Swish** | Variants of ReLU | Avoid zero gradient on negative side |

**Dead neuron problem (ReLU):** if the input to a ReLU neuron is always $\leq 0$, the gradient is always zero — the neuron stops learning entirely. Use GeLU or Swish to mitigate.

**Tradeoff:** more non-linear = more expressive, but harder to optimise due to gradient issues.

### 3. The MLP Architecture

$$\mathbf{x} \xrightarrow{\text{Linear}} \xrightarrow{\text{ReLU}} \mathbf{h} \xrightarrow{\text{Linear}} \mathbf{logits}$$

- $\mathbf{h}$ = **hidden layer** (also called activations, hidden units, or neurons)
- The first linear layer is a **learned feature map**
- The second linear layer is a **learned linear classifier** on those features
- Parameters: $W_1 \in \mathbb{R}^{d \times h},\, W_2 \in \mathbb{R}^{h \times K}$ plus biases

> *"Terminology: activations = hidden units = neurons"*

---

## Deep Neural Networks (DNNs)

Stack multiple MLP layers:

$$\mathbf{x} \xrightarrow{L_1} \mathbf{h}_1 \xrightarrow{L_2} \mathbf{h}_2 \xrightarrow{\cdots} \xrightarrow{L_n} \mathbf{logits}$$

**Intuition:** each layer learns increasingly **abstract features** of the input.
- Layer 1: edges and textures (for images)
- Layer 2: shapes and parts
- Layer 3+: objects and concepts

More layers = more representational power, but training becomes harder due to the **vanishing / exploding gradient problem**.

---

## The Vanishing / Exploding Gradient Problem

The single most important practical challenge in training deep networks.

### What It Is

During backpropagation, gradients are multiplied together across all layers via the chain rule. With $L$ layers each multiplying by weight $w$:

$$\text{gradient at input} = w^L \cdot \text{gradient at output}$$

- If $|w| < 1$: gradient **vanishes** to zero → early layers stop learning
- If $|w| > 1$: gradient **explodes** to infinity → training becomes unstable

The same holds for matrices: stability requires eigenvalues of weight matrices close to 1.

### Four Solutions

#### 1. Activation Function Choice
Avoid activations with near-zero gradients far from zero (e.g., sigmoid saturates). Use ReLU/GeLU/Swish which have non-zero gradients across a larger range.

#### 2. Residual Connections (He et al., 2015 — ResNets)
Instead of each layer computing $\mathbf{x} \to f(\mathbf{x})$, compute:

$$\mathbf{x} \to \mathbf{x} + f(\mathbf{x})$$

For $f(\mathbf{x}) = W\mathbf{x}$, the layer effectively computes $\mathbf{x} \to (1 + W)\mathbf{x}$, keeping the multiplier away from zero. Gradients can always flow back through the identity path. Used in ResNets (vision) and Transformers.

#### 3. Layer Normalisation (Ba et al., 2016)
Normalise the activations within each layer to have **zero mean and unit variance**, then apply a learned scale and shift:

$$\text{LayerNorm}(\mathbf{x}) = \gamma \cdot \frac{\mathbf{x} - \mu}{\sigma} + \beta$$

- $\mu, \sigma$ computed across the features of a single example
- $\gamma, \beta$ are **learned** parameters
- Keeps activation magnitudes bounded regardless of depth
- Prevents activations from drifting toward $0$ or $\infty$
- Used in every modern Transformer block

*(See also: **Batch Normalisation** — normalises across the batch dimension instead of the feature dimension)*

#### 4. Proper Weight Initialisation
Randomly initialised weights with standard normal distribution scale as $\sqrt{d}$ (where $d$ = input dimension), causing activations to grow:

**Fix — scale by $\frac{1}{\sqrt{d_{\text{in}}}}$:**

$$W \sim \mathcal{N}\left(0,\, \frac{1}{d_{\text{in}}}\right)$$

This keeps the variance of activations constant regardless of layer width. Use **truncated normal** to reduce the chance of outlier initialisations.

---

## Optimisers Beyond Gradient Descent

### 1. Stochastic Gradient Descent (SGD)
**Problem with full GD:** each update requires summing the gradient over the entire dataset — too expensive for large datasets.

**SGD fix:** at each step, sample a random **mini-batch** of examples and use their average gradient as an unbiased estimate of the true gradient.

$$\hat{\nabla}\mathcal{L}(\mathbf{w}) = \frac{1}{B} \sum_{i \in \text{batch}} \nabla \mathcal{L}_i(\mathbf{w})$$

- **Batch size $B$:** larger batches = more accurate gradient but slower per step; smaller = noisier but more frequent updates
- In practice: shuffle the dataset, split into batches, iterate through all batches each **epoch**

### 2. Adam (Kingma & Ba, 2014)
A **fancier** optimiser that adapts the learning rate per parameter:

- Maintains a running average of gradients (**momentum**) — smooths noisy gradients
- Maintains a running average of **squared gradients** — scales the update inversely by the typical gradient magnitude
- Parameters with consistently large gradients get smaller effective learning rates; sparse gradients get larger ones
- In practice, **Adam converges faster** and is more robust to learning rate choice than plain SGD
- Standard choice for training deep networks and transformers

---

## Summary: The Deep Learning Toolkit

| Challenge | Solution |
|---|---|
| Non-linearity needed | Activation functions (ReLU, GeLU, Swish) |
| Dead neurons | Leaky ReLU / GeLU / Swish |
| Vanishing/exploding gradients | Residual connections |
| Activation magnitude drift | Layer normalisation |
| Poor gradient flow from init | Scaled initialisation ($1/\sqrt{d}$) |
| Slow/expensive gradient computation | Mini-batch SGD |
| Slow convergence, sensitivity to LR | Adam optimiser |

The full deep learning pipeline:

$$\text{input} \xrightarrow{\text{Linear + ReLU}} \cdots \xrightarrow{\text{Residual + LayerNorm}} \cdots \xrightarrow{\text{Linear}} \text{logits} \xrightarrow{\text{CrossEntropy}} \text{loss} \xrightarrow{\text{Adam}} \text{update}$$

---

## Key Takeaways

1. **Two stacked linear layers are still linear** — non-linear activation functions are essential for expressivity
2. **MLP:** learned feature map (first layer) + linear classifier (second layer) — the feature map is no longer hand-designed
3. **Deep networks** learn a hierarchy of increasingly abstract features
4. The **vanishing/exploding gradient problem** is the central obstacle to training deep networks
5. **Residual connections** solve vanishing gradients by always providing a direct gradient path back
6. **Layer normalisation** keeps activation magnitudes stable throughout training
7. **Weight initialisation** should scale as $1/\sqrt{d_{\text{in}}}$ to keep activations bounded at the start
8. **Adam** is the default optimiser for deep learning — more robust and faster than plain SGD