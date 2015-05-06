; ModuleID = 'program'

@a = common global i32 0
@b = common global i32 0
@c = common global i32 0

declare i32 @putchar(i32)

define void @main() {
"block entry":
  store i32 97, i32* @b
  %temp = load i32* @b
  %0 = call i32 @putchar(i32 %temp)
  ret void
}
