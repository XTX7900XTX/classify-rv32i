# Assignment 2: Classify

## Part A: Mathematical Functions

### abs

This short function aims to compute the absolute value of an integer. Since integers are represented in two's complement, simply masking the leftmost bit with 0 would produce an incorrect result.
Instead, when encountering a negative number, the `sub` instruction can be used to subtract the number from 0, making it positive.

### relu

The ReLU function is as follows:

$$
\text{ReLU}(a) = \max(0, a)
$$

This program takes an array as input, iterates through the array, applies the ReLU function to each element, and stores the output back into the input array.
If the input value is less than 0, the program stores the value in register `zero` at the input's memory address; otherwise, the value remains unchanged.

### argmax

In the `argmax.s` program, it finds the index of the maximum value in an array. If there is more than one maximum value, it returns the index of the first occurrence.
Initially, set the maximum to the first element in the array, then compare each element from index 1 to the end, with the index held in `t2`. Whenever a value greater than the maximum stored in `t0` is encountered, update the maximum and the corresponding index.
Note that the current index should be checked against the array length (`bge t2, a1, end_argmax`) in advance. Before the loop starts, the current index in `t2` is initialized to 1. If the array has only one element, the first element is the maximum. Otherwise, the current index continues until it reaches the array length to ensure memory access is within the array range.

### dot

This function performs the dot operation on two 1D vectors. For each vector, their stride distances are given, meaning the values in the vectors are accessed with the specified stride.

Each element is 4 bytes, so to access the next element using stride, the stride must be multiplied by 4 to reflect the actual distance between elements. Alternatively, we can use `slli` to shift the index by 2 bits, which is equivalent to multiplying by 4.

```
slli a3, a3, 2
slli a4, a4, 2
```

In this case, access the two array elements by their respective strides, then the dot operation multiplies the corresponding elements of the two vectors and sums the products. Based on the given values (`a2`), the number of value pairs to be multiplied and summed is determined.
The dot operation is performed as follows:

##### 1. Load value

- Load array 1 value into `t5` (`lw   t5, 0(a0)`)
- Load array 2 value into `t6` (`lw   t6, 0(a1)`)

##### 2. Pruduct

- Multiply `t5` and `t6` and store in `t4` (mul_loop)

##### 3. Sum

- Sum the values in `t4` (`add  t0, t0, t4`)

##### 4. Iterate the array using the stride

- Add the stride to the index of array 1 (`add  a0, a0, a3`)
- Add the stride to the index of array 2 (`add  a1, a1, a4`)

### matmul

## Part B: File Operations and Main

### read_matrix

### write_matrix

### classify

### multiplication

implement mul instructuiion only by RV32I instructions.

## Reference

https://hackmd.io/@sysprog/2024-arch-homework2
