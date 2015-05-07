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
  ret void

if.then:                                          ; No predecessors!
  %0 = call i32 @putchar(i32 96)
  br label %if.exit

if.else:                                          ; No predecessors!
  %1 = call i32 @putchar(i32 98)
  br label %if.exit

if.exit:                                          ; preds = %if.else, %if.then
  %2 = phi i32 [ %0, %if.then ], [ %1, %if.else ]
  %3 = call i32 @putchar(i32 10)
  ret void
}

declare i32 @putchar(i32)
