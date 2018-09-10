---
# Document meta-data
title: "Geodesic Patterns for free-form Architecture"
subtitle: "MPDA'18 Master Thesis —— UPC-ETSAV"
author: Alan Rynne Vidal
institution: "UPC"
date: \today
abstract:
  Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
keywords: architectural geometry, geodesic patterns, geodesic curves, freeform paneling, surface rationalization, developable surfaces
bibliography: [input/MPDABibliography.bib]
---


# Introduction {#sec:intro}

[08/Sep/18 - 22:10:10]: # (TALK ONLY ABOUT THIS PAPERS OBJECTIVES, INTRODUCE DIRECT REFERENCES. DON'T TALK ABOUT ANY BUILDINGS)

With the development of advanced 3D CAD tools in the last decades, architects are now able to incorporate complex freeform surfaces into their designs.  This new capabilities have given birth to new architectural possibilities and, more importantly, new needs and challenges for the industry that can often be solved by the means of *Differential Geometry* [@DoCarmo2016kx] and, more specifically, *Discrete Differential Geometry* [@Crane2013DGP], which studies the discrete counterparts of *Differential Geometry*. This new fusion between architecture and mathematics gave birth to the field known as *Architectural Geometry* [@pottmann2008geometry; @pottmann2010architectural], which has been further developed during the past years.

Given the scale an architectural scale, this smooth freeform surfaces cannot be built as designed in 3D CAD applications and, therefore, must be divided in smaller, simpler parts that could be easily manufacturable. This process is called *Rationalization*, and is not a trivial task; since the *Rationalization* of a surface implies a loss of precission in the resulting shape, it must be done in such a way that minimizes this loss. The selected shape of the generated panels also plays a key role when approaching this problems, since it is clear the final appearance of the design will vary greatly depending wether the panels are triangular, quad, hexagonal or long strips. Constructibility of the selected design (panel planarity, curvature, error margins) is of great concern in rationalization methods for architectural purposes, as opposed to related Computer Graphics methods.

In this publication we center on the generation of *Geodesic Panels on Freeform Surfaces*, meaning, seamlessly covering any given surface with a pattern of *thin, long, straight panels*, which must be *developable* and rectangular (or quasi-rectangular) in shape and must approximate the surface by being bent only on their weak axis. We will introduce the basic geometric properties behind this concept and the algorithmic implementation of several of the methods. We will also explore new methods for optimizing any given shape towards *developability*.

# Background

[08/Sep/18 - 22:11:11]: # (TALK ABOUT BUILDINGS, OPTIMIZED AND NON OPTIMIZED SOLUTIONS, MEMBRANES, WINTESS, PREVIOUS POTTMAN STRIPS  PAPER.)

Examples of the application of *Architectural Geometry*  are abundant in today's architecture. Architect Frank Ghery is known for his work ground-braking work on the design of architectural shapes based purely on *developable* patches [@Stein2018DSF], which can be easily covered by a variety of panel patterns.

Recent projects by Zaha Hadid, Foster, Toyo-Ito... XXXXXX.

Covering surfaces with long rectangular, or quasi-rectangular panels of equal width, is a topic widely explored in traditional boat building, and has also been recently applied in several architectural projects, such as Toyo Ito's Minna No Mori (Japan), or the interior cladding at Frank Ghery's Burj Khalifa (Dubai) [@meredith2012burj].

Some recently finished buildings would have also benefitted from the optimization of paneling and/or beam layout like... XXXXXX.

The concept of geodesic curves on manifolds and their calculation is also important for this topic [@Surazhsky2005-al;@cheng2016solving,@Polthier1998-dn] as well as the concept of *developability* of surfaces and their discrete counterparts [see @DoCarmo2016kx, and more recenly @Stein2018DSF]

> Looking for other built examples or previous/further research on the subject.

# Geometric properties

## Geodesic curves

In differential geometry, a *geodesic curve* is the generalization of a straight line into curved spaces (see [@fig:geodesicBug]).

Also, in the presence of  an *affine connection*, a geodesic is defined to be a curve whose tangent vectors remain parallel if they are transported along it. We will explore the notion of vector *parallel transport* in the following sections.

For triangle meshes, shortest polylines cross edges at ***equal angles***.

Finding the truly shortest geodesic paths requires the computation of distance fields [see @DoCarmo2016kx;@Kimmel1998-ut]

![If an insect is placed on a surface and continually walks "forward", by definition it will trace out a geodesic (image taken from [Wikipedia](https://en.wikipedia.org/wiki/Geodesic)).](resources/images/gif/Insect_on_a_torus_tracing_out_a_non-trivial_geodesic.gif){#fig:geodesicBug width="30%"}

### Algorithmic ways of generating geodesics

The computation of geodesics on smooth surfaces is a classical topic, and can be reduced to two different solutions, depending on the initial conditions of the problem, you can basically find two types of problems [@bailin2011curvepatterns]:

Initial value problem
: given a point $p \in S$ and a vector $v \in T_pS$, find a geodesic which is incident with $p$, such that the tangent vector fo $g$ at $p$ is $v$.

Boundary value problem
: given two points $p_1, p_2 \in S$ find a geodesic $g$ connecting $p_1$ and $p_2$.

Both problems have different ways of being solved either numerically, graphically or by the means of simulations. The initial value problem can be solved using the concept of *straightest geodesics* [@Polthier1998-dn], whereas the boundary value problem has a very close relation with the computation of *shortest paths* between two points on a surface.

> It is important to note that, during this chapter, all surfaces are discretized as triangular meshes (V,E,F) of sufficient precision.  
> **What would that precision be?? %?? distance to reference surf??**

![The concept of 'shortest geodesics': curves $g_0$(red) and $g_1$(green) are both geodesic curves of a torus, although $g_1$ is more than double the length of $g_0$.](resources/images/svg/ShortestGeodesics.pdf){#fig:shortGeo pos=t}

## Developable surfaces

> This is very well explained in p.170 of Denis Shelden thesis (Gerard's suggestion). Explanation is inspired by that section.

It is also important to introduce the concept of the *developable surface*, a special kind of surface that have substantial and variable normal curvature while guaranteeing zero gaussian curvature, and as such, this surfaces can be *unrolled* into a flat plane with no deformation of the surface. This surfaces have been an extremely important design element in the practice of known architect Frank Ghery and explained in [@shelden2002digital].

There are several ways of generating a developable surface using a curve in space.

1. Select the starting point of the curve
2. Obtain the perpendicular frame of the curve at the specified parameter.
3. Deconstruct the frame into it's $X,Y$ & $Z$ vectors.
4. Select one of the vectors at all the sample points
5. Draw a line using the selected vector at the start point of the curve.
6. XXXXXX

![Developable surface generated using curve $g_1$ of [@fig:shortGeo]. (a) using the X component of the curve's perp frame; (b) using the Y component & (c) using the Z component (tangent of the curve).](resources/images/svg/DevelopableFromCurve.pdf){#fig:devFromCurve}

## Properties to aim for {#sec:properties to aim for}

We will first introduce the properties we aim for when generating geodesic panels:

### Geodesic property

> * Long Thin panels that bend about their weak axis
> * Zero geodesic curvature
> * Represent the shortest path between two points on a surface  

### Constant width property

> * Panels whose original, unfolded shape is a rectangle.
> * The only way this can happen is if the entire surface is developable.
> * For all other surfaces:
>   * Assuming no gaps between panels
>   * Panels will not be exactly rectangular when unfolded
>   * ***Requirement:*** Geodesic curves that guide the panels must have approximately constant distance from thier neighbourhood curves.

### Developable (or 'pure-bending') property

> * Bending panels on surfaces changes the distances in points only by a small amount so,
> * A certain amount of twiting is also present in this aplications.\
> ***Some methods in this chapter  do not take into account this property.***

### Objectives

Problem 1
: Look for a system of geodesic curves that covers a freeform surface in a way that:

1. They have approximate constant distance with it's neighbours.
2. This curves will serve as guiding curves for the panels.
3. The panels are to cover the surface with ***no overlap*** and ***only small gaps***

Problem 2
: Look for a system of geodesic curves in a freeform surface which:

1. Serve as the boundaries of wooden panels.
2. The panel's development is ***nearly straight***.
3. Those panels cover the surface with ***no gaps***



# Algorithmic strategies {#sec:algorithmic-strategies}

In this section, we will introduce the different existent methods for generating geodesic curve patterns that will be used to model the final panels, using methods indicated in [@Sec:panel-modeling].

## Parallel Transport Method {#sec:parallel-transport}

![Parallel transport of a vector on a 'piece-wise geodesic' path on a sphere.](resources/images/svg/SpherePTCairo.pdf){#fig:SpherePT}

This method, described in [@Pottmann2010-ku], allows for the generation of a system of geodesic curves where either the maximum distance or the minimum distance between adjacent points occurs at a prescribed location.

> In differential geometry, the concept of *parallel transport* (see [@fig:parTrans]) of a vector ***V*** along a curve ***S*** contained in a surface means moving that vector along ***S*** such that:
>
> 1. It remains tangent to the surface
> 2. It changes as little as possible in direction
> 3. It is a known fact that the length of the vector remains unchanged

![Example of parallel transport method. Generatrix geodesic $g$ (red) and geodesics $g^\perp$ generated from a parallel transported vector (blue) computed given a point and a vector $\mathbf v$ tangent to the surface, in both positive and negative directions.](resources/images/png/Parallel Transport Implementation.png){#fig:parTrans width=50%}

![Parallel transport along a curve $g$ lying on surface $S$ is equivalent to projecting  $\mathbf{v}_{i-1}$ onto the tangent plane on $p_i$ and subsequently normalizing $\mathbf{v}_i$.](resources/images/svg/ParallelTransportMethod.pdf){#fig:parTransProc}

### Procedure

[29/Jul/18 - 17:00:25]: # (Algorithms will not show in any output but PDF!!!)

\begin{algorithm}
\label{parTransPatterns}
\caption{Geodesic patterns by parallel transport}
\algsetup{indent=2em}
\floatname{algorithm}{Procedure}
\renewcommand{\algorithmicrequire}{\textbf{Input:}}
\renewcommand{\algorithmicensure}{\textbf{Output:}}
\begin{algorithmic}[1]
\REQUIRE A surface $\Phi$, represented as a triangular mesh (V,E,F)
\ENSURE Set of geodesic curves $g_i,\quad where \quad i=0,...,M$
\STATE Place a geodesic curve $g_x$ along $S$ such that it divides the surface completely in 2.
\STATE Divide the curve into $N$ equally spaced points $p$ with distance $W$.
\STATE Place an vector $\mathbf v$  onto $p_0$
\STATE Parallel transport that vector along $g_x$ as described in [@fig:parTransProc].
\FORALL {points $p_i$ where i = 0,...,M}
  \STATE Generate geodesic curve $+g_i$ and $-g_i$ using vector $\mathbf{v}_i$ and $\mathbf{-v}_i$ respectively.
  \STATE Join $+g_i$ and $-g_i$ together to obtain $g_i$
  \STATE Add $g_i$ to output.
\ENDFOR
\end{algorithmic}
\end{algorithm}

> Following this procedure, *extremal distances between adjacent geodesics occur near the chosen curve.* Meaning:
> 
> 1. For surfaces of **positive curvature**, the parallel transport method will yield a 1-geodesic pattern on which the *maximum distance* between curves will be $W$.
> 2. On the other hand, for surfaces of **negative curvature**, the method will yield a 1-geodesic pattern with $W$ being the *closest (or minimum)* distance between them.

The placement of the first geodesic curve and the selection of the initial vector are not trivial tasks. For surfaces with high variations of surfaces, the results might be unpredictable and, as such, this method is only suitable for surfaces with nearly constant curvature. Other solutions might involve cutting the surface into patches of nearly-constant curvature, and applying the *parallel transport method* independently on each patch.


## Evolution Method {#sec:evolution-method}

Two main concepts are covered in this section, both proposed by [@Pottmann2010-ku]: the first, what is called the *evolution method*, and a second method based on *piecewise-geodesic* vector fields.

<div id="fig:evolExample1">
![](resources/images/svg/CuttyEvolutionMethod.png){#fig:evolSurf width=45%}
![](resources/images/svg/CuttyEvolutionMethod2.png){#fig:evolSurf2 width=45%}

Surface covered by a 1-geodesic pattern using the evolution method without introducing breakpoints. [@Fig:evolSurf] shows an overview of the result; while [@fig:evolSurf2] highlights the intersection point of several geodesic curves. This problem will be addressed by introducing the concept of 'piece-wise' geodesic curves; which are curves that are not geodesics, but are composed of segments of several connected geodesic curves.
</div>

### The *evolution method*

As depicted in: Starting from a source geodesic somewhere in the surface:

* Evolve a pattern of geodesics iteratively computing 'next' geodesics.

* 'Next' geodesics must fulfill the condition of being at approximately constant distance from its predecessor.

* If the deviation from its predecessor is too great, breakpoints are introduced and continued as a *'piecewise geodesic'*.

* 'Next geodesics' are computed using Jacobi Fields

### Distances between geodesics

1. No straight forward solution.
    1. Only for rotational surfaces (surfaces with evenly distributed meridian curves).
2. **But** a first-order approximation of this distance can be approximated:

Starting at time $t=0$ with a geodesic curve $g(s)$, parametrized by arc-length $s$, and let it move within the surface.  
A snapshot at time $t=\varepsilon$ yields a geodesic $g^+$ near $g$.

> $$g^+(s)=g(s)+\varepsilon\mathbf{v}(s)+\varepsilon^2(\ldots)$${#eq:nextGeodesic}

The derivative vector field $\mathbf v$ is called a *Jacobi field*. We may assume it is orthogonal to $g(s)$ and it is expressed in terms of the geodesic tangent vector $g'$ as:

> $$\mathbf{v}(s)=w(s)\cdot{R_{\pi/2}(g'(s))},\quad\text{where}\;w''+Kw=0$${#eq:jacobiField}

Since the distance between infinitesimally close geodesics are governed by [@Eq:jacobiField], that equation also governs the width of a strip bounded by two geodesics at a small finite distance.
{ }
Using this principle, you can develop strips whose width $w(s)$ fulfills the Jacobi equation $w(s)=\alpha\cosh(s\sqrt{|K|})$[^question] for some value $K<0$.  
Gluing them together will result in a surface of approximate Gaussian curvature.

[^question]: **Question:** What is $\alpha$ in this formula? Missing image

<div id="fig:geoDistMultiple">

![](resources/refImages/Distances-between-geodesics.png){#fig:distanceGeo width=30%}
![](resources/refImages/Geodesic-+-Neighbouring-Geodesic.png){#fig:sphereGeoDist width=30%}

Geodesic distances on sphere
</div>

### Obtaining the 'next' geodesic

Input:
: A freeform surface $S$, a desired width $W$ and a starting geodesic curve $g_0$

Output:
: The 'next' computed geodesic on $S$

Pseudocode:
: Given a valid $S$, $W$ and $g_0$:

  1. Sample the curve $g_0$ at uniformly distributed arc-length parameters $x_i$.
  2. Compute a a set of geodesics $h_i \perp g_0$ starting points $p(x_i)$ on $g_0$.
  3. Select a width function $\omega(s)$ that is closest to a desired target width function $W(s)$(Width function can return a fixed value or a computed value using curvature. It could be further improved accommodate other measures).
  4. Select a Jacobi field $\mathbf v(s)$ using $\omega(s)$ as stated in [@Eq:jacobiField].
  5. 'Walk' the length of the vector $\mathbf v(s)$ on $h_i$ to obtain $\chi_i$. These points approximate position of the *next geodesic* "g^+_i". 
  6. The previous step can have a very big error margin, therefore we must compute $g^+_i$:
      1. Select a point $\chi_i$ and name it $\chi_0$.
      2. We can compute the next geodesic by minimizing the error between the width function $\omega(s)$ and the *signed distance* of the computed $g^+_i$ to $g_0$.
  7. Return computed geodesic $g^+_i$

Any given surface can be completely covered in this manner by recursively computing the next geodesic using the previous, given some margin of error.

<div id="fig:evMthdExmpl">
![](https://dummyimage.com/300x150/f9f9f9/f1f1f1.png){#fig:evolSurf width=30%}
![](https://dummyimage.com/299x150/f9f9f9/f1f1f1.png){#fig:evolSurf2 width=30%}

Surface covered by a 1-geodesic pattern using the evolution method. [@Fig:evolSurf] shows ***normal*** implementation; while [@fig:evolSurf2] implements the piece-wise geodesic concept. Both images use the same parameters
</div>

## Level-Set Method {#sec:level-sets}

We can also compute geodesic curve patterns on a surface by computing a scalar function on each vertex of a mesh that minimizes a combination of error measurements $F_{min} = F_k + \lambda F_{_nabla} + F_w$.

## Geodesic Webs {#sec:geodesic-webs}

We can also expand the Level-Set method explained in the previous section from one family of curves to several families of interconnected quasi-geodesic curves by simply computing several sets of scalar functions on each vertex of the surface.

## Panel modeling {#sec:panel-modeling}

In this section, we will discuss several ways to generate panels from curves lying on a given surface:

### Tangent-developable method {#sec:tangent-developable-panels}

The notion of ***Conjugate tangents*** on smooth surfaces must be defined:

> * Strictly related to the ***Dupin Indicatrix***
> * In negatively curved areas, the Dupin Indicatrix is an hyperbola whose asymptotic directions (A1, A2)
> * Any parallelogram tangentially circumscribed to the indicatrix defines two conjugate tangents **T** and **U**.
> * The asymptotic directions of the dupin indicatrix are the diagonals of any such parallelogram.

![Tangent developable method for panels\label{tangentDevMethod}](https://dummyimage.com/600x150/f9f9f9/f1f1f1.png)

Initial algorithm is as follows:

>For all geodesics $s_i$ in a given pattern:
>
>  1. Compute the *tangent developable surfaces* $\rightarrow\Psi_i$
>  2. Trim $\Psi_i$ along the intersection curves with their respective neighbours.
>  3. Unfold the trimmed $\Psi_i$, obtaining the panels in flat state.

***Unfortunately***, this method needs to be refined in order to work in practice because:

> 1. The rulings of tangent developables may behave in weird ways
> 2. The intersection of the neighboring $\Psi_i$'s is often *ill-defined*.

Therefore, the procedure was modified in the following way:

> 1. Compute the *tangent developable surfaces* $\Psi_i$ for all surfaces $s_i \rightarrow i=\text{even numbers}$
> 2. Delete all rulings where the angle enclose with the tangent $\alpha$ is smaller than a certain threshold (i.e. 20º).
> 3. Fill the holes in the rulings by interpolation (???)
> 4. On each ruling:
>    1. Determine points $A_i(x)$ and $B_i(x)$ which are the closest to geodesics $s_{i-1}$ and $s_{i+1}$. This serves for trimming the surface $\Psi_i$.
> 5. Optimize globally the positions of points $A_i(x)$ and $B_i(x)$ such that
>     1. Trim curves are *smooth*
>     2. $A_i(x)$ and $B_i(x)$ are close to geodesics $s_{i-1}$ and $s_{i+1}$
>     3. The ruling segments $A_i(x)B_i(x)$ lies close to the *original surface* $\Phi$

This adjustments to the algorithm allow for the modeling of panels that meet the requirements of developability and approximately constant width, although it must be noted computation times increase, as double the  amount of geodesic curves need to be generated, and subsequently, the desired width function needs to be half the desired width of the panels. [@Fig:tangentDevMethod] shows the result of computing such panels and the subsequent gaps between the generated panels; these gaps need to be kept within a certain width in order to produce a successful watertight panelization of the original surface. Furthermore, material restrictions such as bending or torsion where not taken into account during the construction of the panels.

![Panels computed using the using the tangent developable method.](https://dummyimage.com/600x150/f9f9f9/f1f1f1.png){#fig:tangentDevMethod}

### The Bi-Normal Method {#sec:bi-normal-panels}

The second method for defining panels, once an appropriate system of geodesics has been found on $\Phi$, works directly with the geodesic curves.

> Assume that a point $P(t)$ traverses a geodesic $s$ with unit speed, where $t$ is the time parameter.
> For each time $t$ there is:
>
> * a velocity vector $T(t)$
> * the normal vector $N(t)$
> * a third vector $B(t)$, *the binormal vector*
>
> This makes $T.N.B$ a ***moving orthogonal right-handed frame***

The surface $\Phi$ is represented as a triangle mesh and $s$ is given as a polyline.
For each geodesic, the associated surface is constructed according to [@Fig:binormalMethod]. Points $L(t)$ and $R(t)$ represent the border of the panel, whose distance from $P(t)$ is half the panel width.

![Binormal Method for panels & T.N.B. frame. On the left, the computed panels with the corresponding panel gaps highlighted in red. On the right, panels colored by distance to reference mesh.](resources/images/svg/PTPanels&DistanceToMesh.pdf){#fig:binormalMethod fig.pos="t"}

### Method Comparison

XXXXXX

## Shape Optimization  {#sec:optimization}

### Geodesic Vector-fields {#sec:geodesic-vector-fields}

The level-set method described in [@Sec:level-sets] is not suitable for arbitrary surfaces, and therefore it must be adapted to achieve the desired result. In this section, we introduce the concept of *Geodesic Vector-fields* [@Pottmann2010-ku] to divide the surface into patches that could be easily covered by equal width panels using the level-set method.

### Dynamic shape optimization (Kennan Crane...)

Another option is to modify the original surface to make it *developable*. This algorithm was first presented by [@Stein2018DSF] and it allows to convert any given triangle mesh into a developable approximation by minimizing a specified energy applied to each edge of the mesh and subsequently subdividing in order to achieve a smooth developable approximation to the reference surface.

# Quality Assessment {#sec:quality-assessment}

[09/Sep/18 - 10:22:18]: # (TALK ABOUT PANEL GAPS, STRESSES, CURVATURE... ETC...)

## Panel gaps



## Stress and strain in panels

The following section investigates the behavior of a rectangular strip of elastic material when it is bent to the shape of a ruled surface $\Psi$ un such way that:

> The central line $m$ of the strip follows the *'middle geodesic'* $s$ in $\Psi$

This applies to both methods defining panels.[@fig:panelStress]

![Stress in panels](https://dummyimage.com/600x150/f9f9f9/f1f1f1.png){#fig:panelStress}

### Formulas

> $$ \rho=1/{\sqrt{K}}, $$  {#eq:eqLabel}


> $$\varepsilon=\frac{1}{2}(d/2\rho)^2+\cdots$$ {#eq:eqLabel3}


> $$ d/2\rho\leq C,\quad{with}\quad{C=\sqrt{\sigma _{max}/E}},$$ {#eq:eqLabel2}

where $\sigma_{max}$ is the maximum admissible stress and $E$ is Young's modulus.

The value of $C$ is a material constant which yields an *upper bound* $\sigma_{max} = 2\rho_{min}C$ for the maximum strip width.

# References