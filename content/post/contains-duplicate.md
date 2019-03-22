---
title: "Determine if an array has duplicates"
date: 2019-03-22T05:17:54.406Z
draft: false
---

# Table of contents

- [Table of contents](#table-of-contents)
- [Problem](#problem)
- [Examples](#examples)
- [Ideas](#ideas)
- [Edge cases](#edge-cases)
- [Algorithm](#algorithm)
- [Analysis](#analysis)
- [Walk-through](#walk-through)

# Problem

Given an **unsorted** array, determine if it contains any duplicates.

# Examples

```text
[1, 2, 3, 1]   => true
[1, 2, 3, 4]   => false
```

# Ideas

- The obvious idea is to **brute-force** the array and compare all possible pairs. If we have an equal pair, then we return `true` and if we don't we return `false`. This will run in `O(n^2)` time and `O(1)` space since we need to compare each item to the whole array at each iteration.
- A more subtle solution is to **sort the array** then compare the adjacent elements. Since equal items will be next to each other, we'll easily find duplicates if there are any. This will run in `O(n*log(n))` time and `O(1)` space because of the **sort**.
- A faster solution would be to use a **Hash Set**. We'll iterate through the array and check if the current item is the set. If it's not we add it to the set, and if it's already there we stop and return `true`. This will run in `O(n)` time worst-case and `O(n)` space. We'll prefer this solution since it's faster than the other ones (even if it takes more space).

# Edge cases

- `Null` or **empty** array.

# Algorithm

```java
public boolean containsDuplicate(int[] numbers) {
    // Handle the edge case
    if (numbers == null) return false;

    // Main algorithm
    Set<Integer> visitedItems = new HashSet<>();
    for (int currentItem: numbers) {
        if (visitedItems.contains(currentItem)) {
            return true;
        } else {
            visitedItems.add(currentItem);
        }
    }

    return false;
}
```

# Analysis

- **Time complexity** is in `O(n)` since the `HashSet` lookups and insertions are in `O(1)` and we do them `n` in the worst case.
- **Space complexity** is in `O(n)` because we need to store the visited items in our `HashSet`.

# Walk-through

We'll take the first example for our first test, namely `[1, 2, 3, 1] => false`.

```text
visitedItems = []

does not contain 1     => visited = [1]
does not contain 2     => visited = [1, 2]
does not contain 3     => visited = [1, 2, 3]
contains 1             => return true
```

Let's also test the second example `[1, 2, 3, 4] => true`.

```text
visitedItems = []

does not contains 1    => visited = [1]
does not contains 2    => visited = [1, 2]
does not contains 3    => visited = [1, 2, 3]
does not contains 4    => visited = [1, 2, 3, 4]

return false
```
