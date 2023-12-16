#pragma once

#include <objc/objc.h>

@protocol $Object
- (Class)$class;
- (BOOL)$equals:(id)anObject;
- (BOOL)$instanceOf:(Class)aClass;
- (BOOL)$has:(SEL)selector;
- (BOOL)$implements:(Protocol *)aProtocol;
+ (id)$alloc;
- (void)$dealloc;
@end

__attribute__((objc_root_class))
@interface $Object<$Object> {
  Class isa;
}
@end