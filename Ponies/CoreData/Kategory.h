#import "_Kategory.h"

@interface Kategory : _Kategory {}

+ (instancetype)kategoryWithDictionary:(NSDictionary *)kategoryInfo context:(NSManagedObjectContext *)context ;
+ (instancetype)kategoryWithIdentity:(NSString *)identity context:(NSManagedObjectContext *)context;

@end
