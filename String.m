#import "$base/String.h"
#import <stdio.h>
#import <stdlib.h>

@implementation $String

@dynamic data;
@synthesize unsafe_data = data;
@synthesize length;

- (const char *)data {
  return (const char *)data;
}

+ (instancetype)copyFrom:(const char *)data length:(unsigned int)length {
  $String *ret = [self alloc];
  ret->data = malloc(length);
  memcpy(ret->data, data, length);
  ret->length = length;
  return ret;
}
+ (instancetype)allocWithLength:(unsigned int)length {
  $String *ret = [self alloc];
  ret->data = malloc(length);
  return ret;
}
+ (instancetype)createFromCString:(char *)data {
  $String *ret = [self alloc];
  ret->data = data;
  ret->length = strlen(data);
  return ret;
}

+ (instancetype)format:(const char *)format, ... {
  $String *ret = [self alloc];
  va_list list;
  va_start(list, format);
  ret->length = vasprintf(&ret->data, format, list);
  va_end(list);
  return ret;
}

- (void)dealloc {
  free((void *)data);
  [super dealloc];
}

@end