---
title: "Find the single number in an array"
date: 2019-03-22T05:37:30.015Z
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

Given a **non-empty** array in which every items is repeated **twice** expect for one, find that single number.

# Examples

```text
[2, 2, 1]         => 1
[4, 1, 2, 1, 2]   => 4
```

# Ideas

- The first idea is to use a **HashMap**. We iterate over the array, and for each item if it's not in the `HashMap` we add it with a value of `0`. If we find it again we **increment it**. Finally we check our `HashMap` and find the only number that has a value of `0` which translates into the single number. This will run in `O(n)` time and `O(n)` space.
- A better idea is to use the property of the `xor` operator. We know that `n xor n == false` and in binary format it's more of `n ^ n == 0`, so equal numbers cancel each-other. We can use this by applying `xor` over all the items of the array, the equal numbers will cancel each-other thus **leaving only the single number**. This will run in `O(n)` time and `O(1)` space.

# Edge cases

None

# Algorithm

```java
public int singleNumber(int numbers) {
    int single = 0;
    for (int currentNumber: numbers) {
        // Short-hand for: single = single ^ currentNumber
        single ^= currentNumber;
    }

    return single;
}
```

# Analysis

- **Time complexity** is in `O(n)` since we iterate over our array exactly once.
- **Space complexity** is in `O(1)` because we only create one `integer` variable (32 bytes).

# Walk-through

Let's use our second example for our test `[4, 1, 2, 1, 2]`

```text
single = 0

0 ^ 4 => 4
4 ^ 1 => 5
5 ^ 2 => 7
7 ^ 1 => 6
6 ^ 2 => 4

return 4
```
