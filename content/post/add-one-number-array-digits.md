---
title: "Plus one on an array of digits"
date: 2019-03-22T06:36:12.725Z
draft: false
---

# Table of contents

- [Table of contents](#table-of-contents)
- [Problem](#problem)
- [Examples](#examples)
- [Ideas](#ideas)
- [Edge cases](#edge-cases)
- [Algorithm](#algorithm)
- [Walk-through](#walk-through)

# Problem

Given a number represented by an array of digits (`integers`), increment it and return its new value.

# Examples

```text
[1, 2, 3]      => [1, 2, 4]
[4, 3, 2, 1]   => [4, 3, 2, 2]
```

# Ideas

- We start by creating a variable called `carry` which will hold our _carry value_, for example `4 + 8 => carry = true`. That variable is initialized at `true` since we consider the **increment** operation as a _carry_ in itself.
- Then we iterate over our number **in reverse** (least significant to most significant digit) and check if the increment generates a _carry_. If that's the case, we continue and if it's not we stop and return our new array.
- This will run **in-place** so in `O(1)` space. It will also run in `O(n)` time, with `n` being the size of the array.

# Edge cases

- `Null` array.
- **Overflow**. We can run into a scenario where we increment our array **until we reach the most significant digit**. In that case, we will need to **create a new array** which will have `1` at the index `0` (the carry), and the rest of the items will be the copy of the previous array. This makes our algorithm run `O(n)` space complexity in the worst case.

# Algorithm

```java
public int[] plusOne(int[] digits) {
    boolean carry = true;
    int index = digits.length - 1;

    // Add the carry to the digits array
    while (index >= 0 && carry) {
        int currentSum = digits[index] + (carry ? 1 : 0);
        carry = currentSum > 9;
        digits[index] = currentSum % 10;
        index--;
    }

    // Check for overflow
    if (index == -1 && carry) {
        int[] newArray = new int[digits.length + 1];
        // Put the carry
        newArray[0] = 1;
        // Copy the rest of the items
        for (int i = 0; i < digits.length; i++) {
            newArray[i + 1] = digits[i];
        }
        return newArray;
    } else {
        return digits;
    }
}
```

# Walk-through

We'll take the first example to test our algorithm, namely `[1, 2, 3] => [1, 2, 4]`

```text
carry = true
index = 2

index >= 0 && carry          => while is true
currentSum = 3 + 1           => currentSum = 4
carry = sum > 9              => carry = false
digits[2] = sum % 10         => digits = [1, 2, 4]

carry is false               => break out the while loop
carry is false               => If statement is false

return digits                => [1, 2, 4]
```

Let's also test the overflow case, with `[9, 9] => [1, 0, 0]`

```text
carry = true
index = 1

index >= 0 && carry == true   => while is true
sum = 9 + 1                   => sum = 10
carry = sum > 9               => carry = true
digits[1] = sum % 10          => digits = [9, 0]
index = 0

index >= 0 && carry == true   => while is true
sum = 9 + 1                   => sum = 10
carry = sum > 9               => carry = true
digits[0] = sum % 10          => digits = [0 0]
index = -1

index == -1 && carry = true   => If statement is true
newArray = []
put the carry & copy          => newArray = [1, 0, 0]

return newArray => [1, 0, 0]
```
