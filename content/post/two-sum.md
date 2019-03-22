---
title: "2Sum problem"
date: 2019-03-22T07:31:24.997Z
draft: false
---

# Table of contents

- [Table of contents](#table-of-contents)
- [Problem](#problem)
- [Assumptions](#assumptions)
- [Example](#example)
- [Ideas](#ideas)
- [Algorithm](#algorithm)
- [Analysis](#analysis)
- [Walk-through](#walk-through)

# Problem

Given an array of **integers** and an integer **target**, return the two numbers that add up to the target.

# Assumptions

- The array is valid, meaning that it's not `null` and it has a size of more than `2`.
- Each input has **exactly** one solution.
- We can't use the same item twice.
- **The output can be in any order.**

# Example

```text
[2, 7, 11, 15]   + target = 9   => numbers = [2, 7]   => return [0, 1]
```

# Ideas

- The obvious solution is to **brute-force** the array and calculate all possible pairs. For each pair, we check if it's equal to the `target`, and when it's the case we return the indexes of our pair. This will run in `O(n^2)` time and `O(1)` space.
- A better solution is to use a `HashMap`, where the `key` is the number itself and the `value` is its index in the array.
- We iterate over the array, putting the items as described previously. For each item we check if its **complement** is already in the `HashMap`, meaning that `target - currentItem` has already been inserted into the `map`. If that's the case then we return an array with two items, namely the current index and the value of that complement.
- This will run in `O(n)` time and `O(n)` space. Since it's much faster that the **brute-force** solution, we'll implement it (even if takes more space).

# Algorithm

```java
public int[] twoSum(int numbers, int target) {
    Map<Integer, Integer> visited = new HashMap<>();
    for (int i = 0; i < numbers.length; i++) {
        Integer value = visited.get(target - numbers[i]);
        if (value == null) {
            visited.put(numbers[i], i);
        } else {
            return new int[]{i, value};
        }
    }

    // According to our assumptions we won't reach this
    // We're just putting it for the compiler
    return new int[]{};
}
```

# Analysis

- **Time complexity** is in `O(n)` since we iterate over our array once in the worst case.
- **Space complexity** is also in `O(n)` since we'll allocate `n` items in our `HashMap` in the worst case. Namely when the two items that add up to our target are at the extremities of the array.

# Walk-through

Let's use the example to test our algorithm:

- array = `[2, 7, 11, 15]`
- target = `9`
- output = `[0, 1]`

```text
visited = {}

i = 0
key = 9 - 2 == 7 => value == null
insert => visited = { 2: 0 }

i = 1
key = 9 - 7 => value == 0

return [1, 0]
```
