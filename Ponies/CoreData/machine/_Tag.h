// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Tag.h instead.

#import <CoreData/CoreData.h>

extern const struct TagAttributes {
	__unsafe_unretained NSString *name;
} TagAttributes;

extern const struct TagRelationships {
	__unsafe_unretained NSString *pony;
} TagRelationships;

@class Pony;

@interface TagID : NSManagedObjectID {}
@end

@interface _Tag : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TagID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Pony *pony;

//- (BOOL)validatePony:(id*)value_ error:(NSError**)error_;

@end

@interface _Tag (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (Pony*)primitivePony;
- (void)setPrimitivePony:(Pony*)value;

@end
