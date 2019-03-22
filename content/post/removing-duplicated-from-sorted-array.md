---
title: "Removing duplicates from a sorted array"
date: 2019-03-22T03:41:19.956Z
draft: false
---

# Table of contents

- [Table of contents](#table-of-contents)
- [Problem](#problem)
- [Examples](#examples)
- [Ideas](#ideas)
- [Edge cases](#edge-cases)
- [Base algorithm](#base-algorithm)
- [Optimization](#optimization)
- [Analysis](#analysis)
- [Walk-through](#walk-through)

# Problem

Remove the duplicates from a _sorted array_ and return its new length. The solution must be **in-place**.

# Examples

```text
[1, 1, 2]                        => [1, 2]            => 2
[0, 0, 1, 1, 1, 2, 2, 3, 3, 4]   => [0, 1, 2, 3, 4]   => 5
```

# Ideas

- The solution needs to be _in-place_ so it will need to run in **`O(1)` space**. For that reason, we can't create a new array and just copy the non-duplicated items.
- Since the array is already sorted, we can use the **two pointer technique** to iterate through the array.
  - We will have a **fast pointer** which will go through the array, and a **slow pointer** which will be the index of the non-duplicated item.
  - If the values referenced by the two pointers are different, we increment the *slow pointer* then assign the item at *fast* to *slow*, finally we increment *fast*. If that's not the case, we only increment the _fast pointer_.

# Edge cases

- `Null` array.
- An array of size `0` or `1` can't possibly have any duplicates.

# Base algorithm

```java
public int removeDuplicates(int[] arr) {
    // Check if the array is valid
    if (arr == null) return 0;
    // If length == 0 => return 0
    // If length == 1 => return 1
    else if (arr.length < 2) return arr.length;

    // Main algorithm
    int slow = 0;
    int fast = 1;

    while (fast < arr.length) {
        if (arr[fast] != arr[slow]) {
            slow++;
            arr[slow] = arr[fast];
        }
        fast++;
    }

    return slow + 1;
}
```

# Optimization

Our base algorithm is fast enough as we will see in the analysis.

# Analysis

- **Time complexity** is in `O(n)`. Which is as fast as it can get since we need to iterate at least through the whole array once.
- **Space complexity** is in `O(1)`. We're creating only two *integer* variables which have constant size (64 bytes in total).

# Walk-through

We're going to take the example of an array equal to `[1, 1, 2]`

```text
arr != null                   => If is false
arr.length == 3               => If is false

slow = 0, fast = 1

fast == 1 < arr.length        => While is true
arr[0] == arr[1] => 1 == 1    => If is false
fast++                        => fast == 2

fast == 2 < arr.length        => While is true
arr[0] != arr[2] => 1 != 2    => If is true
slow++                        => slow = 1
arr[1] = arr[2]               => arr == [1, 2, 2]
fast++                        => fast = 3

fast == 3 == arr.length       => While is false

return slow + 1               => 1 + 1 => 2
```