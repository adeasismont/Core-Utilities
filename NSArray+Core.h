
@interface NSArray (Core)

// perform selector on each of the objects in the array
- (void)performSelectorOnObjects:(SEL)aSelector;
- (void)performSelectorOnObjects:(SEL)aSelector withObject:(id)object;
- (void)performSelectorOnObjects:(SEL)aSelector withArguments:(id)firstArg, ... NS_REQUIRES_NIL_TERMINATION;
- (void)performSelectorOnObjects:(SEL)aSelector withObjects:(NSArray*)objects;

// perform a block on each of the objects in the array
- (void)do:(void (^)(id obj))block;

// collect the items in the array
- (NSArray*)collect:(id (^)(id obj))block;

// select items based on predicate block
- (NSArray*)select:(BOOL (^)(id obj))block;

// get object(s) of a specified class
- (id)objectWithClass:(Class)class;
- (NSArray*)objectsWithClass:(Class)class;

@end

@interface NSArray (CoreAliasedMethodDefinitions)
- (NSArray*)map:(id (^)(id obj))block; // aliased to -collect:
@end