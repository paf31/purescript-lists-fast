## purescript-lists-fast

Faster replacements for common methods on linked lists, which exploit mutation under the hood.

## Building

```
$ bower update
$ pulp build
```

## Benchmarks

```
$ pulp test
```

Expected speedups over `Data.List`:

- `map` - approx 20x
- `zipWith` - approx 10x
- `filter` - approx 8x

(depending on input size)
