// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Pony.h instead.

#import <CoreData/CoreData.h>

extern const struct PonyAttributes {
	__unsafe_unretained NSString *identity;
	__unsafe_unretained NSString *name;
} PonyAttributes;

extern const struct PonyRelationships {
	__unsafe_unretained NSString *kategory;
	__unsafe_unretained NSString *tags;
} PonyRelationships;

@class Kategory;
@class Tag;

@interface PonyID : NSManagedObjectID {}
@end

@interface _Pony : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PonyID* objectID;

@property (nonatomic, strong) NSString* identity;

//- (BOOL)validateIdentity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Kategory *kategory;

//- (BOOL)validateKategory:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *tags;

- (NSMutableSet*)tagsSet;

@end

@interface _Pony (TagsCoreDataGeneratedAccessors)
- (void)addTags:(NSSet*)value_;
- (void)removeTags:(NSSet*)value_;
- (void)addTagsObject:(Tag*)value_;
- (void)removeTagsObject:(Tag*)value_;

@end

@interface _Pony (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveIdentity;
- (void)setPrimitiveIdentity:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (Kategory*)primitiveKategory;
- (void)setPrimitiveKategory:(Kategory*)value;

- (NSMutableSet*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet*)value;

@end
