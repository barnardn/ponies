#import <Realm/Realm.h>
#import "Kategory.h"
#import "Tag.h"

@interface Pony : RLMObject

@property  NSString *identity;
@property  NSString *name;
@property  NSString *thumbnail;
@property  Kategory *kategory;
@property  RLMArray<Tag *><Tag> *tags;

@end

//RLM_ARRAY_TYPE(Pony)