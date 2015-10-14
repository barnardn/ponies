#import "Kategory.h"

@interface Kategory ()

// Private interface goes here.

@end

@implementation Kategory

+ (instancetype)kategoryWithIdentity:(NSString *)identity context:(NSManagedObjectContext *)context; {
    NSPredicate *havingIdentity = [NSPredicate predicateWithFormat:@"%K == %@", KategoryAttributes.identity, identity];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[Kategory entityName]];
    request.predicate = havingIdentity;
    NSArray *results = [context executeFetchRequest:request error:NULL];
    return [results firstObject];
}

+ (instancetype)kategoryWithDictionary:(NSDictionary *)kategoryInfo context:(NSManagedObjectContext *)context ; {
    Kategory *kategory = [Kategory insertInManagedObjectContext:context];
    kategory.name = kategoryInfo[@"name"];
    kategory.identity = kategoryInfo[@"id"];
    return kategory;
}


@end
