; ModuleID = 'program'

@a = external global i32
@b = external global i32
@c = external global i32
@g = external global double
@h = external global double

declare i32 @putchar(i32)

define void @main() {
"block entry":
  %0 = call i32 @putchar(i32 99)
  %1 = call i32 @putchar(i32 101)
  ret void
}
