# TODO

Tracking list for future work on the numtriangle MATLAB toolbox.

---

## 1. Core combinatorial extensions

1.1 Narayana triangle and numbers  
- Implement narayanatriangle(n) (lower-triangular Narayana numbers N(n,k), rows summing to Catalan numbers).  
- Implement narayananumber(n, k) as an accessor on narayanatriangle.  
- Add See also references from catalantriangle and catalannumber.

1.2 Stirling triangles (1st and 2nd kind)  
- Implement stirling2triangle(n) for Stirling numbers of the second kind S(n,k).  
- Implement stirling2number(n, k).  
- Implement stirling1triangle(n) for (unsigned or signed) Stirling numbers of the first kind.  
- Implement stirling1number(n, k).  
- Document relationships to belltriangle and bellnumber (sum of row of S(n,k) yields Bell numbers).

1.3 Lah triangle  
- Implement lahtriangle(n) (triangle of Lah numbers L(n,k), partitions into ordered blocks).  
- Implement lahnumber(n, k).  
- Cross-reference Lah and Stirling triangles in documentation.

---

## 2. Path-counting / lattice-path triangles

2.1 Motzkin triangle  
- Identify and fix a standard triangular layout for Motzkin-type refinements.  
- Implement motzkintriangle(n) with a clean recurrence and clear combinatorial interpretation.  
- Implement motzkinnumber(n) where appropriate.  
- Add See also links to catalantriangle and narayanatriangle.

2.2 Delannoy triangle  
- Implement a triangular form of Delannoy numbers D(n,k) with 0 ≤ k ≤ n.  
- Provide delannoytriangle(n) and delannoynumber(n, k).  
- Document connections with trinomialtriangle and path-counting interpretations.

2.3 Schröder-related triangle (optional)  
- Evaluate whether a Schröder triangle (for large Schröder numbers and refinements) adds real value.  
- Implement only if a standard definition and recurrence are identified.

---

## 3. Utilities and infrastructure

3.1 Visualization helpers  
- Implement a generic helper (for example plottriangle(A)) to visualize:  
  - raw integer values,  
  - parity patterns (mod p),  
  - logarithmic scaling for large values.  
- Provide at least one demo (for example demo_sierpinski) that shows sierpinskitriangle and other parity patterns.

3.2 Testing and validation  
- Create a small test suite using MATLAB’s testing framework (or simple assert-based scripts) to validate:  
  - correctness of initial rows against known values (from OEIS or literature) for each triangle,  
  - boundary conditions n = 0 and n = 1,  
  - cross-relations (for example row sums equal Bell, Catalan, factorial, etc.).  
- Verify that overflow warnings (where present) are consistent with flintmax and practical usage.

3.3 Documentation consistency  
- Ensure all functions:  
  - use lower-case filenames and function names,  
  - have consistent Syntax / Inputs / Outputs / Example sections,  
  - include See also lists pointing to related triangles and sequences,  
  - include the GitHub repository and per-file citation block in the header.  
- Add a compact function index (name, short description, category) to README.md.

---

## 4. Packaging and distribution

4.1 MATLAB toolbox packaging  
- Prepare a .mltbx toolbox, including:  
  - all .m functions,  
  - README.md,  
  - optional demos and examples,  
  - license file.  
- Verify installation on a clean MATLAB path.

4.2 Continuous integration (optional)  
- Set up a minimal GitHub Actions workflow (or similar) to:  
  - run the test suite on pushes and pull requests,  
  - optionally check basic MATLAB compatibility (if feasible).

---

## 5. Deferred (“apocalypse”) items

These items are intentionally postponed due to combinatorial complexity and because they define families of triangles rather than a single canonical triangle for each n.

5.1 Magog triangles  
- Design a validation function ismagog(T) to check Magog triangle constraints.  
- For very small n only: implement magogtriangles(n) that enumerates all Magog triangles via backtracking.  
- Optionally define a canonical magogtriangle(n) (for example lexicographically minimal) if a deterministic convention is desired.  
- Document relations to totally symmetric self-complementary plane partitions and related objects.

5.2 Monotone (Gog) triangles  
- Design a validation function ismonotonetriangle(T) for monotone (Gog) triangles with a fixed bottom row.  
- For small n: implement an enumerator for monotone triangles with bottom row (1, 2, ..., n).  
- Document the bijection between monotone triangles and alternating sign matrices.  
- Consider later, and only when the deterministic, “single triangle per n” design of numtriangle is fully stabilized.

These “apocalypse” items are out of scope for the current version of numtriangle and will be revisited only after the deterministic, single-triangle functions are complete and stable.
