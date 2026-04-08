---

# Stanford CS221 — Lecture 3: Learning II (Autumn 2025)
**Instructor:** Percy Liang | **Course:** Artificial Intelligence: Principles and Techniques

---

## Recap: Linear Regression

- **Prediction task (regression):** input → real number output
- **Hypothesis class:** linear functions parameterised by weight vector $\mathbf{w}$ and bias $b$
- **Loss function:** squared loss; **Optimisation:** gradient descent

This lecture extends the same three-decision framework to **classification**.

---

## Linear Classification

### 1. The Prediction Task — Classification

Rather than predicting a continuous number, classification predicts a **discrete label** from $K$ choices.

- **Binary classification:** output $y \in \{-1, +1\}$
  - Example: is this image a cat? Is this review positive?
- **Multiclass classification:** output $y \in \{0, 1, \ldots, K-1\}$
  - Example: which digit (0–9) is in this image?

Input types:
- Image → width × height × 3 (RGB) tensor
- Text → a string (not naturally a tensor — covered later in this lecture)

### 2. Hypothesis Class — Linear Classifiers

A **linear classifier** computes a raw score called the **logit**, then thresholds it:

$$\text{logit} = \mathbf{w} \cdot \mathbf{x} + b$$

$$\hat{y} = \begin{cases} +1 & \text{if logit} > 0 \\ -1 & \text{otherwise} \end{cases}$$

- The **decision boundary** is the set of points where $\text{logit} = 0$ — a hyperplane (a straight-line cut of the input space)
- Changing parameters $(\mathbf{w}, b)$ moves and rotates this boundary
- **Logit:** sign = prediction, magnitude = confidence

### 3. Key Concept: The Margin

$$\text{margin} = \text{logit} \times y_{\text{target}}$$

- **Positive margin** → prediction is correct
- **Negative margin** → prediction is wrong
- The margin is the central quantity for defining classification losses

---

## Loss Functions for Classification

### 1. Zero-One Loss — The Natural Choice

$$\text{loss}_{0/1} = \mathbf{1}[\text{margin} \leq 0] = \begin{cases} 1 & \text{if wrong} \\ 0 & \text{if right} \end{cases}$$

- Directly measures the **error rate** — exactly what we care about
- Training loss = average zero-one loss = **error rate**

**Fatal flaw:** the gradient of the zero-one loss is **zero almost everywhere**

- The loss is a flat step function — moving parameters by a small amount when a prediction is wrong does not change the loss at all
- Gradient descent cannot update the parameters; the optimiser gives up

### 2. The Logistic Function — Bridge to Probability

To fix the zero-gradient problem, replace the hard threshold with a **soft, differentiable output**.

The **logistic function** (sigmoid) maps any logit to a probability:

$$\sigma(z) = \frac{1}{1 + e^{-z}} \in (0, 1)$$

Key properties:
- $z \to -\infty \Rightarrow \sigma(z) \to 0$
- $z \to +\infty \Rightarrow \sigma(z) \to 1$
- $z = 0 \Rightarrow \sigma(z) = 0.5$
- $\sigma(z) + \sigma(-z) = 1$ (probabilities sum to 1)
- **Derivative:** $\frac{d\sigma}{dz} = \sigma(z)(1 - \sigma(z))$ — elegant and non-zero everywhere

**Interpretation:** logit = log-odds, i.e., $z = \log \frac{p}{1-p}$

### 3. Logistic Loss — The Fix

Instead of outputting a hard $\{-1, +1\}$, the model now outputs a **probability distribution** over labels.

Using the **maximum likelihood principle** — maximise the log probability of the correct targets:

$$p(y = y_{\text{target}} \mid \mathbf{x}) = \sigma(\text{margin}) = \sigma(\text{logit} \times y_{\text{target}})$$

Negate the log probability to turn maximisation into a loss to minimise:

$$\text{loss}_{\text{logistic}} = -\log \sigma(\text{margin}) = \log(1 + e^{-\text{margin}})$$

Comparing the two losses:

| Property | Zero-One Loss | Logistic Loss |
|---|---|---|
| Shape | Sharp step at margin = 0 | Smooth, decays as margin grows |
| Gradient | Zero almost everywhere | Non-zero everywhere |
| Optimisable by gradient descent? | No | Yes |
| Probabilistic interpretation | No | Yes (maximum likelihood) |

- Training loss = average logistic loss over all examples → gradient descent can now work

---

## Multiclass Classification

### 1. From Binary to K Classes

For binary classification: one logit → sign = prediction.

For multiclass ($K$ classes):
- Define a **weight vector per class** → compute one **logit per class**
- Parameters: weight matrix $W \in \mathbb{R}^{K \times d}$, bias vector $\mathbf{b} \in \mathbb{R}^K$

$$\mathbf{logits} = W\mathbf{x} + \mathbf{b} \in \mathbb{R}^K$$

### 2. Softmax — Generalising the Logistic Function

The **softmax** function converts a vector of logits into a probability distribution over $K$ classes:

$$\text{softmax}(\mathbf{z})_k = \frac{e^{z_k}}{\sum_{j=1}^{K} e^{z_j}}$$

Key properties:
- All outputs are in $(0, 1)$ and sum to 1 → valid probability distribution
- Higher logit = higher probability
- **Shift invariance:** adding a constant to all logits does not change the probabilities: $\text{softmax}(\mathbf{z}) = \text{softmax}(\mathbf{z} + c)$
- When $K = 2$, softmax reduces exactly to the logistic function

### 3. Cross-Entropy Loss — Generalising the Logistic Loss

The **cross-entropy** measures the difference between a target distribution $p$ and a predicted distribution $q$:

$$H(p, q) = -\sum_k p_k \log q_k$$

- Penalises the model when the target assigns high probability to an outcome but the model assigns low probability
- Minimised when $p = q$ (predicted = target)

**Special case (single correct label):** the target is a one-hot vector, so cross-entropy reduces to:

$$\text{loss}_{\text{CE}} = -\log q_{y_{\text{target}}}$$

i.e., the **negative log probability of the correct class** — a direct generalisation of logistic loss.

> *"Cross-entropy loss = predicted probability of the target class, on a log scale."*

---

## Representing Text as Tensors

Machine learning operates on tensors, but text is a string. Two steps bridge the gap:

### 1. Tokenisation
- Split a string into a sequence of **tokens** (usually words or sub-words)
- Build a **vocabulary** — a mapping from token string to integer index
- Simple tokenisation: split by space
- Modern tokenisation: **Byte-Pair Encoding (BPE)** — used in GPT-2 and most LLMs — splits words into sub-word units, handling rare words gracefully

### 2. One-Hot Encoding
- Represent each token index as a **one-hot vector**: a vector of all zeros except a 1 in the position of that token
- A string of $n$ tokens with vocabulary size $V$ becomes a matrix of shape $(n, V)$
- In practice: store **indices** not one-hot vectors (memory efficiency); index directly into weight matrices

### 3. Bag of Words (BoW)
- Represent an entire text as the **average of its token vectors**:

$$\text{BoW} = \frac{1}{n} \sum_{i=1}^{n} \mathbf{e}_{t_i}$$

- **Pro:** fixed-size representation regardless of text length — compatible with linear classifiers
- **Con:** ignores word order entirely ("dog bites man" = "man bites dog")

---

## Summary

The full classification pipeline mirrors regression but with classification-specific choices:

| Decision | Regression | Classification |
|---|---|---|
| **Hypothesis class** | Linear function $\mathbf{w} \cdot \mathbf{x} + b$ | Same, but thresholded (binary) or softmaxed (multiclass) |
| **Loss function** | Squared loss | Zero-one loss (ideal but not optimisable) → **Logistic / Cross-entropy loss** |
| **Optimisation** | Gradient descent | Gradient descent (now works because loss is smooth) |

---

## Key Takeaways

1. **Classification** predicts a discrete label; **regression** predicts a continuous value — the ML framework is the same for both
2. The **logit** is the raw model output; the **margin** (logit × target) is what the loss measures
3. **Zero-one loss** is the true objective but has zero gradients — it cannot be optimised directly
4. **Logistic loss** is a smooth, differentiable surrogate derived from the **maximum likelihood principle**
5. **Softmax** generalises the logistic function to $K$ classes; **cross-entropy** generalises logistic loss
6. Text must be converted to tensors via **tokenisation + one-hot encoding** before ML can be applied
7. **Bag of words** is the simplest text representation — fast but order-blind