; ModuleID = 'program'

@a = common global i32 0
@b = common global i32 0
@c = common global i32 0
@d = common global i32 0

define i32 @addition(i32 %b, i32 %a) {
entry:
  ret i32 1
}

define i32 @haaha(i32 %b, i32 %a) {
entry:
  ret i32 2
}

define void @main() {
entry:
  ret void
}

declare i32 @putchar(i32)
