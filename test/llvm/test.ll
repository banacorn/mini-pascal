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
  store i32 %5, i32* %2
  %6 = load i32* %2
  ret i32 %6
}

define i32 @id(i32 %a) {
entry:
  %0 = alloca i32
  store i32 %a, i32* %0
  %1 = load i32* %0
  ret i32 %1
}

define void @main() {
entry:
  %0 = call i32 @getchar()
  store i32 %0, i32* @a
  %1 = load i32* @a
  %2 = icmp slt i32 %1, 5
  %3 = sext i1 %2 to i32
  store i32 %3, i32* @b
  %4 = load i32* @b
  %5 = call i32 @putchar(i32 %4)
  %6 = call i32 @putchar(i32 10)
  ret void
}

declare i32 @getchar()

declare i32 @putchar(i32)
