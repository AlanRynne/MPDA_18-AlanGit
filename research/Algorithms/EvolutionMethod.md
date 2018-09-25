---
title: MPDA'18 Algorithms
header-includes:
    \usepackage{algorithmic, algorithm}
    \renewcommand{\algorithmicrequire}{\textbf{Input:}}
    \renewcommand{\algorithmicensure}{\textbf{Output:}}
---

\begin{algorithm}
\label{alg:parTrans}
\caption{Parallel Transport Method}
\algsetup{indent=1em}
\scriptsize
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



\begin{algorithm}
\label{alg:evolMethod}
\caption{Evolution Method}
\algsetup{indent=1em}
\scriptsize
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



\begin{algorithm}
\label{alg:bestFit}
\caption{Calculate the best-fit geodesic}
\algsetup{indent=1em}
\scriptsize
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




\begin{algorithm}
\label{alg:piecewise}
\caption{Calculate the best-fit piecewise geodesic}
\algsetup{indent=1em}
\scriptsize
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




\begin{algorithm}
\label{alg:panels}
\caption{Panels: Modified Tangent-developable method}
\algsetup{indent=1em}
\scriptsize
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