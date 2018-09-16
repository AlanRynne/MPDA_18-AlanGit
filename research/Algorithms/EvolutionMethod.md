---
title: MPDA'18 Algorithms
classoption: twocolumn
header-includes:
    \usepackage{algorithmic, algorithm}
    \renewcommand{\algorithmicrequire}{\textbf{Input:}}
    \renewcommand{\algorithmicensure}{\textbf{Output:}}
---

\begin{algorithm}
\label{parTransAlgo}
\caption{Geodesic patterns by parallel transport}
\algsetup{indent=1em}
\scriptsize
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



\begin{algorithm}
\label{evolMethodAlgo}
\caption{Geodesic patterns by evolution method}
\algsetup{indent=1em}
\scriptsize
\begin{algorithmic}[1]
\REQUIRE A surface $\Phi$, represented as a triangular mesh (V,E,F)
\ENSURE Set $G$ of geodesic curves $g_i,\quad where \quad i=0,...,M$
\STATE Place a geodesic curve $g_0$ along $\Phi$
\STATE Divide the curve into equally spaced points $p$ with distance $W$.
\FORALL {points $p_i$\quad where \quad $i=0,...,N$}
\STATE Find tangent vector $\mathbf{v}^T_i$ of $g$
\STATE Rotate $\mathbf{v}^T_i$ by $\frac{\pi}{4}$
\STATE Generate geodesic $h^\perp_i$ from $p_i$ and $\mathbf{v}^T_g$
\ENDFOR

\RETURN Geodesic pattern $G$.
\end{algorithmic}
\end{algorithm}



\begin{algorithm}
\label{bestFitAlgo}
\caption{Calculate the best-fit geodesic}
\algsetup{indent=1em}
\scriptsize
\begin{algorithmic}[1]
\REQUIRE Initial curve $g_0$,perp geodesics $h^\perp$, desired width $W$ and starting index $i$
\ENSURE The next geodesic curve that best fits $W$.
\STATE Get points along all $h^\perp$ at length $W$
\STATE 
\RETURN Geodesic curve $g$.
\end{algorithmic}
\end{algorithm}

\begin{algorithm}
\label{piecewiseAlgo}
\caption{Calculate the best-fit geodesic}
\algsetup{indent=1em}
\scriptsize
\renewcommand{\algorithmicrequire}{\textbf{Start from:}}
\renewcommand{\algorithmicensure}{\textbf{On end:}}
\begin{algorithmic}[1]

\REQUIRE Step ?? of Algorithm 3.
\ENSURE Continue from Step ?? of Algorithm 3.

\STATE Find the best piecewise geodesic  $g_i$ that satisfies a threshold $\epsilon$ for the largest interval $I$
\STATE Cut $g_i$ using curves $h_{I_{min}}^\perp$ and $h_{I_{max}}^\perp$
\IF {DOMAIN($I$) = COUNT($h^\perp$)} \RETURN \ENDIF

\STATE Remove used $h^\perp$ from list.
\STATE Start Algorithm 3 again using the new $h^\perp$, and the start/end point of $g_i$

\end{algorithmic}
\end{algorithm}