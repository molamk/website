---
title: "Move zeros to the right"
date: 2019-03-22T07:11:53.816Z
draft: false
---

# Table of contents

- [Table of contents](#table-of-contents)
- [Problem](#problem)
- [Restrictions](#restrictions)
- [Example](#example)
- [Ideas](#ideas)
- [Considerations](#considerations)
- [Edge cases](#edge-cases)
- [Algorithm](#algorithm)
- [Analysis](#analysis)
- [Walk-through](#walk-through)

# Problem

Given an array, move all the zeroes to the right.

# Restrictions

- Preserve the order of the non-zero items of the array.
- The algorithm must run **in-place**.
- We need to minimize the total number of operations.

# Example

```text
[0, 1, 0, 3, 12] => [1, 3, 12, 0, 0]
```

# Ideas

- Since we need to preserve the order of the non-zero items, **we can't use a sorting algorithm**.
- We can use the **two pointer technique** here. The **slow pointer** will reference the current non-zero item while the **fast pointer** will iterate over the array.
- If the **fast pointer** finds a `non-zero`, then we `swap` the items at `fast` and `slow`. This will effectively move all non-zero items to the left, leaving all the zeroes to the right.
- The algorithm will run in `O(n)` time and `O(1)` space.

# Considerations

- We will need to implement our own `swap` method since **Java** does not have one like **C/C++**. It will take an array and two indexes and run in `O(1)` time & space.

# Edge cases

- `Null` array
- An array of size `0` or `1`, then we don't have to do any operation on it. If it's empty then it doesn't contain anything to move, and if it has only one item it's already placed where it should be (zero or not).

# Algorithm

```java
public void moveZeroes(int[] numbers) {
    // Handle edge cases
    if (numbers == null || numbers.length < 2) return;

    // Main algorithm
    int slow = 0;
    int fast = 0;

    while (fast < numbers.length) {
        if (numbers[fast] != 0) {
            swap(numbers, slow, fast);
            slow++;
        }
        fast++;
    }
}

private void swap(int[] array, int i, int j) {
    int tmp = array[i];
    array[i] = array[j];
    array[j] = tmp;
}
```

# Analysis

- **Time complexity** is in `O(n)` since we iterate over our array exactly once.
- **Space complexity** is in `O(1)` since we only create two `integer` variables (constant space).

# Walk-through

Let's use the example to test our algorithm. The input will be `[0, 1, 0, 3, 12]` and the output `[1, 3, 12, 0, 0]`.

```text
Our array is valid => Skip the first if

slow = 0, fast = 0

fast < 5         => While is true
current == 0     => If is false
fast++           => fast = 1

fast < 5         => While is true
current == 1     => If is true
swap             => array = [1, 0, 0, 3, 12]
slow++           => slow = 1
fast++           => fast = 2

fast < 5         => While is true
current = 0      => If is false
fast++           => fast = 3

fast < 5         => While is true
current == 3     => If is true
swap             => array = [1, 3, 0, 0, 12]
slow++           => slow = 2
fast++           => fast = 4

fast < 5         => While is true
current == 4     => If is true
swap             => array = [1, 3, 12, 0, 0]
slow++           => slow = 3
fast++           => fast = 5

fast == 5        => While is false

array = [1, 3, 12, 0, 0]
```
