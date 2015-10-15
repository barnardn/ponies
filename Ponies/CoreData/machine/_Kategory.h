// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Kategory.h instead.

#import <CoreData/CoreData.h>

extern const struct KategoryAttributes {
	__unsafe_unretained NSString *identity;
	__unsafe_unretained NSString *name;
} KategoryAttributes;

extern const struct KategoryRelationships {
	__unsafe_unretained NSString *ponies;
} KategoryRelationships;

@class Pony;

@interface KategoryID : NSManagedObjectID {}
@end

@interface _Kategory : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) KategoryID* objectID;

@property (nonatomic, strong) NSString* identity;

//- (BOOL)validateIdentity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *ponies;

- (NSMutableSet*)poniesSet;

@end

@interface _Kategory (PoniesCoreDataGeneratedAccessors)
- (void)addPonies:(NSSet*)value_;
- (void)removePonies:(NSSet*)value_;
- (void)addPoniesObject:(Pony*)value_;
- (void)removePoniesObject:(Pony*)value_;

@end

@interface _Kategory (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveIdentity;
- (void)setPrimitiveIdentity:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitivePonies;
- (void)setPrimitivePonies:(NSMutableSet*)value;

@end
