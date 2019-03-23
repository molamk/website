---
title: "Maximum profit from daily prices"
date: 2019-03-22T04:18:12.251Z
draft: false
---

# Table of contents

- [Table of contents](#table-of-contents)
- [Problem](#problem)
- [Examples](#examples)
- [Ideas](#ideas)
- [Algorithm](#algorithm)
- [Analysis](#analysis)
- [Assumptions](#assumptions)
- [Walk-through](#walk-through)

# Problem

Given an array of _integer_ daily prices, calculate the **maximum profit** that can be achieved. We can **only sell after buying** and **we can't buy or sell multiple times a day**.

# Examples

```bash
[7, 1, 5, 3, 6, 4]  => 7
[1, 2, 3, 4, 5]     => 4
[7, 6, 4, 3, 1]     => 0
```

# Ideas

- The most obvious solution here is to **brute-force** the array and calculate all combinations of _buy/sell_. After we get those _combinations_, we sum the profits for each one and find out which one gives us the _maximum profit_.
- We could also use **dynamic-programming**. This is because the solution at a certain step depends from the previous step(s). For example if it's optimal to buy at day `i` and sell at day `i+1`, we could add that to our profits and move to the next step from there.
- Another solution would be to **just consider the price differences** between days. That way, if a difference is _positive_, we add that to our profit. If it's not the case, we move on to the next difference. We will implement this solution as it seems the most efficient.

 Edge cases

- `Null` prices array.
- Array of size `0` or `1` which can't generate a profit since we **have to buy and sell on different days**.

# Algorithm

```java
public int maximumProfit(int[] prices) {
    // Handle the edges cases
    if (prices == null || prices.length < 2) return 0;

    // Main algorithm
    int profit = 0;

    // We stop the loop before the last index because
    // we will look one day ahead at each iteration
    for (int i = 0; i < prices.length - 1; i++) {
        int priceDifference = prices[i+1] - prices[i];
        if (priceDifference > 0) {
            profit += priceDifference;
        }
    }

    return profit;
}
```

# Analysis

- **Time complexity** is in `O(n)`. This is the best runtime we can achieve since we need to iterate at least once on the whole array.
- **Space complexity** is in `O(1)` which is also the best we can get since we're only creating the return variable which is an _integer_ (32 bits).

# Assumptions

We're assuming that our maximum profit will **fit into an `integer`** here. If this assumption does not fit our use-case, we can always use `long` or `BigInteger` to have more space capacity.

# Walk-through

We're going to use the first example in our test, which is `[7, 1, 5, 3, 6, 4]`

```text
prices != null && prices.length == 6 > 2       => If is false

profit = 0

i = 0 => i < 5                                 => Continue the for loop
diff = 1 - 7                                   => diff = -6
diff < 0                                       => If is false

i = 1 => i < 5                                 => Continue the for loop
diff = 5 - 1                                   => diff = 4
diff > 0                                       => If is true
profit += diff                                 => profit = 4

i = 2                                          => Continue the for loop
diff = 3 - 5                                   => diff = -2
diff < 0                                       => If is false

i = 3                                          => Continue the for loop
diff = 6 - 3                                   => diff = 3
diff > 0                                       => If is true
profit += diff                                 => profit = 7

i = 4                                          => Continue the for loop
diff = 4 - 6                                   => diff = -2
diff < 0                                       => If is false

i = 5 => i == prices.length - 1                => Break out of the loop

return profit                                  => 7
```
