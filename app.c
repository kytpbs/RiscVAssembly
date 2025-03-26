#include <stdio.h>

inline void printInt(int value);
inline void printString(char* string);
inline int readInt();

/* Type your code here, or load an example. */
int main() {
    printString("Input a number: ");

    int x = readInt();
    int y = 2025 - x;

    printInt(y);
}

inline int readInt() {
    int result;
    __asm__ volatile (
        "li a7, 5\n"      // Load system call number for reading an integer
        "ecall\n"         // Perform system call
        "mv %0, a0\n"     // Store result from a0 into the output variable
        : "=r" (result)   // Output operand: result in a register
        :                 // No input operands
        : "a0", "a7"      // Clobbered registers
    );
    return result;
}


inline void printInt(int value) {
    __asm__ volatile (
        "li a7, 1\n"
        "mv a0, %0\n"
        "ecall"
        :
        : "r" (value)
        : "a0", "a7"
    );
}

inline void printString(char* string) {
    __asm__ volatile (
        "li a7, 4\n"
        "mv a0, %0\n"
        "ecall"
        :
        : "r" (string)
        : "a0", "a7"
    );
}
