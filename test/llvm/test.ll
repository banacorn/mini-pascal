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

define i32 @getint() {
entry:
  %0 = alloca i32
  %1 = call i32 @getchar()
  store i32 %1, i32* %0
  %2 = load i32* %0
  %3 = sub nuw nsw i32 %2, 48
  ret i32 %3
}

define void @newline() {
entry:
  %0 = call i32 @putchar(i32 10)
  ret void
}

define void @putint(i32 %a) {
entry:
  %0 = alloca i32
  store i32 %a, i32* %0
  %1 = load i32* %0
  %2 = add nuw nsw i32 %1, 48
  %3 = call i32 @putchar(i32 %2)
  ret void
}

define void @main() {
entry:
  %0 = call i32 @getint()
  store i32 %0, i32* @a
  call void @newline()
  %1 = load i32* @a
  %2 = icmp slt i32 %1, 5
  %3 = zext i1 %2 to i32
  %4 = icmp eq i32 %3, 1
  %5 = zext i1 %4 to i32
  %6 = trunc i32 %5 to i1
  br i1 %6, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  store i32 1, i32* @b
  br label %if.exit

if.else:                                          ; preds = %entry
  store i32 0, i32* @b
  br label %if.exit

if.exit:                                          ; preds = %if.else, %if.then
  %7 = load i32* @b
  call void @putint(i32 %7)
  call void @newline()
  ret void
}

declare i32 @getchar()

declare i32 @putchar(i32)
