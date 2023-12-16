#import "$base/String.h"

@implementation $String
- (const char *)$toCString {
  return c_string;
}

- (unsigned int)$length {
  return len;
}

@end