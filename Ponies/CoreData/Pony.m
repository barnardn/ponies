#import "Pony.h"

@interface Pony ()

// Private interface goes here.

@end

@implementation Pony

+ (instancetype)ponyWithIdentity:(NSString *)identity context:(NSManagedObjectContext *)context; {
    NSPredicate *havingIdentity = [NSPredicate predicateWithFormat:@"%K == %@", PonyAttributes.identity, identity];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[Pony entityName]];
    request.predicate = havingIdentity;
    NSArray *results = [context executeFetchRequest:request error:NULL];
    return [results firstObject];
}

+ (instancetype)ponyFromDictionary:(NSDictionary *)ponyInfo context:(NSManagedObjectContext *)context {
    Pony *pony = [Pony insertInManagedObjectContext:context];
    pony.identity = ponyInfo[@"id"];
    return pony;
}

@end
