![preview](./preview.png)
Unnormalized product of MVN
===========================

358; 12020 H.E.

Abstract
--------

MVN or multivariate Gaussian distribution is a generalization of the
univariate normal distribution that we all love and dread. While taking
a computational data science class, we had to find the unnormalized
product of two joint normal distributions (MVN). There doesn\'t seem to
be much literature on that; I wanted to write down how we can approach
the problem and test my mathjax to its limits.

Solution
--------

We know that MVN has the PDF form

```{=latex}
\begin{equation}
           \mathcal{N}(\x | \vmu, \Sigma) = (2\pi)^{-\frac{D}{2}} \norm{\Sigma}^{-\frac{1}{2}} \exp{(-\frac{1}{2}   (\x - \vmu)^{\top} \Sigma^{-1} (\x - \vmu))}
\end{equation}
```
