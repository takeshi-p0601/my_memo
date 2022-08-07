.intel_syntax noprefix
.globl plus, main

plus:
  add rsi, rdi ;rdiレジスタにあるものと、rsiレジスタにあるものを足し合わせて、rsiレジスタに格納
  mov rax, rsi ;rsiレジスタにあるものを、raxレジスタに入れる
  ret

main:
  mov rdi, 10 ;rdiレジスタに10を入れる（第一引数）
  mov rsi, 5 ;rsiレジスタに5を入れる（第二引数）
  call plus ;plus関数を呼び出す
  ret
