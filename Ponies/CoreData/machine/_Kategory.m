// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Kategory.m instead.

#import "_Kategory.h"

const struct KategoryAttributes KategoryAttributes = {
	.identity = @"identity",
	.name = @"name",
};

const struct KategoryRelationships KategoryRelationships = {
	.ponies = @"ponies",
};

@implementation KategoryID
@end

@implementation _Kategory

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Kategory" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Kategory";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Kategory" inManagedObjectContext:moc_];
}

- (KategoryID*)objectID {
	return (KategoryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic identity;

@dynamic name;

@dynamic ponies;

- (NSMutableSet*)poniesSet {
	[self willAccessValueForKey:@"ponies"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"ponies"];

	[self didAccessValueForKey:@"ponies"];
	return result;
}

@end

