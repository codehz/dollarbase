#pragma once

#import "./Object.h"

@interface $String : $Object {
  char *c_string;
  unsigned int len;
}

- (const char *)$toCString;
- (unsigned int)$length;

@end