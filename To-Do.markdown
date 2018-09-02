---
title: TO-DO List for Master Thesis on 'Geodesic patterns on freeform architecture'
author: Alan Rynne
date: 2018
---

# MPDA'18 Thesis - Geodesic Patterns

## To-Do List

- [x] Decide about image appearance
- [x] Finish reading references
- [x] Summarize all keypoints
- [x] Implement Parallel Transport
- [x] Implement evolution method
- [x] Implement piece-wise geodesic methods
- [x] Implement level sets
- [ ] Implement geodesic vector fields
- [ ] Implement geodesic webs 

## List of images to create

- [x] Parallel transport on a sphere
- [x] Parallel transport method explanation
- [x] Panels from parallel transport
- [x] Panels from evolution method
- [ ] Panels from evolution method + piecewise-geodesics
- [x] Creation of dev-panels from a given curve
- [x] Concept of shortest geodesics
- [ ] Geodesics as level sets
- [ ] Measurement of panelization quality (gaps, constant width, geodesic property)

## Revision 17/08/18

> **ASK ABOUT CV TO ST.RUCTURE**

- [ ] Geodesics as level-sets
- [ ] Geodesic vector fields
  - [ ] Used only for sufrace splitting
  - [ ] Then -> the level set method is used
  - [ ] How to implement this???

### Revision Comments & Questions

> Focus more on panels and less on geodesic curves

In what way? generating a good geodesic pattern is the only way to achieve a good panelization

> Change structure to something like:

```markdown
# Index
1. Discussion about planks on freeform surfaces.
    1. Geodesic vs Constant width.
2. Geometric problems
3. Algorithmic strategies
    1. Build an optimal *mesh*?
    2. Dynamic optimization
4. Conclussion
```

- [ ] **Section 2.** is a bit vague. What does he mean by *geometric problems* other than stating all the peculiarities of geodesic patterns and how to generate them.
- [ ] ***Section 3.1***, there is no way to *build an optimal mesh* using this methods. Only the geodesic webs needs of a proper remeshing. The others will take ***ANY*** mesh 
- [ ] ***Sectin 3.2***, as in the previous question. There is no dynamic optimization as such involved. There is though, a lot of optimizaiton that is needed, either numerical or using evolutionary methods. Minimization of error functions is one of the most important part of this technique.
- [ ] Where do the curve generation algorithms go inside this new structure. Maybe in ***Section 2***?
- [ ] 