# TIFF Asymptotic Optimality

## Setup

Assume
\[
C(t)=C(0)e^{at},\qquad a<0,\qquad D(t)=D_0.
\]

Define the threshold time
\[
t_0=\frac{1}{a}\ln\!\left(\frac{D_0}{C(0)}\right).
\]

For \(a<0\), write
\[
a=-|a|.
\]

Then
\[
t_0=-\frac{1}{|a|}\ln\!\left(\frac{D_0}{C(0)}\right).
\]

Positivity of \(t_0\) requires
\[
D_0<C(0).
\]

## Optimal discount

The asymptotic optimal discount is
\[
\rho^*=
\frac{2|a|}{\ln\!\left(\frac{C(0)}{D_0}\right)}
-\frac{|a|}{2}
+\frac{|a|}{8}\ln\!\left(\frac{C(0)}{D_0}\right).
\]

## Asymptotic TIFF

The discounted TIFF satisfies
\[
\mathrm{TIFF}_{\rho^*}(S)
\sim
\frac{D_0}{\rho^*}e^{-2}
-
\frac{C(0)}{\rho^*+|a|}e^{-2-|a|t_0}.
\]

Hence the leading term is
\[
\mathrm{TIFF}_{\rho^*}(S)\sim
\frac{D_0}{\rho^*}e^{-2}.
\]

## Status

Conditional on the preceding asymptotic expansion and root-selection chain.
