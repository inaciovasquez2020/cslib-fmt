# TIFF Global Closure

## Admissible class

Let
\[
f(t)=(D(t)-C(t))_{+}\in L^1_{\mathrm{loc}}([0,\infty)),
\]
and assume
\[
\exists \rho_0>0:\ \int_{0}^{\infty} e^{-\rho_0 t}f(t)\,dt<\infty.
\]

Define
\[
\mathcal{D}:=\{\rho>0:\ \int_{0}^{\infty} e^{-\rho t}f(t)\,dt<\infty\}.
\]

## Functional

\[
\mathrm{TIFF}_\rho(S)=\int_{0}^{\infty} e^{-\rho t}f(t)\,dt.
\]

## Regularity

For all \(\rho\in\mathcal{D}\),
\[
\frac{d}{d\rho}\mathrm{TIFF}_\rho(S)
=-\int_{0}^{\infty} t e^{-\rho t}f(t)\,dt,
\]
\[
\frac{d^2}{d\rho^2}\mathrm{TIFF}_\rho(S)
=\int_{0}^{\infty} t^2 e^{-\rho t}f(t)\,dt.
\]

## Boundary behavior

\[
\lim_{\rho\to\infty}\mathrm{TIFF}_\rho(S)=0,
\]
\[
\lim_{\rho\downarrow \inf\mathcal{D}}\mathrm{TIFF}_\rho(S)=+\infty.
\]

## Strict convexity

If \(f\not\equiv 0\), then
\[
\frac{d^2}{d\rho^2}\mathrm{TIFF}_\rho(S)>0.
\]

## Unique minimizer

\[
\exists!\ \rho^*\in \mathcal{D}:\ \frac{d}{d\rho}\mathrm{TIFF}_\rho(S)=0.
\]

## Closure

\[
\mathrm{TIFF}_\rho(S)\ \text{is well-defined, }C^2,\ \text{strictly convex on }\mathcal{D},\ \text{with a unique global minimizer}.
\]
