#import <Realm/Realm.h>

@interface Tag : RLMObject

@property NSString *name;

//+ (instancetype)tagWithName:(NSString *)name context:(NSManagedObjectContext *)context;

@end

RLM_ARRAY_TYPE(Tag)