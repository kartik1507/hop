#define MAX 16384

int sum(int *a) {
    int i;
    int sum = 0;
    for (i = 0; i < MAX; i++){
        if (i % 16 == 0) {
            int *b = a + i;
            asm volatile ("j ScratchPadLoad_2_1\n\t"
                          "sw ra, 0(%[arrayA])\n\t"
                          : [arrayA] "+rm" (b)
                          );
        }
        sum = sum + a[i];
    }
    return sum;
}

int ScratchPadLoad_2_1() {}

int main() {
    asm volatile("mv x4, x4\n\t");
    int i, j;
    int b[8];
    int a[MAX];
    for (i = 0; i < MAX; i++) {
        a[i] = i;
    }
    asm volatile("mv x3, x3\n\t");
    int val = sum(a);
    asm volatile("mv x2, x2\n\t");
    return val;
}
