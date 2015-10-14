#import "_Tag.h"

@interface Tag : _Tag {}


+ (instancetype)tagWithName:(NSString *)name context:(NSManagedObjectContext *)context;

@end
