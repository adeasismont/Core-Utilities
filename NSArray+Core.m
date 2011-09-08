#import "NSArray+Core.h"
#import "NSObject+Core.h"

@implementation NSArray (Core)

- (void)performSelectorOnObjects:(SEL)aSelector
{
	[self performSelectorOnObjects:aSelector withObjects:nil];
}


- (void)performSelectorOnObjects:(SEL)aSelector withObject:(id)object
{
	[self performSelectorOnObjects:aSelector withObjects:[NSArray arrayWithObject:object]];
}


- (void)performSelectorOnObjects:(SEL)aSelector withArguments:(id)firstArg, ...
{
	NSMutableArray *objects = [[NSMutableArray alloc] init];
	va_list args;
	va_start(args, firstArg);
	for (id arg = firstArg; arg != nil; arg = va_arg(args, id))
		[objects addObject:arg];
	[self performSelectorOnObjects:aSelector withObjects:objects];
	[objects release];
}


- (void)performSelectorOnObjects:(SEL)aSelector withObjects:(NSArray*)objects
{
	[self enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
		[object performSelector:aSelector withObjects:objects];
	}];
}


- (void)do:(void (^)(id obj))block
{
	[self enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) { block(obj); }];
}


- (id)objectWithClass:(Class)class
{
	__block id object = nil;
	[self enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
		if ([obj isKindOfClass:class])
		{
			object = obj;
			*stop = YES;
		}
	}];
	return object;
}


- (NSArray*)objectsWithClass:(Class)class
{
	NSMutableArray *objects = [NSMutableArray array];
	[self enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
		if ([obj isKindOfClass:class])
			[objects addObject:obj];
	}];
	return [[objects copy] autorelease];
}

@end