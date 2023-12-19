#pragma once

#import "Object.h"

@protocol $Error

@property(nonatomic, readonly) char const *message;

@end

#define FORMAT ... __attribute__((format(printf, 1, 2)))
@interface $Error : $Object <$Error>

+ (instancetype)message:(char const *)message;
+ (instancetype)format:(char const *)format, FORMAT;

@end

#undef FORMAT

extern $Error *NoMemoryError;