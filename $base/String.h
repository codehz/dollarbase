#pragma once

#import "./Object.h"

@interface $String : $Object {
  const char *data;
  unsigned int length;
}

@property(readonly) const char *data;
@property(readonly) unsigned int length;

@end