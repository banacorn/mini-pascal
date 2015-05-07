define i32 @main() nounwind {
  %1 = alloca i32, align 4
  store i32 0, i32* %1
  %2 = call i32 @putchar(i32 74)
  ret i32 0
}

declare i32 @putchar(i32)
