.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li   t0, 1
    blt  a2, t0, error_terminate  
    blt  a3, t0, error_terminate   
    blt  a4, t0, error_terminate  

    li   t0, 0            # sum = 0
    li   t1, 0         

    slli a3, a3, 2
    slli a4, a4, 2
loop_start:
    bge  t1, a2, loop_end
    # TODO: Add your own implementation
    lw   t5, 0(a0)          # current A0[i]
    lw   t6, 0(a1)          # current A1[j]




    # mul  t4, t5, t6

    li   t4, 0
mul_loop:
    andi t2, t6, 1
    beqz t2, skip_add
    add  t4, t4, t5
skip_add:
    slli t5, t5, 1
    srli t6, t6, 1
    bnez t6, mul_loop

    # addi sp, sp, -16
    # sw   ra, 12(sp)
    # sw   a0, 8(sp)
    # sw   a1, 4(sp)
    # # mul a0, a0, a1
    # mv   a0, t5
    # mv   a1, t6
    # jal  ra, mul_implement
    # mv   t4, a0
    # # done
    # lw   ra, 12(sp)
    # lw   a0, 8(sp)
    # lw   a1, 4(sp)
    # addi sp, sp, 16

    add  t0, t0, t4
    add  a0, a0, a3
    add  a1, a1, a4
    addi t1, t1, 1
    
    j    loop_start
loop_end:
    mv   a0, t0
    jr   ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit


# addi sp, sp, -16
# sw   ra, 12(sp)
# sw   a0, 8(sp)
# sw   a1, 4(sp)
# # mul a0, a0, a1
# mv   a0, 被乘數 
# mv   a1, 乘數
# jal  ra, mul_implement
# mv   積, a0
# # done
# lw   ra, 12(sp)
# lw   a0, 8(sp)
# lw   a1, 4(sp)
# addi sp, sp, 16


# mul_implement:
#     addi sp sp -16
#     sw ra, 12(sp)
#     sw s1, 8(sp)
#     sw s2, 4(sp)
# # mul a0, a0, a1
#     li   s1, 0
# mul_loop:
#     andi s2, a1, 1
#     beqz s2, skip_add
#     add  s1, s1, a0
# skip_add:
#     slli a0, a0, 1
#     srli a1, a1, 1
#     bnez a1, mul_loop
# # done
#     mv a0, s1
#     lw ra, 12(sp)
#     lw s1, 8(sp)
#     lw s2, 4(sp)
#     addi sp, sp, 16
#     ret


# 不使用stack的方法
#     li   積, 0
# mul_loop:
#     andi t2, 乘數, 1
#     beqz t2, skip_add
#     add  積, 積, 被乘數
# skip_add:
#     slli 被乘數, 被乘數, 1
#     srli 乘數, 乘數, 1
#     bnez 乘數, mul_loop