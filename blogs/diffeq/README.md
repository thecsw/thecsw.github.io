![preview](./preview.png)
== Differential equations cookbook 🔥

May 12th, 2020

link:./index.pdf[(PDF Version)]

=== Abstract

When I got first introduced to differential equations, I had a love-hate
relationship with it. Mainly due to some back-of-the-book problems we
were given and never-ending projects we were assigned to. After some
time, differential equations is a way to truly understand physics and
the foundations of gravity, fields, and everything. This articles is
merely an intro on manually solving common forms of differential
equations. Hope you enjoy

==== Quick notes

* latexmath:[$f_x \iff \partial_x f$]
* latexmath:[$A,B,C$] are usually constants
* latexmath:[$c_k$] is usually solution's constant that is defined with
initial conditions
* Most of the functions are latexmath:[$\mathbb{R}^k \to \mathbb{R}$],
latexmath:[$k \in \mathbb{N}^+$]
* If you found a typo or want to comment, feel free to email me. Email
on top of the page.

==== First-order, linear

Those equations have the form: latexmath:[$y' + p(t) y = q(t)$]

Find latexmath:[$\mu(t) = e^{\int p(t) dt}$]

Then latexmath:[$\frac{d}{dt}(\mu(t)y) = q(t) \mu(t)$]
latexmath:[$\implies y = \frac{\int q(t) \mu(t) dt}{\mu(t)}$]

==== First-order, separable

Those equations have the form: latexmath:[$\frac{dy}{dx} = f(x)g(y)$]

Find the solution by solving
latexmath:[$\int \frac{dy}{g(y)} = \int f(x) dx$]

Solve for exact (explicit) values of latexmath:[$y$]

==== Exact equations

They have the form latexmath:[$M(x,y) + N(x,y) \frac{dy}{dx} = 0$]

* latexmath:[$(\xi)$] If latexmath:[$M_y = N_x$]
+
latexmath:[$\implies$] Find such latexmath:[$F(x,y)=C$], where
latexmath:[$F_x = M$], latexmath:[$F_y = N$]
* otherwise, make it exact, such that
+
latexmath:[$\frac{M_y-N_x}{N}$] only depends on latexmath:[$x$] *or*
latexmath:[$\frac{N_x-M_y}{M}$] only depends on latexmath:[$y$]
+
Find latexmath:[$\mu(x) = e^{\int \frac{M_y-N_x}{N} dx}$] *or*
latexmath:[$\mu(y) = e^{\int \frac{N_x-M_y}{M} dy}$], multiply both by
latexmath:[$M$] *and* latexmath:[$N$], so the condition
latexmath:[$M_y = N_y$] is satisfied. Go to latexmath:[$(\xi)$] and
proceed with finding latexmath:[$F(x,y)$]

==== Second-order, linear, constant-coefficient equations

They have the form latexmath:[$y'' + p y' + q y = f(t)$]

* First, solve for the homogeneous case, where
latexmath:[$y'' + p y' + q y = 0$]
+
Make a characteristic polynomial, let latexmath:[$y = e^{rt}$]:
+
latexmath:[$r^2+pr+q=0$]
+
Find roots, solution (general) will be
latexmath:[$y = c_1 e^{r_1 t} + c_2 e^{r_2 t}$]
+
**** if repeated root
latexmath:[$\implies y = c_1 e^{rt} + c_2 t e^{rt}$]
+
**** if latexmath:[$r = \alpha \pm i \beta$]
latexmath:[$\implies y=c_1 \cos(\beta t)e^{\alpha t} + c_2 \sin(\beta t) e^{\alpha t}$]
* Solving for particular solution latexmath:[$y_p(t)$]
+
**** Undetermined coefficients (superpositioned) for latexmath:[$f(t)$]
+
Whatever is in latexmath:[$f(t)$], start adding up the corresponding
coefficients into latexmath:[$y_p(t)$]
+
***** latexmath:[$e^{nt} \to Ae^{nt}$]
+
***** latexmath:[$t^m \to A_m t^m + \ldots + A_1 t + A_0$]
+
***** latexmath:[$\cos(\beta t)$] or
latexmath:[$\sin(\beta t) \to Acos(\beta t) + B\sin(\beta t)$]
+
NOTE: should not be linearly dependent with the general solution. If it
is, multiply by latexmath:[$t$] until it is linearly independent.
+
**** Variation of parameters
+
Seek latexmath:[$y_p(t) = v_1(t)y_1(t)+v_2(t)y_2(t)$], where
+
latexmath:[$\begin{cases}v_1'y_1+v_2'y_2=0\\v_1'y_1'+v_2'y_2'=f(t)\end{cases}$]

So the final solution is
latexmath:[$y(t)=c_1 y_1(t) + c_2 y_2(t) + y_p(t)$]

==== Second-order, linear, variable-coefficient equations

Equations have the form

* latexmath:[$(1)$]: latexmath:[$a(t)y'' + b(t)y'+c(t)y = f(t)$]
* latexmath:[$(2)$]: latexmath:[$y'' + p(t)y'+q(t)y = g(t)$]

In general case, guess the first homogeneous solution (try
latexmath:[$y_1=e^t$]) and use reduction of order to find the second
homogeneous solution, so that

latexmath:[$y_2(t) = v(t)y_1(t)$]

latexmath:[$\implies y_2'' + p(t)y_2' + q(t)y_2 = 0$]

latexmath:[$\implies (v(t)y_1(t))''+p(t)(v(t)y_1(t))'+q(t)(v(t)y_1(t))=0$]

NOTE: Also applicable with form latexmath:[$(1)$]

You will probably have another differential equation emerge from above.
It should have lower order than our current equation, so just refer to
one of the techniques above to find latexmath:[$v(t)$] and then you can
find latexmath:[$y_2(t)=v(t)y_1(t)$]

Use *variation of parameters* to find a particular solution. It's that
system with latexmath:[$v$]

NOTE: What you if you have a *Cauchy-Euler equation*?

They have the form latexmath:[$at^2y''+bty'+cy=0$]

then latexmath:[$y=t^r \implies ar^2+(b-a)r+c=0$]

* if latexmath:[$r$] is repeated, latexmath:[$y_1=t^r$],
latexmath:[$y_2=ln|t|t^r$]
* if latexmath:[$r=\alpha\pm i\beta$],
latexmath:[$y_1=t^{\alpha}\cos(\beta ln|t|)$] and
latexmath:[$y_2=t^{\alpha}\sin(\beta ln|t|)$]

Generally, solution has the form latexmath:[$y=c_1t^{r_1}+c_2t^{r_2}$]

==== Higher-order, linear equations

latexmath:[$a_n(t)y^{(n)}+a_{n-1}(t)y^{(n-1)}+\ldots+a_1(t)y'+a_0(t)y=g(t)$]

All second-order methods above extend to latexmath:[$n^{th}$] order.

==== Laplace transform

Laplace is a holy grail of solving differential equations with initial
values defined. Laplace is the same kind of Bible to engineers like
Taylor Series is.

latexmath:[$\mathcal{L}\{f\}(s) = \int_0^{\infty} e^{-st} f(t) dt$]

assuming latexmath:[$f$] is piecewise continuous and of exponential
order.

Table of common transformations:

[cols=",",options="header",]
|===
|latexmath:[$f(t)$] |latexmath:[$\mathcal{L}\{f\}(s)$]
|latexmath:[$1$] |latexmath:[$\frac{1}{s}$]
|latexmath:[$e^{at}$] |latexmath:[$\frac{1}{s-a}$]
|latexmath:[$\sin(bt)$] |latexmath:[$\frac{b}{s^2+b^2}$]
|latexmath:[$\cos(bt)$] |latexmath:[$\frac{s}{s^2+b^2}$]
|latexmath:[$u(t-a)$] |latexmath:[$\frac{e^{-as}}{s}$]
|latexmath:[$\delta(t-a)$] |latexmath:[$e^{-as}$]
|===

Where latexmath:[$u(t)$] is the
https://en.wikipedia.org/wiki/Heaviside_step_function[Heaviside step
function] and latexmath:[$\delta(t)$] is the
https://en.wikipedia.org/wiki/Dirac_delta_function[Dirac delta
function].

Some Laplace transform properties:

* latexmath:[$\mathcal{L}\{e^{at}f(t)\}(s) = \mathcal{L}\{f(t)\}(s-a)$]
* latexmath:[$\mathcal{L}\{t^nf(t)\}(s) = s^n\mathcal{L}\{f\}(s)-s^{n-1}f(0)-\ldots-sf^{(n-2)}(0)-f^{(n-1)}(0)$]
* latexmath:[$\mathcal{L}\{t^nf(t)\}(s) = (-1)^n \frac{d^n}{ds^n} \mathcal{L}\{f(t)\}(s)$]

If latexmath:[$f$] is a T-periodic function,

latexmath:[$\mathcal{L}\{f(t)\}(s) = \frac{\int_0^T e^{-sT} f(t) dt}{1-e^{-sT}}$]

where latexmath:[$\int_0^T e^{-sT} f(t) dt = \mathcal{L}\{f_T(t)\}(s)$],
the sum of integrals of different parts of the piecewise function.

Convolutions:

* latexmath:[$(f*g)(t) = \int_0^t f(t-v)g(v)dv$]
* latexmath:[$\mathcal{L}\{(f*g)(t)\} = \mathcal{L}\{f(t)\}(s)\cdot \mathcal{L}\{g(t)\}(s)$]
* latexmath:[$(f*g)(t) = \mathcal{L}^{-1}\{F\cdot G\}(t)$], where
latexmath:[$F=\mathcal{L}\{f\}(s)$] and
latexmath:[$G=\mathcal{L}\{g\}(s)$]

Heaviside/unit step function:

* latexmath:[$\mathcal{L}\{u(t-a)f(t)\}(s) = e^{-as}\mathcal{L}\{f(t+a)\}(s)$]
* latexmath:[$\mathcal{L}^{-1}\{e^{-as}F(s)\}(t)=u(t-a)\mathcal{L}^{-1}\{F(s)\}(t-a)$]

If IVP is not at 0, define some new function like
latexmath:[$w(t)=y(t+\alpha)$], and solve for latexmath:[$w$]. Finally,
you can offset to find latexmath:[$y$]

Step (block) function:

* latexmath:[$\Pi_{a,b}(t) = u(t-a)-u(t-b)$]
* latexmath:[$\mathcal{L}\{\Pi_{a,b}(t)\}(s)=\frac{e^{-sa}-e^{-sb}}{s}$]

==== Constant-coefficient, homogeneous systems of ODE

latexmath:[$\vec{x}' = A \vec{x}$], where
latexmath:[$A\in\mathbb{R}^{n\times n}$], latexmath:[$x\in\mathbb{R}^n$]

If latexmath:[$A$] has n linearly independent eigenvectors
latexmath:[$\vec{u_i}$] associated to n eigenvalues
latexmath:[$\lambda_i$], then a general solution of the system is given
by
latexmath:[$\vec{x}(t) = c_1 e^{\lambda_1 t}\vec{u_1}+c_2e^{\lambda_2t}\vec{u_2} + \ldots + c_ne^{\lambda_nt}\vec{u_n}$]

* If latexmath:[$\lambda=\alpha \pm i \beta$], so
latexmath:[$\vec{u}=\vec{a}+i\vec{b}$], we have

latexmath:[$\vec{x}=c_1e^{\alpha t}(\cos(\beta t)\vec{a}-\sin(\beta t)\vec{b}) + c_2e^{\alpha t}(\cos(\beta t)\vec{b}+\sin(\beta t)\vec{a})$]

* Matrix exponential

latexmath:[$e^{At} = \sum_{k=0}^{\infty} \frac{A^k t^k}{k!}$], where
latexmath:[$A^0=I$], an identity matrix.

* Find solutions for any eigenvalues

. Compute the characteristic polynomial latexmath:[$p(\lambda)$] of
latexmath:[$A$]
+
latexmath:[$p(\lambda)=det(A-\lambda I)$]
. Factor latexmath:[$p(\lambda)$] into linear factors to yield
+
latexmath:[$p(\lambda) = c(\lambda-\lambda_1)^{m_1} \cdot \ldots \cdot (\lambda-\lambda_k)^{m_k}$],
where latexmath:[$c=\pm 1$]
. For each latexmath:[$\lambda_j$], find latexmath:[$m_j$] linearly
independent generalized eigenvectors
latexmath:[$\{\vec{u_j}^{m_1},\cdots,\vec{u_j}^{m_j}\}$] satisfying
+
latexmath:[$(A-\lambda_i I)^{m_j} \vec{u} = \vec{0}$]
. For each latexmath:[$\vec{u_j}^i$] computed in the previous step,
compute latexmath:[$e^{At}\vec{u_j}^i$] by
+
latexmath:[$e^{At}\vec{u_j}^i$]
+
latexmath:[$=e^{\lambda_jt}e^{(A-\lambda_jI)t}\vec{u_j}^i$]
+
latexmath:[$=e^{\lambda_jt}(\vec{u_j}^i+t(A-\lambda_jI)\vec{u_j}^i+\cdots+\frac{t^{m_j-1}}{(m_j-1)!}(A-\lambda_jI)^{m_j-1}\vec{u_j}^i)$]

==== Linear systems of ODE

latexmath:[$\vec{x}' = A(t)\vec{x} + \vec{f}(t)$], where
latexmath:[$A\in\mathbb{R}^{n\times n}$],
latexmath:[$x\in\mathbb{R}^n$], latexmath:[$f\in\mathbb{R}^n$]

If latexmath:[$X(t)$] is a matrix whose columns are made up of n
linearly independent homogeneous solutions (latexmath:[$X(t)$] is the
fundamental matrix), then a general solution may be written as
latexmath:[$\vec{x}(t_0)=\vec{x_0}$]

latexmath:[$\vec{x}(t) = X(t)X^{-1}(t_0)\vec{x_0}+X(t)\int_{t_0}^{t}X^{-1}(s)f(s)ds$]

If latexmath:[$A(t)$] is constant-coefficient, then we recover Duhamel's
formula:

latexmath:[$\vec{x}(t) = e^{A(t-t_0)}x_0 + \int_{t_0}^{t}e^{A(t-s)}f(s)ds$]

==== Applications

There are many applications of differential equations in classical
mechanics, fields, etc. Below you will find just a snippet of some very
common Physics 1/2 scenarios

. Falling object
+
latexmath:[$m\frac{dv}{dt}=mg-bv$], where latexmath:[$b$] is the air
resistance
. Fluid mix, define latexmath:[$R_{in}$] and latexmath:[$R_{out}$]
+
latexmath:[$\frac{dx}{dt}=R_{in}-R_{out}$]
. Mass-Spring System
.. Vertical spring (direction of gravity)
+
latexmath:[$my''=-by'-k(L+y)+mg+F_{ext}(t)$], assume
latexmath:[$KL=mg$], where latexmath:[$b$] is dumping, and
latexmath:[$k$] is stiffness
.. Horizontal spring
+
latexmath:[$my''=-by'-ky+F_{ext}(t)$], where latexmath:[$b$] is dumping,
and latexmath:[$k$] is stiffness

==== Conclusion

This is as much as I can recover from my initial experience with
differential equations. This article is not as much to teach you how to
solve them but provide a quick lookup cheatsheet if needed or glance at
different forms that we can actually solve! There are infinitely many
differential equations that we cannot find an exact solution for!

USEMATHJAX
