// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Pony.m instead.

#import "_Pony.h"

const struct PonyAttributes PonyAttributes = {
	.identity = @"identity",
	.name = @"name",
};

const struct PonyRelationships PonyRelationships = {
	.kategory = @"kategory",
	.tags = @"tags",
};

@implementation PonyID
@end

@implementation _Pony

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Pony" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Pony";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Pony" inManagedObjectContext:moc_];
}

- (PonyID*)objectID {
	return (PonyID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic identity;

@dynamic name;

@dynamic kategory;

@dynamic tags;

- (NSMutableSet*)tagsSet {
	[self willAccessValueForKey:@"tags"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tags"];

	[self didAccessValueForKey:@"tags"];
	return result;
}

@end

