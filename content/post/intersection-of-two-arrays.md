---
title: "Intersection of two arrays"
date: 2019-03-22T06:06:36.405Z
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

Given two **unsorted** arrays, calculate their intersection (while preserving the number count).

# Examples

```text
[1, 2, 2, 1]   + [2, 2]            => [2, 2]
[4, 9, 5]      + [9, 4, 9, 8, 4]   => [4, 9]
```

# Ideas

- We can use a `HashMap` for this kind of problem. We iterate over the **first array** and we put all items in the `HashMap` with an initial value of `1`, if an item is already there we increment its value.
- Then we iterate over the **second array** and if the `HashMap` contains that item with a value greater than `0`, we **decrement** it and add it to a `List` which will hold our intersection result.
- Finally we convert the list to an `integer array`, since that's our desired output type.

# Edge cases

- `Null` or `empty` arrays

# Algorithm

```java
public int[] intersect(int[] firstArray, int[] secondArray) {
    // Handle edge cases
    if (firstArray == null ||
        firstArray.length == 0 ||
        secondArray == null ||
        secondArray.length == 0) return new int[]{};


    // Iterate over the first array
    Map<Integer, Integer> visited = new HashMap<>();
    for (int x: firstArray) {
        Integer value = visited.get(x);

        if (value == null) {
            value = 0;
        }
        visited.put(x, value + 1);
    }

    // Iterate over the second array
    List<Integer> intersectionList = new ArrayList<>();
    for (int x: secondArray) {
        Integer value = visited.get(x);

        if (value != null && value > 0) {
            intersectionList.add(x);
            visited.put(x, value - 1);
        }
    }

    // Convert the intersection list into an array
    int size = intersectionList.size();
    int[] intersectionArray = new int[size];
    for (int i = 0; i < size; i++) {
        intersectionArray[i] = intersectionList.get(i);
    }

    return intersectionArray;
}
```

# Analysis

- **Time complexity** is in `O(n + m)` with `n` and `m` the sizes of `firstArray` and `secondArray` respectively. This is because we iterate once over `firstArray` (`O(n)`) then once over the `secondArray` (`O(m)`) and finally once over the `intersectionList` (`O(n + m)` worst-case).
- **Space complexity** is also in `O(n + m)`. The `visited` _HashMap_ can contains `max(n, m)` items, and the `intersectionList` can contain `n + m` items in the worst case.

# Walk-through

Let's take the first example for our test, namely `[1, 2, 2, 1] + [2, 2] => [2, 2]`

```text
Our arrays are not "null" or "empty" => Skip the if

visited = {}
After we iterate over "firstArray" we will have
visited = {
    1: 2,
    2: 2
}

list = []
After we iterate over "secondArray" we will have
list = [2, 2] and
visited = {
    1: 2,
    2: 0
}

return [2, 2]
```
