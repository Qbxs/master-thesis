# Roadmap: Type Classes

## 1 Minimum Viable Product

  - Syntax for `class` and `instance` declarations
  - Implement basic constraint solver
  - Implement evaluation

## 2 Considerations for Type Class Coherence

For any type T there may be at most one instance so that (Class T) can be derived.

## 3 Resolving Constraints with Subtyping

Given

~~~
instance Show Bool
instance Show Nat
~~~

do we have:

~~~
instance Show (Bool \/ Nat)
~~~

Even though this could work for `Show`. How would we derive `instance Ord (Bool \/ Nat)`? It is impossible to define `Equals(x : Bool, y : Nat)` generally.
If I know how to compare booleans which each other and natural numbers with each other, I cannot derive knowledge on how to compare booleans with natural numbers.

What about:

~~~
instance Show (Nat /\ Bool)
~~~

When the meet is empty (neither `a < b`, nor `b < a`), this instance is trivial and would be equivalent to `instance Show Bot` which we could argue is a trivial instance for every type class.
Otherwise, if `a < b` or `b < a` then only one instance may be defined in order to guarantee class coherence, so the problem may not arise.

## 4 Implement instance chains?

A possible solution to make class coherence explicit.
Implement [instance chains](https://web.cecs.pdx.edu/~mpj/pubs/instancechains.pdf) to allow control over constraint resolver and avoid *overlapping instances*.
This might be helpful to resolve the correct instance definition for ambiguous occurences.

## 5 Implement Multi-Param type classes?

Multi-parameter type classes can be used to express relations, e.g.:

~~~Haskell
class Elem e l where
  elem :: e -> l -> Bool
~~~

Because duality restricts the occurence of a type to be either covariant or contravariant, it may be neccessary for certain type classes to be multi-parameter type classes.
E.g. we cannot write:

~~~
class Semigroup(+a : CBV) {
  Append(a,a,return a)
};
~~~

but instead need to write something like:

~~~
class Semigroup(+a : CBV, -b : CBN) {
  Append(a,a,return b)
};
~~~

with according instances like:

~~~
instance Semigroup Nat Nat {
  Append(n,m,k) => n+m >> k
};
~~~

Also consider [functional dependencies](https://web.cecs.pdx.edu/~mpj/pubs/fundeps-esop2000.pdf)
