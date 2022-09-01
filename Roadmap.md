# Roadmap: Type Classes

## 1 Minimum Viable Product

  - Syntax for `class` and `instance` declarations
  - Implement basic constraint solver
  - Implement evaluation

## 2 Considerations for Type Class Coherence

For any type `T` and type class `C` there may be at most one instance so that `(C T)` can be derived.
Therefore, if `T :< S`, then `instance C T` and `instance C S` cannot be defined in the same environment.
Resolving instances if it was would be problematic (TODO: give examples where consistency might fail).

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

We might constrain the Join rule in one of the following ways:
- Only allow single argument methods.
- Check whether the argument types are equal. But this does not quite seem to be in the spirit of subtyping. There may be ambiguity especially when we consider subtypes of joins.

What about:

~~~
instance Show (Nat /\ Bool)
~~~

Generally, when the meet is empty (neither `a :< b`, nor `b :< a` as in the case of `Nat /\ Bool`), this instance is trivial and would be equivalent to `instance Show Bot` which we could argue is a trivial instance for every type class.
Otherwise, if `a :< b` or `b :< a` then only one instance may be defined in order to guarantee class coherence, so the problem may not arise.

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

since `a` occurs both covariantly and contravariantly.

Instead we need to write something like:

~~~
class Semigroup(+a : CBV, -b : CBN) {
  Append(a,a,return b)
};
~~~

with according instances like:

~~~
instance Semigroup Nat Nat {
  Append(n,m,k) => n*m >> k
};
~~~

Also consider [functional dependencies](https://web.cecs.pdx.edu/~mpj/pubs/fundeps-esop2000.pdf)

## Given type class coherence, can we join distinct types?

If from `C a` and `C b` we have `C a \/ b` how do we deal with methods that take multiple arguments.

E.g. if we have `Ord Bool` and `Ord Int`, `True < 5` cannot be defined even though an instance `Ord Bool \/ Int` can be resolved.

We also think about using default definitions for such cases. E.g. in `Ord Bool \/ Int` we could derive that every `Bool` is smaller than any `Int`. But since joins are commutative we would have to derive the opposite relation for `Ord Int \/ Bool`, which violates coherence.

We may restrict the arguments of `<` to be the same type, but is this feasible?

Imagine there is some type `c` with `c < Bool \/ Int`. We can also derive an instance `C c`. How do we check now whether the `Bool` or the `Int` instance will be used for a term of type `c`?

### Counterexample

Given `Show {x,y}` and `Show {y,z}` can we resolve `Show {x,y,z}`

## Intensional type analysis vs Dictionary passing

- intensional type analysis: dispatch type at run-time, execute corresponding code depending on type representation
- dictionary passing: methods get compiled to functions that take an additional argument representing the correct instance declaration

# TODOs

- Formalize and reduce syntax
- foundations: data/codata, polarity, continuations, polymorphism, subtyping, typeclass (coherence)
- main part: type inference, dictionary passing, problematic examples for type class coherence
- discussion: instance chains, multi param classes (for mixed variance), modularity, further work

# Structure

## Qualified Types

### Defs

- Predicates
- Cov Pred
- Contrav Pred

Derviable Rules
(with example derivation)

examples for predicates: Show, Read, Default, Decidable (a -> Bool)

### Witnesses

### Coherence

### 