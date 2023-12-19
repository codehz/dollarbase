#import "$base/Object.h"
#import <objc/runtime.h>

@implementation $Object
- (Class)class {
  return object_getClass(self);
}

- (BOOL)equals:(id)anObject {
  return self == anObject;
}

+ (BOOL)instanceOf:(Class)aClass {
  if (aClass == [$Object class])
    return YES;
  return NO;
}

- (BOOL)instanceOf:(Class)aClass {
  Class class = object_getClass(self);
  while (class != nil) {
    if (class == aClass) {
      return YES;
    }
    class = class_getSuperclass(class);
  }
  return NO;
}

- (BOOL)has:(SEL)selector {
  Class cls = object_getClass(self);
  if (selector == 0) {
    return NO;
  }
  if (class_respondsToSelector(cls, selector)) {
    return YES;
  }
  return NO;
}

+ (BOOL)implements:(Protocol *)aProtocol {
  Class c;
  for (c = self; c != Nil; c = class_getSuperclass(c)) {
    if (class_conformsToProtocol(c, aProtocol)) {
      return YES;
    }
  }
  return NO;
}

- (BOOL)implements:(Protocol *)aProtocol {
  return [[self class] implements:aProtocol];
}

+ (instancetype)alloc {
  return class_createInstance(self, 0);
}

+ (instancetype)allocWithExtraBytes:(size_t)extraBytes {
  return class_createInstance(self, extraBytes);
}

- (void)dealloc {
  object_dispose(self);
}

@end