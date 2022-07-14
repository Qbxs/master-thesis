# Roadmap: Type Classes

## 1 Minimum Viable Product

  - Syntax for `class` and `instance` declarations
  - Implement constraint solver
  - Implement evaluation

## 2 Resolving Constraints with Subtyping

Given

~~~
instance Show Bool
instance Show Nat
~~~

do we have:

~~~
instance Show (Bool \/ Nat)
~~~

and\or:

~~~
instance Show (Nat /\ Bool)
~~~

## 3 Implement instance chains?

Implement [instance chains](https://web.cecs.pdx.edu/~mpj/pubs/instancechains.pdf) to allow control over constraint resolver and avoid *overlapping instances*.
This might be helpful to resolve the correct instance definition for ambiguous occurences.

## 4 Implement Multi-Param type classes?

Multi-parameter type classes can be used to express relations, e.g.:

~~~Haskell
class Elem e l where
  elem :: e -> l -> Bool
~~~