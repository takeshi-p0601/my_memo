#include <stdio.h>

struct HogeStruct {
    
};

struct FugaStruct {
    char chr1;
    char chr2;
    char chr3;
    char ch4;
    int i;
};

int main(void)
{
    /*
     何バイトかを確認する
     */
    printf("char size of: %d\n", (int)sizeof(char)); // char size of: 1
    printf("int size of: %d\n", (int)sizeof(int)); // int size of: 4
    printf("double size of: %d\n", (int)sizeof(double)); // double size of: 8
    printf("short size of: %d\n", (int)sizeof(short)); // short size of: 2
    printf("unsigned int size of: %d\n", (int)sizeof(unsigned int)); // unsigned int size of: 4
    printf("void size of: %d\n", (int)sizeof(void)); // void size of: 1
    
    /*
     structは、メンバのバイト数の合計がstruct自体のバイト数となりそうと思ったが、ちょっと違ったかも？
     実験1: char型を2つ持たせて、sizeofする -> 2byteになる
     実験2: char型を2つ, int型を1つ持たせて、sizeofする -> 8byteになる <-- あれ6byteではない？
     実験3: char型を3つ, int型を1つ持たせて、sizeofする -> 8byteになる <-- 実験2の結果から7byteかなと思ったけど、7byteでない？
     
     */
    printf("struct HogeStruct size of: %d\n", (int)sizeof(struct HogeStruct)); // struct HogeStruct size of: 0
    printf("struct FugaStruct size of: %d\n", (int)sizeof(struct FugaStruct)); // struct FugaStruct size of: 2
    
    /*
     ポインタ
     全て8byteとなる。(64bitcpu)
     64bitcpuの場合、8byteの情報を一度に送れるので、アドレスも8byteで定義される
     
     ・64bitでアドレスが指定されてCPUとメモリでアドレスの連携が行われる。
     [CPU] -> [メモリ]
     [CPU] <- [メモリ]
     
     メモリイメージ
     |メモリサイズ|アドレス|
     |1B|0x0000000000000000|
     |1B|0x0000000000000001|
     |1B|0x0000000000000002|
     |1B|0x0000000000000003|
     |1B|0x0000000000000004|
     |1B|0x0000000000000005|
     ...
     ...
     ...
     |1B|0x999999999999999c|
     |1B|0x999999999999999d|
     |1B|0x999999999999999e|
     |1B|0x999999999999999f|
     == ケタ溢れ
     |1B|0x10000000000000000|
     */
    
    printf("char* size of: %d\n", (int)sizeof(char*)); // char* size of: 8
    printf("int* size of: %d\n", (int)sizeof(int*)); // int* size of: 8
    printf("double size of: %d\n", (int)sizeof(double*)); // double* size of: 8
    printf("short size of: %d\n", (int)sizeof(short*)); // short* size of: 8
    printf("unsigned int* size of: %d\n", (int)sizeof(unsigned int*)); // unsigned int* size of: 8
    printf("void* size of: %d\n", (int)sizeof(void*)); // void* size of: 8
    printf("struct HogeStruct* size of: %d\n", (int)sizeof(struct HogeStruct*)); // struct HogeStruct* size of: 8
    
    /*
     例えば64bitCPUの環境で、あるポインタの値が 0x286C0752C71Cの場合 (0x 00 00 28 6C 07 52 C7 1C)
     メモリには8byteぶん格納されている必要があるので、下記のようなイメージ
     ※先頭アドレスは適当に 0x0000000027BC86AD とでもしておく
     
     |メモリサイズ|アドレス|
     |1B|0x0000000000000000|
     |1B|0x0000000000000001|
     |1B|0x0000000000000002|
     |1B|0x0000000000000003|
     |1B|0x0000000000000004|
     |1B|0x0000000000000005|
     ...
     ...
     ...
     ...
     |1B|0x0000000027BC86AA|
     |1B|0x0000000027BC86AB|
     |1B|0x0000000027BC86AC|
     |1B|0x0000000027BC86AD|1C // リトルエンディアンなので、1Cから格納されていくと思われる
     |1B|0x0000000027BC86AE|C7
     |1B|0x0000000027BC86AF|52
     |1B|0x0000000027BC86B0|07
     |1B|0x0000000027BC86B1|6C
     |1B|0x0000000027BC86B2|28
     |1B|0x0000000027BC86B3|00
     |1B|0x0000000027BC86B4|00
     |1B|0x0000000027BC86B5|00
     |1B|0x0000000027BC86B6|
     |1B|0x0000000027BC86B7|
     |1B|0x0000000027BC86B8|
     |1B|0x0000000027BC86B9|
     ...
     ...
     ...
     ...
     |1B|0x999999999999999c|
     |1B|0x999999999999999d|
     |1B|0x999999999999999e|
     |1B|0x999999999999999f|
     == ケタ溢れ
     |1B|0x10000000000000000|
     
     */
    
    return 0;
}
