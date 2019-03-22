---
title: "Rotate an array by k steps"
date: 2019-03-22T04:47:26.828Z
draft: false
---

# Table of contents

- [Table of contents](#table-of-contents)
- [Problem](#problem)
- [Examples](#examples)
- [Ideas](#ideas)
- [Edge cases](#edge-cases)
- [Language-specific considerations](#language-specific-considerations)
- [Algorithm](#algorithm)
- [Analysis](#analysis)
- [Walk-through](#walk-through)

# Problem

Given array `arr` and an positive integer `k`, rotate the array **to the right** by `k` steps.

# Examples

```text
[1, 2, 3, 4, 5, 6, 7]   & k = 3      => [5, 6, 7, 1, 2, 3, 4]
[-1, -100, 3, 99]       & k = 2      => [3, 99, -1, -100]
```

# Ideas

- Rotate the array to the right `k` times. This will run in `O(k * n)` time and `O(1)` space, since we'll need to iterate `k` times over the array of `n` items.
- Create a **new array** that will hold the rotated items. We then copy the _input array_ into the _new array_ by offsetting the _start index_ by `k`. This runs in `O(n)` time and `O(n)` space.
- Reverse the whole array. Then reverse the first `k` items, and finally reverse the remaining items. This will run in `O(n)` time and `O(1)` space and seems like the best solution so far, so we'll implement it.

# Edge cases

- `Null` array
- `k` is a multiple of our array's `length`. Rotating the array this way will always bring it back to its initial state, we'll then **check if `k` is a multiple of `array.length`**.
- `k` is greater than the `length` of our array, which can result in **unnecessary rotations**. We'll check for that too.
- We can combine the two previous items into one by assigning `k % length` to `k`.

# Language-specific considerations

- Since we'll be using **Java** in our implementation, we'll need to manually create a `reverseArray` method. That method will rely on another one that we'll also create called `swap` which will _swap_ two items of an array at different indexes.
- Both methods will operate **in-place**.

# Algorithm

```java
public void rotate(int[] arr, int k) {
    // Handle the null edge case
    if (arr == null) return 0;

    // Handle the "overflowing" k
    k =% arr.length;

    // Main algorithm
    reverse(arr, 0, arr.length - 1);
    reverse(arr, 0, k - 1);
    reverse(arr, k, arr.length - 1);
}

// Swaps two items of an array at i & j
private void swap(int[] arr, int i, int j) {
    int tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
}

// Reverse an array delimited by left and right indexes
private void reverse(int[] arr, int left, int right) {
    while (left < right) {
        swap(arr, left, right);
        left++;
        right--;
    }
}
```

# Analysis

- **Time complexity** is in `O(n)`.
  - First we reverse the whole array once, which runs in `n / 2` steps.
  - Then we reverse the first `k` steps, which runs in `k / 2` steps.
  - Finally we reverse the remaining `n - k` steps, so `(n - k) / 2`.
  - Summing the total of these operations gives us exactly `n`.
- **Space complexity** is in `O(1)` since our algorithm runs **in-place**.

# Walk-through

We'll use the first example in our test, namely `[1, 2, 3, 4, 5, 6, 7]` and `k = 3`

```text
arr != null              => If is false
k %= 7                   => k = 3

reverse(arr, 0, 6)       => [7, 6, 5, 4, 3, 2, 1]
reverse(arr, 0, 2)       => [5, 6, 7, 4, 3, 2, 1]
reverse(arr, 3, 6)       => [5, 6, 7, 1, 2, 3, 4]
```
