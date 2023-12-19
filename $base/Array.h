#pragma once

#import "Object.h"

#define SENTINEL ... __attribute__((sentinel(0)))

typedef id (*$ArrayForeach)(id, int, va_list);

@interface $Array : $Object {
  id *data;
  unsigned int length, capacity;
}

@property(nonatomic, readonly) id *data;
@property(nonatomic, readonly) unsigned int length, capacity;

+ (instancetype)$allocWithCapacity:(unsigned int)capacity;
+ (instancetype)$from:first, SENTINEL;
+ (instancetype)$fromCArray:(const id *)items count:(unsigned int)count;
- (void)$dealloc;
- (void)$deallocIgnoreContents;
- (void)$realloc:(unsigned int)length;
- (void)$push:(id)item;
- (void)$pushMany:(id)first, SENTINEL;

- (id)$foreach:($ArrayForeach)fn, ...;

@end

#define $Array(...)                                                     \
  ({                                                                           \
    id __temp[] = {__VA_ARGS__};                                               \
    [$Array $fromCArray:__temp count:sizeof(__temp) / sizeof(id)];              \
  })

#undef SENTINEL