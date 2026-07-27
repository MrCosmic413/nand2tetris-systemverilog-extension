.text
main:
    addi x1, x0, 5      # x1 = 5
    addi x2, x0, 7      # x2 = 7
    add  x3, x1, x2     # x3 = x1 + x2

    li a7, 10           # exit program
    ecall