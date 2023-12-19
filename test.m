#import "$base/Array.h"
#import "$base/String.h"
#include <stdio.h>

static id test(id var, int idx, va_list list) {
  printf("%p %d %d\n", var, idx, va_arg(list, int));
  return nil;
}

int main() {
  $Array *list = $Array(@"123", @"456");
  @try {
    [list $push:@"123"];
    printf("%p %d\n", list, list.length);
    [list $foreach:test, 1];
  } @finally {
    [list $deallocIgnoreContents];
  }
}
