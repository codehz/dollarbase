#import "$base/Error.h"
#import <objc/runtime.h>
#import <stdio.h>

$Error *NoMemoryError;

@interface $NoMemoryError : $Error {
}
@end

@interface $StaticError : $Error {
  char const *message;
}

+ (instancetype)message:(char const *)message;
@end

@interface $DynamicError : $Error {
  char const *message;
}
+ (instancetype)format:(char const *)format list:(va_list)list;
@end

@implementation $Error
@dynamic message;

+ (void)load {
  NoMemoryError = [$NoMemoryError alloc];
}
+ (instancetype)message:(const char *)message {
  return [$StaticError message:message];
}

+ (instancetype)format:(const char *)format, ... {
  va_list list;
  va_start(list, format);
  $DynamicError *error = [$DynamicError format:format list:list];
  va_end(list);
  return error;
}

- (char const *)message {
  char const *ret = class_getName([self class]);
  if (ret && ret[0] == '$')
    return ret + 1;
  return ret;
}

@end

@implementation $NoMemoryError
- (void)dealloc {
  // skip dealloc intentionally
  if (false) {
    [super dealloc];
  }
}
@end

@implementation $StaticError
+ (instancetype)message:(const char *)message {
  $StaticError *error = [$StaticError alloc];
  error->message = message;
  return error;
}
@end

@implementation $DynamicError
+ (instancetype)format:(char const *)format list:(va_list)list {
  $DynamicError *error = [$DynamicError alloc];
  vasprintf((char **)&error->message, format, list);
  return error;
}
@end