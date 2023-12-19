#pragma once

#import "./Object.h"

#define FORMAT ... __attribute__((format(printf, 1, 2)))

@interface $String : $Object {
  char *data;
  unsigned int length;
}

@property(nonatomic, readonly) const char *data;
@property(nonatomic, readonly) char *unsafe_data;
@property(nonatomic, readonly) unsigned int length;

+ (instancetype)$copyFrom:(const char *)data length:(unsigned int)length;
+ (instancetype)$allocWithLength:(unsigned int)length;
+ (instancetype)$createFromCString:(char *)data;
+ (instancetype)$format:(const char *)format, FORMAT;

/** # DON'T DO IT FOR CONSTANTS */
- (void)$dealloc;

@end

#undef FORMAT