
@interface NSObject (Core)

// swizzle originalSelector for newSelector
+ (void)swizzle:(SEL)originalSelector for:(SEL)newSelector;
// alias originalSelector with newSelector
+ (void)alias:(SEL)originalSelector with:(SEL)newSelector;

// returns the instance class' name
- (NSString*)className;

// returns the current method selector from the call stack (abstractly speaking, meaning call stack index 2)
- (SEL)currentSelector;
// returns the calling method selector from the call stack (again, abstractly speaking, meaning call stack index 3)
- (SEL)callerSelector;

// raises an exception that this method must be overridden
- (void)raiseAbstractMethod;
// warns that this method is obsolete
- (void)warnObsoleteMethod;
// same as above but with a hint
- (void)warnObsoleteMethodWithMessage:(NSString*)message;

// -performSelector with an arbitrary number of arguments
- (id)performSelector:(SEL)aSelector withArguments:(id)firstArg, ... NS_REQUIRES_NIL_TERMINATION;
- (id)performSelector:(SEL)aSelector withObjects:(NSArray*)objects;

@end
