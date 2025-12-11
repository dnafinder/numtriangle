# numtriangle

[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=dnafinder/numtriangle)

Collection of MATLAB functions for generating classical and less classical number triangles and extracting the associated integer sequences (Bell numbers, Catalan numbers, Eulerian numbers, etc.).

The project is conceived as a small combinatorial toolbox: for each triangle there is

- a generator xxxtriangle.m that returns a (typically lower) triangular matrix;
- when meaningful, a companion xxxnumber.m that extracts a sequence from that triangle (for example the first or last element of the last row).

All functions are self-contained and use only core MATLAB.

---

## ✨ Overview

numtriangle currently includes triangles and sequences from several families:

- Pascal-type and cumulative sums
- Bell and Catalan-related structures
- Bernoulli and Eulerian (Eulerian numbers, Entringer numbers)
- Geometric region-counting sequences
- Trinomial and parity/fractal triangles
- A few special-purpose arrays arising in number theory and combinatorics

All generators share a common interface:

- input: nonnegative integer n (row index, starting from 0);
- output: a numeric matrix whose nonzero part is a triangular array of integers;
- robust input validation with validateattributes;
- header with Syntax, Inputs, Outputs, Example, See also, GitHub reference, Citation.

Gog and Magog triangles (and related alternating sign matrix structures) are intentionally deferred for a future major expansion.

---

## 📚 Implemented functions (by topic)

### Pascal and derived

- pascaltriangle(n)  
  Lower-triangular form of Pascal’s triangle up to row n.

- bernoullitriangle(n)  
  Bernoulli’s triangle as cumulative row-wise sums of Pascal’s triangle.

- bernoullinumber(n)  
  Bernoulli numbers via a Hessenberg matrix built from Pascal’s triangle.

- eulertriangle(n)  
  Triangle of shifted Eulerian numbers; each row sums to n!.

- euleriannumber(n, k)  
  Eulerian number <n,k> extracted from eulertriangle.

- sierpinskitriangle(n)  
  Sierpiński triangle as pascaltriangle(n) modulo 2.

### Bell and set partitions

- belltriangle(n)  
  Bell triangle (Aitken/Peirce/Bell triangle) for set partitions.

- bellnumber(n)  
  n-th Bell number, extracted from belltriangle.

### Catalan-related

- catalantriangle(n)  
  Catalan’s triangle; Catalan numbers appear on the right-most nonzero diagonal.

- catalannumber(n)  
  n-th Catalan number from catalantriangle.

### Harmonic and up/down structures

- leibniztriangle(n)  
  Leibniz harmonic triangle. Returns both the denominator triangle and the harmonic matrix.

- seatriangle(n)  
  Seidel–Entringer–Arnold triangle (boustrophedon transform) of Entringer numbers.

- entringernumber(n, k)  
  Entringer number E(n,k) extracted from seatriangle.

### Geometric and region-counting sequences

- floydtriangle(n)  
  Floyd’s triangle in matrix form (consecutive integers, row by row).

- lazycaterernumber(n)  
  Lazy caterer’s number (maximum pieces from cutting a disk with n straight cuts), derived from floydtriangle.

- mosernumber(n)  
  Moser’s circle number: maximum regions obtained by joining n points on a circle with chords.

- rascaltriangle(n)  
  Rascal triangle (diamond-pattern analogue of Pascal’s triangle).

- cakenumber(n)  
  3D analogue of the lazy caterer: cake numbers (max regions of a cube cut by n planes), based on rascaltriangle.

### Other named triangles

- clarktriangle(n, f)  
  Clark’s triangle with diagonal entries equal to multiples of f and Pascal-type filling in the interior.

- lozanictriangle(n)  
  Lozanić (Losanitsch) triangle: Pascal-like triangle with parity-dependent corrections using Pascal’s triangle.

- trinomialtriangle(n)  
  Trinomial coefficients triangle, built via a three-term Pascal-type recurrence and row symmetry.

---

## 🧩 Design principles

- Deterministic: for each n, xxxtriangle(n) returns a unique, canonical triangle.
- Composable: several functions are defined in terms of others (for example bernoullitriangle and sierpinskitriangle depend on pascaltriangle).
- Readable: all functions follow a consistent header and documentation style and include a GitHub citation block.
- Robust: input validation with validateattributes for scalar, real, integer, nonnegative n (and extra parameters where relevant).

---

## 🚀 Installation

1. Clone the repository

   - Using Git:  
     git clone https://github.com/dnafinder/numtriangle.git

   - Or download the ZIP from the GitHub page and extract it.

2. Add the folder to your MATLAB path

   - In MATLAB:  
     addpath('path/to/numtriangle');  
     savepath;

After that, all functions (belltriangle, catalantriangle, eulertriangle, etc.) are available in your session.

---

## 💻 Usage examples

Basic usage is always:

- choose n (maximum row index, starting from 0),
- call the triangle generator,
- optionally extract a number sequence with the corresponding xxxnumber function.

Examples (MATLAB):

- Bell triangle and Bell numbers  
  n = 7  
  bt = belltriangle(n)  
  Bn = bellnumber(n)  

- Catalan triangle and Catalan numbers  
  n = 7  
  ct = catalantriangle(n)  
  Cn = catalannumber(n)  

- Eulerian triangle and a specific Eulerian number  
  n = 5  
  em = eulertriangle(n)  
  A52 = euleriannumber(5, 2)  

- Sierpiński triangle from Pascal mod 2  
  n = 10  
  sm = sierpinskitriangle(n)  
  imagesc(sm); colormap(gray); axis equal off;  

---

## 📦 Requirements

- MATLAB R2016b or later is recommended.
- No MathWorks toolboxes are strictly required.
- All files are plain .m functions.

---

## 🔭 Roadmap (short)

Planned extensions include:

- Narayana triangle and numbers (refinement of Catalan numbers),
- Stirling triangles (1st and 2nd kind) and Lah triangle,
- Additional path-counting triangles (Motzkin, Delannoy, Schröder),
- Simple visualization helpers for triangle patterns.

Gog and Magog triangles and related alternating sign matrix structures are deliberately postponed for a future major version, due to their combinatorial complexity and the fact that they define families of triangles rather than a single canonical triangle for each n.

---

## 📚 Citation

If you use this toolbox in academic work or teaching, you may cite:

Cardillo G. (2025). numtriangle: MATLAB toolbox for number triangles and related integer sequences. GitHub repository, https://github.com/dnafinder/numtriangle

Each function also contains a suggested citation format in its header.

---

## 👤 Author

Dr. Giuseppe Cardillo  
PhD in Biotechnological Sciences  
Scientific Director, MEDyLAB srl  
Email: giuseppe.cardillo.75@gmail.com
