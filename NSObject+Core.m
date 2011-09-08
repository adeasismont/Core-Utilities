#import "NSObject+Core.h"
#import </usr/include/objc/objc-class.h>
#import <execinfo.h>

@implementation NSObject (Core)

+ (void)swizzle:(SEL)originalSelector for:(SEL)newSelector
{
	assert((originalSelector != NULL) && (newSelector != NULL));
	Method originalMethod = class_getInstanceMethod(self, originalSelector);
	Method newMethod = class_getInstanceMethod(self, newSelector);
	
	if (class_addMethod(self, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
		class_replaceMethod(self, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
	else
		method_exchangeImplementations(originalMethod, newMethod);
}


+ (void)alias:(SEL)originalSelector with:(SEL)newSelector
{
	assert((originalSelector != NULL) && (newSelector != NULL));
	Method originalMethod = class_getInstanceMethod(self, originalSelector);
	class_addMethod(self, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
}


- (NSString*)className
{
	return NSStringFromClass([self class]);
}


- (SEL)callStackSelectorAtIndex:(NSUInteger)index
{
	NSArray *symbols = [NSThread callStackSymbols];
	if ([symbols count] > index)
	{
		NSString *symbol = [symbols objectAtIndex:index];
		NSRange range = [symbol rangeOfString:@"["];
		range.location = [symbol rangeOfString:@" " options:0 range:NSMakeRange(range.location, [symbol length]-range.location)].location;
		range.location++;
		range.length = [symbol rangeOfString:@"]"].location-range.location;
		return NSSelectorFromString([symbol substringWithRange:range]);
	}
	return nil;
}


- (SEL)currentSelector
{
	return [self callStackSelectorAtIndex:2];
}


- (SEL)callerSelector
{
	return [self callStackSelectorAtIndex:3];
}


- (void)raiseAbstractMethod
{
	[NSException raise:NSInternalInconsistencyException
				format:@"*** -[%@ %@]: Abstract method must be overriden.",
		[self className],
		NSStringFromSelector([self callerSelector])];
}


- (void)warnObsoleteMethod;
{
	[self warnObsoleteMethodWithMessage:nil];
}


- (void)warnObsoleteMethodWithMessage:(NSString*)message
{
	static NSMutableSet *sMethodList = nil;
	NSValue *key;
	
	@synchronized([self class])
	{
		if (sMethodList == nil)
			sMethodList = [[NSMutableSet alloc] init];
		
		Method method = class_getInstanceMethod([self class], [self callerSelector]);
		key = [NSValue valueWithBytes:&method objCType:@encode(Method)];
		
		if (![sMethodList containsObject:key])
		{
			[sMethodList addObject:key];
			if (message)
				NSLog(@"*** Obsolete: Compatibility method '%@' in class %@ has been invoked. %@",
					  NSStringFromSelector([self callerSelector]),
					  [self className],
					  message);
			else
				NSLog(@"*** Obsolete: Compatibility method '%@' in class %@ has been invoked.",
					  NSStringFromSelector([self callerSelector]),
					  [self className]);
		}
	}
}

@end
