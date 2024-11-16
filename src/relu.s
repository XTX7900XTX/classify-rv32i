.globl relu

.text
# ==============================================================================
# FUNCTION: Array ReLU Activation
#
# Applies ReLU (Rectified Linear Unit) operation in-place:
# For each element x in array: x = max(0, x)
#
# Arguments:
#   a0: Pointer to integer array to be modified
#   a1: Number of elements in array
#
# Returns:
#   None - Original array is modified directly
#
# Validation:
#   Requires non-empty array (length ≥ 1)
#   Terminates (code 36) if validation fails
#
# Example:
#   Input:  [-2, 0, 3, -1, 5]
#   Result: [ 0, 0, 3,  0, 5]
# ==============================================================================
relu:
    li  t0, 1             
    blt a1, t0, error     
    li   t4, 0        # current index
loop_start:
    lw   t3, 0(a0)    # current value
    bge  t3, zero, goback_relu
    sw   zero, 0(a0)
goback_relu:
    addi a0, a0, 4
    addi t4, t4, 1
    blt  t4, a1 loop_start
    ret

error:
    li a0, 36          
    j exit          