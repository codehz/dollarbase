#import "$base/Array.h"
#import <math.h>
#import <stdlib.h>

@implementation $Array

@synthesize data;
@synthesize length;
@synthesize capacity;

+ (instancetype)allocWithCapacity:(unsigned int)capacity {
  $Array *ret = [self alloc];
  ret->data = calloc(capacity, sizeof(id));
  ret->length = 0;
  ret->capacity = malloc_usable_size(ret->data) / sizeof(id);
  if (ret->capacity < capacity)
    ret->capacity = capacity;
  return ret;
}

+ (instancetype)from:(id)first, ... {
  int count = 1;
  va_list list;
  va_start(list, first);
  while (va_arg(list, id))
    count++;
  va_end(list);
  $Array *ret = [self allocWithCapacity:count];
  ret->length = count;
  va_start(list, first);
  for (int i = 0; i < count; i++) {
    ret->data[i] = va_arg(list, id);
  }
  va_end(list);
  return ret;
}

+ (instancetype)fromCArray:(const id *)items count:(unsigned int)count {
  $Array *ret = [self allocWithCapacity:count];
  ret->length = count;
  memcpy(ret->data, items, count * sizeof(id));
  return ret;
}

- (void)dealloc {
  for (int i = 0; i < length; i++) {
    [data[i] dealloc];
    data[i] = nil;
  }
  free(data);
  data = NULL;
  [super dealloc];
}
- (void)deallocIgnoreContents {
  free(data);
  data = NULL;
  [super dealloc];
}

- (void)realloc:(unsigned int)new_length {
  if (new_length > capacity) {
    self->data = realloc(self->data, new_length * sizeof(id));
  }
}

- (void)push:(id)item {
  if (length >= capacity) {
    [self realloc:capacity * 1.5 + 1];
  }
  data[length++] = item;
}
- (void)pushMany:(id)first, ... {
  int count = 1;
  va_list list;
  va_start(list, first);
  while (va_arg(list, id))
    count++;
  va_end(list);
  if (length + count > capacity) {
    [self realloc:capacity + count];
  }
  data[length++] = first;
  va_start(list, first);
  id cur;
  while ((cur = va_arg(list, id)))
    data[length++] = cur;
  va_end(list);
}

- (id)foreach:($ArrayForeach)fn, ... {
  for (int i = 0; i < length; i++) {
    va_list list;
    va_start(list, fn);
    id res = fn(data[i], i, list);
    va_end(list);
    if (res)
      return res;
  }
  return nil;
}

@end