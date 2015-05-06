; ModuleID = 'program'

@a = common global i32 0
@b = common global i32 0
@c = common global i32 0
@d = common global i32 0

define i32 @addition(i32 %b, i32 %a) {
entry:
  %0 = alloca i32
  %1 = alloca i32
  %2 = alloca i32
  %3 = alloca i32
  %4 = alloca i32
  %5 = alloca i32
  ret i32 1
}

define i32 @id(i32 %a) {
entry:
  %0 = alloca i32
  store i32 98, i32* %0
  %1 = load i32* %0
  ret i32 %1
}

define void @main() {
entry:
  %0 = call i32 @id(i32 97)
  %1 = call i32 @putchar(i32 %0)
  ret void
}

declare i32 @putchar(i32)
