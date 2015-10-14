#import "_Pony.h"

@interface Pony : _Pony {}

+ (instancetype)ponyWithIdentity:(NSString *)identity context:(NSManagedObjectContext *)context;
+ (instancetype)ponyFromDictionary:(NSDictionary *)ponyInfo context:(NSManagedObjectContext *)context;

@end
