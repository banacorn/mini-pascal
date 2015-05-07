; ModuleID = 'program'

@a = common global i32 0
@b = common global i32 0
@c = common global i32 0
@d = common global i32 0

define i32 @addition(i32 %b, i32 %a) {
entry:
  %0 = alloca i32
  store i32 %b, i32* %0
  %1 = alloca i32
  store i32 %a, i32* %1
  %2 = alloca i32
  %3 = load i32* %1
  %4 = load i32* %0
  %5 = add nuw nsw i32 %3, %4
  ret i32 %5
}

define void @main() {
entry:
  %0 = call i32 @addition(i32 2, i32 1)
  store i32 %0, i32* @a
  %1 = load i32* @a
  %2 = call i32 @putchar(i32 %1)
  ret void
}

declare i32 @getchar()

declare i32 @putchar(i32)
