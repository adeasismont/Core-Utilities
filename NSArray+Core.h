
@interface NSArray (Core)

// perform selector on each of the objects in the array
- (void)performSelectorOnObjects:(SEL)aSelector;
- (void)performSelectorOnObjects:(SEL)aSelector withObject:(id)object;
- (void)performSelectorOnObjects:(SEL)aSelector withArguments:(id)firstArg, ... NS_REQUIRES_NIL_TERMINATION;
- (void)performSelectorOnObjects:(SEL)aSelector withObjects:(NSArray*)objects;

// get object(s) of a specified class
- (id)objectWithClass:(Class)class;
- (NSArray*)objectsWithClass:(Class)class;

@end