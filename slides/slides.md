---
title: "Geodesic Patterns"
subtitle: "for Freeform Architecture"
author: "Alan Rynne"
date: "September 2018"
institute: "UPC - MPDA'18"
bibliography: [input/MPDABibliography.bib]

# Beamer
latex-engine: xelatex
theme: metropolis
colortheme: dove
fonttheme: serif
fontsize: 8pt

# Reveal.js styles
css: ../slides/slides.css

# Other options
header-includes:
  \usepackage{opensans}
  \usepackage{algorithmic}
  \usepackage{xcolor}
  \usepackage{svg}
  \usepackage{svgcolor}
  \usepackage{caption}
  \renewcommand{\algorithmicrequire}{\textbf{Input:}}
  \renewcommand{\algorithmicensure}{\textbf{Output:}}
  \setbeamercolor{frametitle}{fg=white,bg=black}
  \setbeamercolor{titlepage}{fg=white,bg=black}
  \setbeamertemplate{frametitle}{
    \nointerlineskip
    \begin{beamercolorbox}[ht=2.2em,wd=\paperwidth]{frametitle}{
      \fontfamily{opensans}\selectfont
      \vfill\hspace*{6pt}\strut\scriptsize\text{Geodesic Patterns - Alan Rynne Vidal}\break
      \hspace*{16pt}\normalsize\insertframetitle\strut\vfill}
    \end{beamercolorbox}}
  # \usepackage{pgfpages}
  # \pgfpagesuselayout{2 on 1}
---

# Objective

## Objective

Discretize a given freeform surface into planks with the following properties:

1. Must be ***developable*** [@shelden2002digital]

2. Should tend to have approximate ***equal width***  

3. Should be ***as straight as possible***

4. Cannot bend by their strong axis but,

5. can have a twist and bend by their weak axis

## Objective

Plank
: A plank is timber that is flat, elongated, and rectangular with parallel faces that are higher and longer than wide. ([Wikipedia](https://en.wikipedia.org/wiki/Plank_(wood)))

<div id="fig:planks">
![](resources/images/vector/HyparPlanks.svg){#fig:hyparPlanks width=33%}
![](resources/images/vector/CylinderPlanks.svg){#fig:cylinderplanks width=66%}

Straight planks bent on a hyperbolic paraboloid (a) and a cylindrical surface (b).
</div>

# Background

## Background

The use of *straight developable planks* is widely used in:

![Traditional boat building](http://woodboatbuilder.com/maid-planking/sm13planks.jpg){width=60%}

## Background

Also common practice in naval engineering industry:

![Connected developable patches for boat hull design](https://github.com/AlanRynne/MPDA_18-MasterThesis/raw/master/slides/slideImages/developableHull.jpeg){width=70%}

## Background

The architecture studio NOX was one of the first to experiment with paper strips.

:::::::::{.columns}
:::{.column width=50%}
![NOX Strips models](resources/images/GeodPatterns/geodPattern-figure-03.png){#fig:noxStrips}
:::
:::{.column width=50%}
![NOX render of strip model](resources/images/GeodPatterns/geodPattern-figure-04.png){#fig:noxRender}
:::
:::::::::

## Background

This techniques have also been used in the architecture world, mainly by **Frank Ghery**.

His façades are usually a collection of connected developable surfaces.

<div id="fig:gheryBackground">
![](resources/images/background/guggenheim.jpg){#fig:guggenheimMuseum width=33%}
![](resources/images/background/waltDisneyConcertHall.jpg){#fig:waltDisneyHall width=33%}
![](resources/images/background/guggenheimAbuDhabi.jpg){#fig:guggenheimAbuDhabi  width=33%}

Famous Ghery projects (right to left): Guggenheim Museum (Bilbao, 1997), Walt Disney Concert Hall (Los Angeles, 2003) and the Guggenheim Abu Dhabi winning proposal (Abu Dhabi, --)
</div>

## Background

Latest architectural work following similar techniques was:

![Burj Khalifa by Frank Ghery](https://cdn.archpaper.com/wp-content/uploads/2012/04/BurjKhalifa05.jpg){width=60%}

## Background

:::::::::{.columns}
:::{.column width=65%}
It was designed as a collection of:

* **Developable surfaces**
  * *Which can be covered by equal width planks*  
* **Surfaces of constant curvature**  
  * *Which can be covered by repeating the same profile*  

:::
:::{.column width=35%}

![](https://www.dw.com/image/19172478_303.jpg)

:::
:::::::::

## Background

![Burj Khalifa final panel solution](https://cdn.archpaper.com/wp-content/uploads/2012/04/BurjKhalifa14.jpg){#fig:burjKhalifa width=100%}

## Background

Other projects of interest are:

<div id="fig:minaNoMori">
![](resources/images/background/minaNoMori.jpg){#fig:minaNoMoriInterior width=50%}
![](resources/images/background/minaNoMoriConstruction.jpg){#fig:minaNoMoriConstruction width=50%}

Interior view of Toyo Ito's Mina No Mori wooden lattice roof (a) and exterior view of the lattice under construction (b).
</div>

## Background

<div id="fig:shigeruGolf">
![](resources/images/background/shigeruYeojuConstruction.jpg){#fig:shigeruGolfPart width=49%}
![](resources/images/background/shigeruYeojuConstruction2.jpg){#fig:shigeruGolfConstruction width=49%}

Shigeru Ban's Yeoju Golf Resort. Right: Interior view of finished roof lattice. Left: Aerial view of lattice under construction.
</div>

# Construction technique

## Geodesic curves

A geodesic curve is the generalization of a *straight line* into *curved spaces*.

In this research, we concentrate on the concept of ***straightest geodesics***.

![Geodesics on a torus: Although $g_0$ and $g_1$ are both geodesics, one doubles the length of the other](resources/images/vector/ShortestGeodesics.svg){#fig:shortestGeod width=50%}

## Developable surfaces

![Surfaces with ***0 gaussian curvature***. Meaning, they can be flattened onto a plane ***without distortion***](resources/images/vector/DevelopableFromCurve.svg){#fig:devFromCurve}

## Developable panels

We are interested in:\
\
\

> Developable surfaces
> : \
>   
>   * surfaces that can be flattened.
>   * can be generated by a single curve.  
\

> Geodesic curves
> : \
>   
>   * are straight lines in a curved space.

## Developable panels

If
: Panels are generated using geodesic curves on the surface

Then
: Resulting panels will be ***developable*** and mostly ***straight*** when flat.

<div id="fig:planksAgain">
![](resources/images/vector/HyparPlanks.svg){#fig:hyparPlanks width=33%}
![](resources/images/vector/CylinderPlanks.svg){#fig:cylinderplanks width=66%}

Straight planks bent on a hyperbolic paraboloid (a) and a cylindrical surface (b).
</div>

## Developable panels

In other words
: \
  
  We wish to cover a given freeform surface with a pattern of **geodesic curves** with equal spacing.

  This can only be achieved if the provided surface is already ***developable***.\
  \
  A compromise exists between the ***curve spacing*** and the ***curve's geodesic curvature***

## Properties we aim for

Geodesic property
:  \ Look for ***straight*** or ***as straight as possible*** curves.\

Constant width property
: \ Curves that are ***equally spaced*** on the surface\


Developable property
: \ Surfaces generated from the curves ***MUST*** be developable.\

# Algorithmic strategies

## Obtaining Geodesic Patterns

These are the main methods for the obtaining successful geodesic patterns:

1. The ***parallel transport*** method
2. The ***evolution*** method
    1. The ***piecewise geodesic*** evolution method
3. The ***level-set*** method

# The parallel transport method

## Vector parallel transport

![Parallel transport of a vector over a path on a sphere](resources/images/vector/SpherePT.svg){#fig:ptSphere width=50%}

## Vector parallel transport

![Parallel transport over two adjacent mesh faces](resources/images/vector/Diagram-ParallelTransport.svg){#fig:ptDiagram}

## The parallel transport method

![Parallel transport method over a positive curvature surface](resources/images/vector/ParallelTransportMethod.svg){#fig:ptPositiveCurvature}

## The parallel transport method

![Parallel transport method diagram](resources/images/vector/Diagram-ParallelTransportMethod.svg){#fig:diagramPartTrans}

## The parallel transport method

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

## The parallel transport method

There are **three** *extreme* cases depending on the ***local gaussian curvature*** where $g$ lies on $\Phi$:

Positive curvature
: Panels will have **Maximum width** on $g$

Negative curvature
: Panels will have **Minimum width** on $g$

0 gaussian curvature:
: Panels will be  of equal width

<div id="parTransResults">

![](resources/images/vector/Results-ParallelTransport-Positive.svg){#fig:parTransPositiveCurv width=30%}
![](resources/images/vector/Results-ParallelTransport-Negative.svg){#fig:parTransNegativeCurv width=30%}
![](resources/images/vector/Results-ParallelTransport-Double.svg){#fig:parTransDoubleCurv width=30%}
</div>

## The parallel transport results

![Parallel transport results over a positive curvature surface. Starting geodesic (red) and geodesic pattern (white). **Máximum** distance between curves occur on $g$.](resources/images/vector/Results-ParallelTransport-Positive.svg){#fig:parTransPositiveCurv2}

## The parallel transport results

![Parallel transport results over a negative curvature surface. Starting geodesic $g$ (red) and geodesic pattern (white). **Minimum** distance between panels occur on $g$](resources/images/vector/Results-ParallelTransport-Negative.svg){#fig:parTransNegativeCurv2}

## The parallel transport results

![Parallel transport results over a doubly curved surface. Starting geodesic (red) and geodesic pattern (white).](resources/images/vector/Results-ParallelTransport-Double.svg){#fig:parTransDoubleCurv2}

# The Evolution Method

## The Evolution Method

![Calculating the best-fit geodesic](resources/images/vector/Diagram-BestFitGeodesic.svg){#fig:bestFitGeodesic}

## Evolution Implementation

:::::::::{.columns}
:::{.column width=50%}
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
:::
:::{.column width=50%}
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
:::
:::::::::


## Evolution Method Results

![Evolution method results over a positive curvature surface. Starting geodesic (red), geodesic pattern (white) and results from [@fig:parTransPositiveCurv2] (dashed gray lines).](resources/images/vector/Results-Evolution-Positive.svg){#fig:evolPositiveCurv width=100%}

## Evolution Method Results

![Evolution method results over a negative curvature surface. Starting geodesic (red), geodesic pattern (white) and results from [@fig:parTransNegativeCurv2] (dashed gray lines).](resources/images/vector/Results-Evolution-Negative.svg){#fig:evolNegativeCurv width=100%}

## Evolution Method Results

![Evolution method results over a doubly curved surface. Starting geodesic (red), geodesic pattern (white) and results from [@fig:parTransDoubleCurv2] (dashed gray lines).](resources/images/vector/Results-Evolution-Double.svg){#fig:evolDoubleCurvature width=100%}

## Evolution Method Results

Local changes in curvature produce:

* Sharp panel endings in positive curvature areas
* Panel width increase in negative curvature areas

<div id="evolMethodExample">
![](resources/images/png/CuttyEvolutionMethod.png){#fig:evolutionExample width=45%}
![](resources/images/png/CuttyEvolutionMethod2.png){#fig:evolutionProblems width=45%}

Evolution method example: top view (a), perspective view (b) with highlighted unwanted results.
</div>

# The Piecewise Evolution Method

## The Piecewise Evolution Method

![Calculating the best piece-wise geodesic](resources/images/vector/Diagram-PieceWiseGeodesic.svg){#fig:bestPiecewiseGeodesic}

## Piecewise Ev. Implementation

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

## Piecewise Ev. Results

![](resources/images/vector/Results-PiecewiseEvolution-Positive.svg){#fig:piecewisePositiveCurv width=100%}

## Piecewise Ev. Results

![](resources/images/vector/Results-PiecewiseEvolution-Negative.svg){#fig:piecewiseNegativeCurv width=100%}

## Piecewise Ev. Results

![](resources/images/vector/Results-PiecewiseEvolution-Double.svg){#fig:piecewiseDoubleCurv width=100%}

## Piecewise Ev. Results

![Piecewise Test](resources/images/png/PiecewiseTestView2.png){#fig:piecewiseTestView2}

## Piecewise Ev. Results

![Piecewise Test](resources/images/png/PiecewiseTest.png){#fig:piecewiseTest}

# The level set method

## Mesh Level-sets

![Level set on a single mesh face](resources/images/vector/LevelSet-SingleTriangle.svg){#fig:levelSetFace}

## Level-set Start Condition

![Starting conditions for the level set method on a double curve surface](resources/images/vector/Results-LevelSets-Start.svg){#fig:levelSetStart width=100%}

## Computed level sets

![Final result of the level set method over a complex double curve surface.](resources/images/vector/Results-LevelSets-End.svg){#fig:levelSetEnd width=100%}

# Piecewise geodesic vector-fields

[^PottmanPatterns]: Image taken from @Pottmann2010-ku

## Piecewise geodesic vector-fields

![Geodesic pattern example[^PottmanPatterns]](resources/images/GeodPatterns/geodPattern-figure-01.png){#fig:geodFieldExample}

## Piecewise geodesic vector-fields

The objective is to divide or *cut* the mesh into areas that will be easilly covered by a 1-pattern of geodesics [^PottmanPatterns].

:::::::::{.columns}
:::{.column width=50%}
![User specified directions](resources/images/GeodPatterns/geodPattern-figure-32.png){#fig:geodFieldUser}
:::
:::{.column width=50%}
![Computed geodesic vector field & cuts](resources/images/GeodPatterns/geodPattern-figure-33.png){#fig:geodFieldCuts}
:::
:::::::::

This is done by computing a *geodesic vector field* over the surface, in a way that it aligns with several user specified directions.

# Modeling planks

## Tangent-developable method


Given any point in $g$:

1. Assuming $T(x)$ is tangent $g$.  
2. Compute $U(x)$ as $T(x)\times N_\Phi(x)$

> The union of all $U(x)$ is a developable ruled surface $\Psi$.

![Tangent developable method for panels](resources/images/vector/Panels-TangentDevelopable.svg){#fig:tangDevPanels}

## Tangent-developable method

Initial algorithm is as follows:

> For all geodesics $s_i$ in a given pattern:

1. Compute the *tangent developable surfaces* $\rightarrow\Psi_i$
2. Trim $\Psi_i$ along the intersection curves with their respective neighbours.
3. Unfold the trimmed $\Psi_i$, obtaining the panels in flat state.

***Unfortunately***, this method needs to be refined in order to work in practice because:

1. The rulings of tangent developable may behave in weird ways
2. The intersection of the neighboring $\Psi_i$'s is often *ill-defined*.

## Tangent-developable method

Therefore, the procedure was modified in the following way:

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

## Tangent-developable method

![Panels computed using the using the modified tangent developable method.](resources/images/vector/Panels-TangentDevelopableModified.svg){#fig:tangentDevMethod}

# Analysis

## Stress in panels

> **Assuming the material:**

* is bent to the shape of a ruled surface $\Psi$
* the central line $m$ of the plank follows the *'middle geodesic'* in $\Psi$.\
\

> **Then:**

* Lines parallel to $m$ at distance $d/2$ are not only bent but also stretched.

## Stress in panels

If we introduce the radius of Gaussian curvature $\rho = 1 / \sqrt{|K|}$

the relative increment in length $\varepsilon$ (strain) of the strip is:

:::::::::{.columns}
:::{.column width=50%}
\
$$\varepsilon=\frac{1}{2}(d/2\rho)^2+\cdots $$ {#eq:strain}

:::
:::{.column width=50%}
### Where:

* $d$ is the plank width
* $\rho$ is the radius of gausian curvature
:::
:::::::::

## Tensile stress

Tensile stress can be expressed as $\sigma = E\varepsilon$[^safety], which yields:

$$ d/2\rho\leq C,\quad{with}\quad{C=\sqrt{\sigma _{max}/E}}$$

$$\sigma_{max} = \text{maximum admissible stress}$$
$$E = \text {Young's modulus}$$

[^safety]: Since this calculation is an approximation, a safety factor must be used when choosing $\sigma_{max}$.

## Admissible panel width

$$ d/2\rho\leq C,\quad{with}\quad{C=\sqrt{\sigma _{max}/E}}$$

Since $C$ is a material constant. We obtain the maximum admissible width with:

$$d_{max} = 2\rho_{min}C$$

## C constant

> Maybe missing an image here?

|  Material |  Young Modulus | Max. stress | $C$ |
|---|---|---|---|
| Wood | 200000  |   |   |
| Steel | 13000  |   |   |
| Others? | ? | | |
: Example calculation of constant $C$ for some of the most suitable materials.

## Admissibility for models

> INSERT IMAGE!!!

## Bending and shear stress

> **Only for panels with thin rectangular cross-sections ($h/d \ll 1$)**

Bending ($\sigma$) and shear stresses ($\tau$) depend on:

Panel thickness $h$ but ***not*** on the panel width $d$.

## Temp Title

Maximum values occur on the outer surface of the panel [@Wallner2010tiling] and depend on:

* the curvature $\kappa$ of the central geodesic
* the rate of torsion $\theta$  of the panel.

> $$\sigma = E \kappa h/2 \quad and\quad \tau = hG\theta$${#eq:bendingAndShear}

Where $G$ is the shear modulus.

## Temp Title

$\tau$, measured by arc per meter, does not exceed $\sqrt{|K|} = 1/\rho$,

maximum value ocurs if:

* the central geodesic's tangent is an asymptotic direction of the panel surface [@DoCarmo2016kx].

## Temp Title

It is standard procedure to combine all streses (tension, shear, bending) and use this information for checking panel admissibility.

INSERT RESULTS!!!

# Conclusion

## Temp Title

```{.mermaid width=3000 theme='neutral'}
graph LR
A[Choose a method]
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

## Temp Title

* Parallel transport method is ONLY usefull when surfaces are developable or *nearly* developable.
* Evolution Method improves upon it's predecessor but still lacks the ability to maintain equal thickness over complex surfaces.
* *Piecewise* evolution method gives the best results overall.
* *Level-set method* can be used to calculate geodesic webs.
  * To cover freeform surfaces it need to be coupled with the geodesic-vector field technique.
* *Geodesic vector fields* is an introductory step to cut the mesh into pieces that will be easily covered by a 1-pattern of geodesic curves.
* *Developalizing* the surface is an extreme measure, since during the process, the overall smoothness of the surface will be lost. It can still be done in a controlled manner to reduce areas of high curvature.

[^acknowledgments]: Special thanks to ... FILL IN LATER!  
  \
  \

# Thanks [^acknowledgments]
  
# Appendix

## Resources

> PUT LINKS TO GH COMPONENTS HERE + OTHER NICE SOFTWARE!

## References {.allowframebreaks}