---
# Document meta-data
title: "Geodesic Patterns for free-form Architecture"
subtitle: "MPDA'18 Master Thesis —— UPC-ETSAV"
author: Alan Rynne Vidal
institute: "UPC"
date: September 2018
logo: resources/images/logos/UPC-logo.png
abstract:
  In this publication, we implement and analyze different existing techniques to obtain cladding solutions using exclusively straight planks, either wood or metal, and analyze their benefits and weaknesses from an architectural standpoint. We will concentrate on the generation of *geodesic curves*, more specifically *straightest geodesics*, which minimize distance between two points on curved surface. For cost and manufacturing reasons, geodesic planks are favorable for cladding solutions, as they can be manufactured and assembled using inexpensive construction techniques. We will also explain some basic structural analysis concepts to check the admissibility of the generated solutions.

keywords: architectural geometry, geodesic patterns, geodesic curves, freeform paneling, surface rationalization, developable surfaces

bibliography: [input/MPDABibliography.bib]
nocite: "@*"
---

# Introduction {#sec:intro}

[08/Sep/18 - 22:10:10]: # (TALK ONLY ABOUT THIS PAPERS OBJECTIVES, INTRODUCE DIRECT REFERENCES. DON'T TALK ABOUT ANY BUILDINGS)

With the development of advanced 3D CAD tools in the last decades, architects are now able to incorporate complex freeform surfaces into their designs.  This new capabilities have given birth to new architectural possibilities and, more importantly, new needs and challenges for the industry that can often be solved by the means of *Differential Geometry* [@DoCarmo2016kx] and, more specifically, *Discrete Differential Geometry* [@Crane2013DGP], which studies the discrete counterparts of *Differential Geometry*. This new fusion between architecture and mathematics gave birth to the field known as *Architectural Geometry* [@pottmann2008geometry; @pottmann2010architectural], which has been further developed during the past years.

Given the scale architectural projects, this smooth freeform surfaces cannot be built as designed in 3D CAD applications and, therefore, must be divided in smaller, simpler parts that could be easily manufacturable. This process is called *Rationalization*, and is not a trivial task; since the *Rationalization* of a surface implies a loss of smoothness in the resulting shape, it must be done in such a way that minimizes this loss. The selected shape of the generated panels also plays a key role when approaching this problems, since it is clear the final appearance of the design will vary greatly depending on wether the panels are triangular, quad, hexagonal or long strips. Constructibility of the selected design (panel planarity, curvature, error margins) is of great concern in rationalization methods for architectural purposes, looking for robust and precise algorithms, as opposed to related Computer Graphics methods, whose main focus is usually related with execution times & speed.

In this publication we center on the generation of *Geodesic Panels on Freeform Surfaces*, meaning, seamlessly covering any given surface with a pattern of ***planks***; *thin, long, straight panels*, which must be *developable* and rectangular (or quasi-rectangular) in shape and must approximate the surface by being bent only on their weak axis. We will introduce the basic geometric properties behind this concept and the algorithmic implementation of several of the methods. We will also explain some concepts developed for optimizing any given shape towards *developability*.

<div id="fig:planks">
![](resources/images/vector/HyparPlanks.svg){#fig:hyparPlanks width=33%}
![](resources/images/vector/CylinderPlanks.svg){#fig:cylinderplanks width=66%}

Straight planks bent on a hyperbolic paraboloid (a) and a cylindrical surface (b).
</div>

# Background

[08/Sep/18 - 22:11:11]: # (TALK ABOUT BUILDINGS, OPTIMIZED AND NON OPTIMIZED SOLUTIONS, MEMBRANES, WINTESS, PREVIOUS POTTMAN STRIPS  PAPER.)

Examples of the application of *Architectural Geometry*  are abundant in today's architecture. Architect Frank Ghery is known for his work ground-braking work on the design of architectural shapes based purely on *developable* patches [@Stein2018DSF], which can be easily covered by a variety of panel patterns. Many of his buildings have become iconic landmarks of the cities they are built in

<div id="fig:gheryBackground">
![](resources/images/background/guggenheim.jpg){#fig:guggenheimMuseum width=33%}
![](resources/images/background/waltDisneyConcertHall.jpg){#fig:waltDisneyHall width=33%}
![](resources/images/background/guggenheimAbuDhabi.jpg){#fig:guggenheimAbuDhabi  width=33%}

Famous Ghery projects (right to left): Guggenheim Museum (Bilbao, 1997), Walt Disney Concert Hall (Los Angeles, 2003) and the Guggenheim Abu Dhabi winning proposal (Abu Dhabi, --)
</div>

Covering surfaces with long rectangular, or quasi-rectangular panels of equal width, is a topic widely explored in traditional boat building, and has also been recently applied in several architectural projects, such as Toyo Ito's Minna No Mori (Japan), or the interior cladding at Frank Ghery's Burj Khalifa (Dubai) [@meredith2012burj].

<div id="fig:minaNoMori">
![](resources/images/background/minaNoMori.jpg){#fig:minaNoMoriInterior width=50%}
![](resources/images/background/minaNoMoriConstruction.jpg){#fig:minaNoMoriConstruction width=50%}

Interior view of Toyo Ito's Mina No Mori wooden lattice roof (a) and exterior view of the lattice under construction (b).
</div>

<div id="fig:burjKhalifa">
![](resources/images/background/BurjWoodCeiling.jpg){#fig:burjCeiling width=50%}
![](resources/images/background/burjPanneling.jpg){#fig:burjPanels width=50%}

Burj Khalifa interior ceiling constructed from wooden planks (a) and final paneling solution (b).
</div>

NOX Architects, an award winning architecture firm, is famous for building complex shapes using planks. Their design methodology included the creation of very precise models, and manually covering these models with paper strips until a final cladding solution could be achieved  [@fig:noxBackground]

<div id="fig:noxBackground">
![](resources/images/GeodPatterns/geodPattern-figure-03.png){#fig:noxStrips width=57%}
![](resources/images/GeodPatterns/geodPattern-figure-04.png){#fig:noxRender width=30%}

NOX Architects paper models & final rendered design solution.
</div>

Some recently finished buildings would have also benefitted from the optimization of paneling and/or beam layout like the Yeoju Golf project by Shigeru Ban, which involved the construction of complex laminated wood shapes [@fig:shigeruGolf]

<div id="fig:shigeruGolf">
![](resources/images/background/shigeruYeojuConstruction.jpg){#fig:shigeruGolfPart width=49%}
![](resources/images/background/shigeruYeojuConstruction2.jpg){#fig:shigeruGolfConstruction width=49%}

Shigeru Ban's Yeoju Golf Resort. Right: Pre-assembled complex lattice. Left: Aerial view of lattice under construction.
</div>

Geodesic curves on manifolds and their calculation is also important for this topic [@Surazhsky2005-al;@cheng2016solving,@Polthier1998-dn] as well as the concept of *developability* of surfaces and their discrete counterparts [see @DoCarmo2016kx, and more recently @Stein2018DSF]. In this publication, all of the geodesics will be generated with the *initial value problem*.

![Mesh developability techniques. Left  to  right: @julius2005d, @mitani2004making, @shatz2006paper @liu2006geometric  and @Stein2018DSF [^KraneDevelop]](resources/images/developability/developability-figure-04.png){#fig:developabilityTechniques width=100%}

The concept of *mesh developability* has also been widely studied in the past, although strictly speaking, it will not be the object of this publication. Previous attempts at mesh developability can be viewed in [@fig:developabilityTechniques]. The latest and more robust implementation was developed by @Stein2018DSF and is based on reducing the angle defect on each vertex on a mesh, by forcing the normals of the faces adjacent to each vertex to be parallel; this causes that each vertex on the given mesh becomes either flat or a *hinge* [@fig:developabilityFlatHinge], effectively concentrating the gaussian curvature of the original mesh on the hinges. This procedure provides very smooth developable results on any given mesh, but most of the time, the resulting *developable* will exhibit creases and sharp edges in some areas, which are heavily influenced by the topology of the starting mesh. Also, the resulting *flat* configuration of the mesh usually contains self-intersections and complex boundary shapes that would increase complexity on the construction and assembly stages in an architectural scale project.

<div id="fig:developabilityHingeSphere">
![](resources/images/developability/developability-figure-12.png){#fig:developabilityFlatHinge with=50%}
![](resources/images/developability/developability-figure-02.png){#fig:developableSpheres width=50%}

Left: Any given vertex on a mesh (left) will become either flat (centre) or a hinge (right). Right: Developalizing a sphere. Results highly depend on the initial mesh topology[^KraneDevelop]
</div>

# Geometric properties

## Geodesic curves

In differential geometry, a *geodesic curve* is the generalization of a straight line into curved spaces. It is usually understood as the shortest path between two points on a given surface, although this may not always be the case.

Also, in the presence of  an *affine connection*, a geodesic is defined to be a curve whose tangent vectors remain parallel if they are transported along it. We will explore the notion of vector *parallel transport* in the following sections.

For triangle meshes, shortest polylines cross edges at ***equal angles***.

Finding the truly shortest geodesic paths requires the computation of distance fields [see @DoCarmo2016kx;@Kimmel1998-ut]

<div id="basicConcepts">
![](resources/images/vector/ShortestGeodesics.svg){#fig:shortGeo width=50%}
![](resources/images/vector/SpherePT.svg){#fig:SpherePT width=50%}

(a) The concept of 'shortest geodesics': curves $g_0$(red) and $g_1$(green) are both geodesic curves of a torus, although $g_1$ is more than double the length of $g_0$. $g_0$ was computed solving the *initial value problem, while $g_1$ was computed using the *boundary value problem* and (b) parallel transport of a vector $\mathbf v_0$ on a 'piecewise geodesic' path.
</div>

### Algorithmic ways of generating geodesics {-}

The computation of geodesics on smooth surfaces is a classical topic, and can be reduced to two different solutions, depending on the initial conditions of the problem [@bailin2011curvepatterns]:

Initial value problem
: given a point $p \in S$ and a vector $v \in T_pS$, find a geodesic which is incident with $p$, such that the tangent vector fo $g$ at $p$ is $v$.

Boundary value problem
: given two points $p_1, p_2 \in S$ find a geodesic $g$ connecting $p_1$ and $p_2$.

Both problems have different ways of being solved either numerically, graphically or by the means of simulations. The initial value problem can be solved using the concept of *straightest geodesics* [@Polthier1998-dn], whereas the boundary value problem has a very close relation with the computation of *shortest paths* between two points on a surface.

## Developable surfaces

It is also important to introduce the concept of the *developable surface*, a special kind of surface that have substantial and variable normal curvature while guaranteeing zero gaussian curvature, and as such, this surfaces can be *unrolled* into a flat plane with no deformation of the surface. This surfaces have been an extremely important design element in the practice of known architect Frank Ghery and explained in [@shelden2002digital].

There are several ways of generating a developable surface using a curve in space. The most simple way is the following.

1. Select the starting point of the curve
2. Obtain the perpendicular frame of the curve at the specified parameter.
3. Deconstruct the frame into it's $X,Y$ & $Z$ vectors.
4. Select one of the vectors at all the sample points
5. Draw a line using the selected vector at the start point of the curve.
6. Create a surface using the rulings obtained in step 5.

![Developable surface generated using curve a geodesic curve. (a) using the X component of the curve's perp frame; (b) using the Y component & (c) using the Z component (tangent of the curve).](resources/images/vector/DevelopableFromCurve.svg){#fig:devFromCurve}

Not all developable surfaces are of interest in an architectural sense. We must make a distiction between *noisy* and *smooth* developable surfaces, as can be seen in [@Fig:noisyVSsmooth]. We are spetially interested in generating *smooth* develpable surfaces, which can be easily manufactured, as opposed to the complex bending operations that manufacturing a *noisy* developable surface will require

![Noisy to smooth sheet [@Stein2018DSF][^KraneDevelop]](resources/images/developability/developability-figure-08.png){#fig:noisyVSsmooth width=100%}

## Properties to aim for {#sec:properties-to-aim-for}

We will first introduce the properties we aim for when generating geodesic panels:

### Geodesic property {-}

> * Long Thin panels that bend about their weak axis
> * Zero geodesic curvature
> * Represent the shortest path between two points on a surface  

### Constant width property {-}

> * Panels whose original, unfolded shape is a rectangle.
> * The only way this can happen is if the entire surface is developable.
> * For all other surfaces:
>   * Assuming no gaps between panels
>   * Panels will not be exactly rectangular when unfolded
>   * ***Requirement:*** Geodesic curves that guide the panels must have approximately constant distance from their neighborhood curves.

### Developable (or 'pure-bending') property {-}

> * Bending panels on surfaces changes the distances in points only by a small amount so,
> * A certain amount of twisting is also present in this applications.\
> ***Some methods in this chapter  do not take into account this property.***

### Objectives {-}

Look for a system of geodesic curves that covers a freeform surface in a way that:

1. They have approximate constant distance with it's neighbours.
2. This curves will serve as guiding curves for the panels.
3. The panels are to cover the surface with ***no overlap*** and ***only small gaps***

# Algorithmic strategies {#sec:algorithmic-strategies}

In this section, we will introduce the different existent methods for generating geodesic curve patterns that will be used to model the final panels, using methods indicated in [@sec:panel-modeling].

## Parallel Transport Method {#sec:parallel-transport}

![Example of parallel transport method. Generatrix geodesic $g$ (red) and geodesics $g^\perp$ generated from a parallel transported vector (blue) computed given a point and a vector $\mathbf v$ tangent to the surface, in both positive and negative directions.](resources/images/png/Parallel Transport Implementation.png){#fig:parTrans width=50%}

This method, described in [@Pottmann2010-ku], allows for the generation of a system of geodesic curves where either the maximum distance or the minimum distance between adjacent points occurs at a prescribed location.

![Parallel transport method: We can parallel transport a vector along a curve placed on a surface by iteratively projecting the previous vector $\mathbf v_{i-1}$ over the tangent plane of $v_i$ and normalizing it's length.](resources/images/vector/Diagram-ParallelTransportMethod.svg){#fig:diagramPartTrans}

> In differential geometry, the concept of *parallel transport* (see [@fig:parTrans]) of a vector ***V*** along a curve ***S*** contained in a surface means moving that vector along ***S*** such that:
>
> 1. It remains tangent to the surface
> 2. It changes as little as possible in direction
> 3. It's length remains unchanged

![Parallel transport method. Main geodesic $g$, tangent planes at each point $p_i$, transported vectors $\mathbf v_i$, generated geodesics $h_i$.](resources/images/vector/ParallelTransportMethod.svg){#fig:parTransProc}

### Procedure {-}

[29/Jul/18 - 17:00:25]: # (Algorithms will not show in any output but PDF!!!)

\begin{algorithm}
\label{alg:parTrans}
\caption{Parallel Transport Method}
\algsetup{indent=1em}
\small
\begin{algorithmic}[1]
\REQUIRE A surface $\Phi$, represented as a triangular mesh (V,E,F)

\STATE Place a geodesic curve $g_x$ along $S$ such that it divides the surface completely in 2.
\STATE Divide the curve into $N$ equally spaced points $p$ with distance $W$.
\STATE Place an vector $\mathbf v$  onto $p_0$
\STATE Parallel transport that vector along $g_x$ as described in [@fig:parTransProc].
\FORALL {points $p_i$ where i = 0,...,M}
  \STATE Generate geodesic curve $+g_i$ and $-g_i$ using vector $\mathbf{v}_i$ and $\mathbf{-v}_i$ respectively.
  \STATE Join $+g_i$ and $-g_i$ together to obtain $g_i$
  \STATE Add $g_i$ to output.
\ENDFOR
\ENSURE Set of geodesic curves $g_i,\quad where \quad i=0,...,M$
\end{algorithmic}
\end{algorithm}

> Following this procedure, *extremal distances between adjacent geodesics occur near the chosen curve.* Meaning:
> 
> 1. For surfaces of **positive curvature**, the parallel transport method will yield a 1-geodesic pattern on which the *maximum distance* between curves will be $W$.
> 2. On the other hand, for surfaces of **negative curvature**, the method will yield a 1-geodesic pattern with $W$ being the *closest (or minimum)* distance between them.

The placement of the first geodesic curve and the selection of the initial vector are not trivial tasks. For surfaces with high variations of surfaces, the results might be unpredictable and, as such, this method is only suitable for surfaces with nearly constant curvature. Other solutions might involve cutting the surface into patches of nearly-constant curvature, and applying the *parallel transport method* independently on each patch.

<div id="parTransResults">

![](resources/images/vector/Results-ParallelTransport-Positive.svg){#fig:parTransPositiveCurv}
![](resources/images/vector/Results-ParallelTransport-Negative.svg){#fig:parTransNegativeCurv}
![](resources/images/vector/Results-ParallelTransport-Double.svg){#fig:parTransDoubleCurv}

Results of the parallel transport method applied to surfaces of different curvature: (a) positive, (b) negative and (c) doubly curved.
</div>

## Evolution Method {#sec:evolution-method}

Two main concepts are covered in this section, both proposed by [@Pottmann2010-ku]: the first, what is called the *evolution method*, and a second method based on *piecewise-geodesic* curves, curves that are not geodesic, but are composed of several connected geodesic segments.

<div id="fig:evolExample1">
![](resources/images/png/CuttyEvolutionMethod.png){#fig:evolSurf width=45%}
![](resources/images/png/CuttyEvolutionMethod2.png){#fig:evolSurf2 width=45%}

Surface covered by a 1-geodesic pattern using the evolution method without introducing breakpoints. $(a)$ shows an overview of the result; while $(b)$ highlights the intersection point of several geodesic curves. This problem will be addressed by introducing the concept of 'piece-wise' geodesic curves; which are curves that are not geodesics, but are composed of segments of several connected geodesic curves.
</div>

### The evolution method {-}

Starting from a source geodesic somewhere in the surface:

* Evolve a pattern of geodesics iteratively computing 'next' geodesics.

* 'Next' geodesics must fulfill the condition of being at approximately constant distance from its predecessor.

* 'Next geodesics' are as described in [@fig:bestFitGeodesic]

### Distances between geodesics {-}

1. No straight forward solution.
    1. Only for rotational surfaces (surfaces with evenly distributed meridian curves).
2. **But** a first-order approximation of this distance can be approximated:

The method proposed in @Pottmann2010-ku is based on the calculation of *Jacobi Fields*, vector fields perpendicular to a geodesic that approximate the distance between one geodesic and the next in an infinitesimal distance.

Starting at time $t=0$ with a geodesic curve $g(s)$, parametrized by arc-length $s$, and let it move within the surface.  
A snapshot at time $t=\varepsilon$ yields a geodesic $g^+$ near $g$.

> $$g^+(s)=g(s)+\varepsilon\mathbf{v}(s)+\varepsilon^2(\ldots)$${#eq:nextGeodesic}

The derivative vector field $\mathbf v$ is called a *Jacobi field*. We may assume it is orthogonal to $g(s)$ and it is expressed in terms of the geodesic tangent vector $g'$ as:

> $$\mathbf{v}(s)=w(s)\cdot{R_{\pi/2}(g'(s))},\quad\text{where}\;w''+Kw=0$${#eq:jacobiField}

Since the distance between infinitesimally close geodesics are governed by [@Eq:jacobiField], that equation also governs the width of a strip bounded by two geodesics at a small finite distance.

We propose a simpler approach to this problem, since the computation of the jacobi field can give very high margins of error and 'next' geodesic $g_{i+1}$ will still need to be computed using the initial value problem. The modification is the following: we can substitute the length of the jacobi field for the user's specified width $W$ and find the best fit geodesic that fits this *signed distances*.

### Obtaining the 'next' geodesic {-}

![Calculating the 'next' geodesic](resources/images/vector/Diagram-BestFitGeodesic.svg){#fig:bestFitGeodesic}

\begin{algorithm}
\label{alg:bestFit}
\caption{Calculate the best-fit geodesic}
\algsetup{indent=1em}
\small
\begin{algorithmic}[1]
\REQUIRE Curve $g_i$,perp geodesics $h^\perp$, desired width $W$ and an angle threshold $\alpha$.

\STATE Obtain a point $p_i$ at distance $W$ from the starting point of each $g^\perp_i$
\STATE Select any point $p_i$ as the start point and name it $p_0$.
\STATE Select the tangent vector $\mathbf v_T$ of $g^\perp_i$ at $p_0$.
\STATE Rotate $\mathbf v_T$ 90º around the normal of $\Phi$ at $p_0$.
\STATE Generate an initial geodesic $g_i$.
\STATE Obtain error measure $\epsilon$ as the least squares difference between the desired distance $W$ and the actual distance $D$
\STATE Find the geodesic that has the least error by rotating $v_T$ by a small amount each step.

\ENSURE The next geodesic curve that best fits $W$.
\end{algorithmic}
\end{algorithm}

Any given surface can be completely covered in this manner by recursively computing the next geodesic using the previous, given some margin of error.

<div id="evolutionResults">
![](resources/images/vector/Results-Evolution-Positive.svg){#fig:evolPositiveCurv width=100%}
![](resources/images/vector/Results-Evolution-Negative.svg){#fig:evolNegativeCurv width=100%}
![](resources/images/vector/Results-Evolution-Double.svg){#fig:evolDoubleCurvature width=100$}

Results of the evolution method applied to surfaces of different curvature: (a) positive, (b) negative and (c) doubly curved.
</div>

\begin{algorithm}
\label{alg:evolMethod}
\caption{Evolution Method}
\algsetup{indent=1em}
\small
\begin{algorithmic}[1]
\REQUIRE A surface $\Phi$, represented as a triangular mesh (V,E,F), a desired width $W$, and a starting geodesic curve $g_0$.
\STATE Place a geodesic curve $g_i$ along $\Phi$ and name it $g_0$.
\STATE Divide the curve into equally $N$ number of sample points.
\FORALL {points $p_i$\quad where \quad $i=0,...,N$}
\STATE Find tangent vector $\mathbf{v}^T_i$ of $g$
\STATE Rotate $\mathbf{v}^T_i$ by $\frac{\pi}{4}$
\STATE Generate geodesic $h^\perp_i$ from $p_i$ and $\mathbf{v}^T_g$
\ENDFOR
\STATE Compute BEST FIT GEODESIC $g_{i+1}$\ref{alg:bestFit}
\IF {No best fit is found} \STATE BREAK
\ENDIF
\STATE Make $g_{i+1}$ the current geodesic for next iteration.
\ENSURE Set $G$ of geodesic curves $g_i,\quad where \quad i=0,...,M$
\end{algorithmic}
\end{algorithm}

### Piecewise evolution method {-}

We can modify the implementation of the evolution method to be able to control the distance between geodesics even in areas with a high rate of change in curvature. In order to prevent this unwanted width variations, instead of looking for the best overall geodesic, we will look for the best geodesic that fits the largest interval of $h_i$'s possible [@fig:bestPiecewiseGeodesic], given a specified threshold $\epsilon$. Once this interval is obtained, the current geodesic is split and a new geodesic will be generated. This process will be repeated until the curve crosses all $h_i$'s (some exceptions apply).

![Calculating the best piece-wise geodesic](resources/images/vector/Diagram-PieceWiseGeodesic.svg){#fig:bestPiecewiseGeodesic}

\begin{algorithm}
\label{alg:piecewise}
\caption{Calculate the best-fit piecewise geodesic}
\algsetup{indent=1em}
\small
\renewcommand{\algorithmicrequire}{\textbf{Start from:}}
\renewcommand{\algorithmicensure}{\textbf{On end:}}
\begin{algorithmic}[1]
\REQUIRE Step ?? of Algorithm 3.

\STATE Find the largest interval $I$ of $g_{i+1}$ that does not exceed $\epsilon$ by a given %.
\IF {$g_i$ satisfies the $\epsilon$ for all $h^\perp$'s} \STATE BREAK
\ENDIF
\STATE Split $g_i$
\STATE Remove used $h^\perp$ from list.
\STATE Start Algorithm 3 again using the new $h^\perp$, and the start/end point of $g_i$
\ENSURE Continue from Step ?? of Algorithm 3.
\end{algorithmic}
\end{algorithm}

<div id="piecewiseResults">
![](resources/images/vector/Results-PiecewiseEvolution-Positive.svg){#fig:piecewisePositiveCurv width=100%}
![](resources/images/vector/Results-PiecewiseEvolution-Negative.svg){#fig:piecewiseNegativeCurv width=100%}
![](resources/images/vector/Results-PiecewiseEvolution-Double.svg){#fig:piecewiseDoubleCurv width=100%}

Piecewise evolution method applied to: (a) a positive curvature surface, (b) a negative curvature surface and (c) a doubly curved surface.
</div>

<div id="fig:piecewiseEvolExample">
![](resources/images/png/PiecewiseTestView2.png){#fig:piecewiseTestView2 width=45%}
![](resources/images/png/PiecewiseTest.png){#fig:piecewiseTest width=45%}

$(a)$ Perspective view; $(b)$ Top View. In red, the initial geodesic curve; in blue, the generated piecewise geodesic pattern; the red dots are breakpoints in the piecewise geodesic curves.
</div>

## Level-Set Method {#sec:level-sets}

We can also compute geodesic curve patterns on a surface as a series of levels (or level-sets) of a scalar-valued function assigned on each vertex of a mesh. This concept was first introduced in @Wallner2010tiling and is based on concepts developed in the geodesic active contour method.

![Calculating a level set on a single face](resources/images/vector/LevelSet-SingleTriangle.svg){#fig:levelSetFace}

The computation of level-sets on a triangle mesh is a fairly simple task. Since the values of the function are assigned per vertex, the line of a constant value of the function is obtained by linear interpolation on each of the mesh faces [@fig:levelSetFace]. The gradient of the scalar-valued function also needs to be calculated, which results in a vector field which is constant on each face. Once the gradient has been computed, the geodesic curvature of a level set can be obtained as the divergence of the gradient vector field over each vertex:

> $$K_g = div(\frac{\nabla \phi}{||\nabla \phi ||})$$

In order that the obtained levels approximate the surface, we can approach the problem as the minimization of a combination of error measurements:

> $$F_{min} = F_k + \lambda F_\nabla + \nu F_w$$

where $F_k$ measures the deviation of the scalar function geodesic property, $F_\nabla$ is computed for regularization purposes and $F_w$ measures the constant-width deviation; $\lambda$  and $\nu$ are user defined weighting values. $F_k$ and $F_w$ will only vanish at the same time in the case of developable surfaces. This values can be computed on a mesh (V,E,F) using the following formulas, explained with more detail in @Pottmann2010-ku:

> $$F_k = \sum_{\mathbf{v}\in V}{\mathcal{A}(\mathbf{v})\bigg(div(\frac{\nabla \phi}{||\nabla \phi ||}(\mathbf{v}))\bigg)^2}$$
> $$F_\Delta = area(S)\sum_{\mathbf{v}\in V}{\mathcal{A}(\mathbf{v})\Delta \phi(\mathbf{v})^2}$$
> $$F_w = \sum_{f\in F}area(f)\bigg(||\nabla\phi(f)||- \frac{h}{w}\bigg)^2$$

The algorithm would be started with a set of randomly placed values on each vertex of the mesh [@fig:levelSetStart]. The implementation used in this paper differs from the originally proposed in @Pottmann2010-ku, in which the Gaussian-Newton method is used for minimization and all high order derivatives are computed analytically. In our implementation, we explored the application of gradient-less minimization algorithms, in particular BOBYQA (Bound Optimization BY Quadratic Approximation) although this decision causes computation times to increase severely.

![Starting conditions for the level set method on a double curve surface](resources/images/vector/Results-LevelSets-Start.svg){#fig:levelSetStart width=100%}

![Final result of the level set method over a complex double curve surface.](resources/images/vector/Results-LevelSets-End.svg){#fig:levelSetEnd width=100%}

## Geodesic Webs

We can also expand the Level-Set method explained in the previous section from one family of curves to several families of interconnected quasi-geodesic curves by simply computing several sets of scalar functions on each vertex of the surface.

This can be easily done by adding another equation to our minimization problem.

> $$\nu \dot F_{angle} = \nu \dot \sum_{f\in F} \frac{area(f)}{area(S)}\langle \frac{\nabla\phi_i}{||\nabla\phi_i||}.R_{\frac{\pi}{2}-\alpha}(\frac{\nabla\phi_j}{||\nabla\phi_j||})\rangle^2$$ {#eq:levelSetAngle}

where $\nu$ is the weight given to $F_{angle}$, $R_{\frac{\pi}{2}-\alpha}$ means the rotation by the angle $\frac{\pi}{2}-\alpha$ in the respective face.

<div id="fig:geodesicWebs">
![](resources/images/GeodPatterns/geodPattern-figure-41.png){#fig:geodesicWebs1}
![](resources/images/GeodPatterns/geodPattern-figure-02.png){#fig:geodesicWebs2}

Beam structure generated by the geodesic web method.
</div>

## Geodesic Vector fields

The level-set method described in [@Sec:level-sets] is not suitable for arbitrary surfaces, and therefore it must be adapted to achieve the desired result. In this section, we introduce the concept of *Geodesic Vector-fields* [@Pottmann2010-ku] to divide the surface into patches that could be easily covered by equal width panels using the level-set method.

<div id="fig:geodVectorFields">
![](resources/images/GeodPatterns/geodPattern-figure-31.png){#fig:gvfStep1 width=25%}
![](resources/images/GeodPatterns/geodPattern-figure-32.png){#fig:gvfStep2 width=25%}
![](resources/images/GeodPatterns/geodPattern-figure-33.png){#fig:gvfStep3 width=25%}
![](resources/images/GeodPatterns/geodPattern-figure-34.png){#fig:gvfStep4 width=25%}

Geodesic vector fields
</div>

A geodesic vector field on a surface $S$ is geodesic if it consists of tangent vectors of a 1-parameter family of geodesics covering $S$ [@Pottmann2010-ku].

Considering the surface $S$ as a triangle mesh (V,E,F), the vector field is represented by unit vectors $\mathbf v_f$ attached to the incenters of facef $f \in F$.

> $$\mathbf v_{f_2} = \mathbf v_{f_1} + J_{f_1} \dot (m_{f_2} - m_{f_1}) + r_e$${#eq:vectorField}

> $$ where J_f = XXXX$$

The vector field $\mathbf v = (\mathbf v_f)_{f \in F}$ is a geodesic vector field if it's length is constant for all faces $f$, and we can find a collection of coefficients $\mathbf g = (\mathbf g_f)_{f \in F}$ with $\mathbf g_f = (g_{1,f},g_{2,f},g_{3,f})$, such that [@eq:vectorField] holds with $\mathbf r$'s bellow some theshold.

The following equation quantifies how well $\mathbf v$ satisfies the geodesic property:

> $$ Q(\mathbf v) = min_{g\in R^{ 3|F| }}$${#eq:minimizeGeodVectorFields}

![Final result of geodesic vector fields method](resources/images/GeodPatterns/geodPattern-figure-01.png){#fig:geodesicVectorFieldResults}

## Panel modeling {#sec:panel-modeling}

In this section, we will discuss several ways to generate panels from curves lying on a given surface:

### The Bi-Normal Method {-}

The second method for defining panels, once an appropriate system of geodesics has been found on $\Phi$, works directly with the geodesic curves.

> Assume that a point $P(t)$ traverses a geodesic $s$ with unit speed, where $t$ is the time parameter.
> For each time $t$ there is:
>
> * a velocity vector $T(t)$
> * the normal vector $N(t)$
> * a third vector $B(t)$, *the binormal vector*
>
> This makes $T.N.B$ a ***moving orthogonal right-handed frame***

Although this method generates mathematically correct developable surfaces, @Pottmann2010-ku describes it is unclear that the boundaries of the panels generated with this technique will correspond to real constructive requirements for the design, so we concentrate our efforts on method explained in the following section.

### Tangent-developable method {-}

The notion of ***Conjugate tangents*** on smooth surfaces must be defined:

> * Strictly related to the ***Dupin Indicatrix***
> * In negatively curved areas, the Dupin Indicatrix is an hyperbola whose asymptotic directions (A1, A2)
> * Any parallelogram tangentially circumscribed to the indicatrix defines two conjugate tangents **T** and **U**.
> * The asymptotic directions of the Dupin indicatrix are the diagonals of any such parallelogram.

<div id="fig:tangentDevMethod">
![](resources/images/vector/Panels-TangentDevelopable.svg){#fig:singlePanel width=50%}
![](resources/images/vector/Panels-TangentDevelopableModified.svg){#fig:panelPattern width=50%}

Computing panels using the tangent developable method: (a) generation of one panel and (b) modification of the procedure proposed in @Pottmann2010-ku.
</div>

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

\begin{algorithm}
\label{alg:panels}
\caption{Panels: Modified Tangent-developable method}
\algsetup{indent=1em}
\small
\begin{algorithmic}[1]
\REQUIRE The reference surface $\Psi$, represented as a mesh (V,E,F) and a geodesic pattern of curves $g_{0...N}$
\STATE Compute the *tangent developable surfaces* $\Psi_i$ for all surfaces $s_i \rightarrow i=\text{even numbers}$
\STATE Delete all rulings where the angle enclose with the tangent $\alpha$ is smaller than a certain threshold (i.e. 20º).
\FORALL {Rulings}
\STATE Determine points $A_i(x)$ and $B_i(x)$ which are the closest to geodesics $s_{i-1}$ and $s_{i+1}$. This serves for trimming the surface $\Psi_i$.
\ENDFOR
\STATE Trim $\Psi_i$ with the curve generated from all points $A_i(x)$ and $B_i(x)$ respectively.

\ENSURE Trimmed developable surface $\Psi_i$.
\end{algorithmic}
\end{algorithm}

This adjustments to the algorithm allow for the modeling of panels that meet the requirements of developability and approximately constant width, although it must be noted computation times increase, as double the  amount of geodesic curves need to be generated, and subsequently, the desired width function needs to be half the desired width of the panels. [@Fig:tangentDevMethod] shows the result of computing such panels and the subsequent gaps between the generated panels; these gaps need to be kept within a certain width in order to produce a successful watertight panelization of the original surface. Furthermore, material restrictions such as bending or torsion where not taken into account during the construction of the panels.

# Quality Assessment {#sec:quality-assessment}

## Panel gaps

Since we are generating the panels using the tangent developable method, it is inevitable that some gaps appear between panels, especially when there is a high degree of curvature in the area. We can take this into account when calculating the trim curves, and obtain the maximum gap values of the model. The gap width is strictly related to the thickness of the panel, so if the maximum width of the gaps exceeds a desired a specified distance, computing narrower panels under the same conditions should guarantee the watertightness of the solution.

![. On the left, the computed panels using the *tangent developable method* with the corresponding panel gaps highlighted in red. On the right, panels colored by distance to reference mesh. Maximum gap size = ](resources/images/vector/PTPanels&DistanceToMesh.svg){#fig:panelGaps fig.pos="H"}

## Stress and strain in panels

The following section investigates the behavior of a rectangular strip of elastic material when it is bent to the shape of a ruled surface $\Psi$ un such way that the central line $m$ of the strip follows the *'middle geodesic'* $g$ in $\Psi$. This applies to both methods defining panels.[@fig:panelGaps]

* Lines parallel to $m$ at distance $d/2$ are not only bent but also stretched.
* If you introduce the radius of Gaussian curvature $\rho = 1 / \sqrt{|K|}$...
* ...the relative increment in length of the strip is:

$$\varepsilon=\frac{1}{2}(d/2\rho)^2+\cdots$${#eq:strain}

### Tensile stress {-}

Tensile stress is estimated by expressing stress as $\sigma = E\varepsilon$,  which yields

$$ d/2\rho\leq C,\quad{with}\quad{C=\sqrt{\sigma _{max}/E}}$$ {#eq:maxWidth}

where $\rho_{max}$ is the maximum admissible stress and is Young's modulus. Since this calculation is an approximation, a safety factor must be used when choosing $\rho_{max}$.

$C$ is a material constant, from which we can obtain an upper width bound for the panels by $d_{max} = 2\rho_{min}C$, which will be the maximum admissible width for that design configuration.

### Bending and shear stress {-}

Bending ($\sigma$) and shear stresses ($\tau$) for panels with a thin rectangular cross-section depend on the panel thickness $h$, but not on the panel width $d$ ***if*** $h/d \ll 1$, and maximum values occur on the outer surface of the panel [@Wallner2010tiling].

These values depend on the curvature $\kappa$ of the central geodesic and the rate of torsion $\theta$  of the panel. We have:

$$\sigma = E \kappa h/2 \quad and\quad \tau = hG\theta$${#eq:bendingAndShear}

It is important to note that $\tau$, measured by arc per meter, does not exceed $\sqrt{|K|} = 1/\rho$, where the maximum value occurs in case the central geodesic's tangent happens to be an asymptotic direction of the panel surface [@DoCarmo2016kx].

It is standard procedure to combine all stresses (tension, shear, bending) and use this information for checking panel admissibility.

Also, as one might conclude straight away, panels generated using the tangent developable method will experience less shear than the ones created by the 'binormal' method.

| Material  | Young modulus \ E[N/mm^2] | Maximum stress \ $\nabla_{max}$[N/mm2] | constant  \ $C=\sqrt{2\nabla_{max}/E }$ |
|---|---|---|---|
| Wood |  13000 | 80 |  0.11 |
| Steel | 200000  | 250  | 0.05  |
| Titanium |  |   |   |
: Computing the constant for each material by measuring some sample values on the surface.

From here we can also check the admissibility of the computed models using the formulas described above. 

| Figure no.| Material | Panel Width (m) | $|K|_{max}[m^-2]$ | $\rho_{min}$ | Admissible width (m) | Admissible? |
|:-:|---|---|---|---|---|---|
|   |   |   |   |   |   |   |
|   |   |   |   |   |   |   |
|   |   |   |   |   |   |   |
: Panelization solution admissibility check.

Since the examples in this publication where created for illustration purposes, many of the models will not be admissible for fabrication. However, once a max panel width is calculated, if the design is not admissible, one can calculate *narrower* panels using the maximum calculated width in order to have an admissible model.

# Conclusions

> TEMPORARY

1. Parallel transport method and evolution method is only useful for simple surfaces of constant curvature, where the behavior of the generated geodesics can be easily predicted.
2. Piecewise evolution method is useful for any kind of surface, but there is a lack of control over the breakpoint positions, which might be undesirable depending on the design intention of the architect.
3. Level-set method, coupled with the geodesic vector fields, is a perfect solution to enable user interaction during the pattern design process, although in our implementation, we did not achieve sufficiently low computation times for this to be a possibility. It will also be necessary to check the deviation of the resulting curves' geodesic property, since depending on the reference surface and the user specified weights, the generated pattern can deviate from true geodesics.

```{.mermaid width=3000 theme='neutral'}
graph LR
C[Parallel Transport]
D[Evolution]
E[Piecewise Evolution]
F[Level-sets]
G[Geodesic Vector Fields]
H(Triangle mesh developability)

subgraph Simple Surfaces
C
D
F
end

subgraph Shape Optimization
H
end

subgraph Pattern Generation
C
F --> G
C --> D
D --> E
end

C --> I[Results are satisfactory? ]
D --> I
F --> I
G --> I
E --> I
I --> |No|H
I --> |Yes| Finish!
H --> J[Start Again]
```

# References