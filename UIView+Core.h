
@interface UIView (Core)

// set specific frame values, use with caution - if you need to do multiple calls, use setFrame:
- (CGFloat)left;
- (void)setLeft:(CGFloat)left;

- (CGFloat)right;
- (void)setRight:(CGFloat)right;

- (CGFloat)top;
- (void)setTop:(CGFloat)top;

- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

- (CGSize)size;
- (void)setSize:(CGSize)size;

- (CGPoint)origin;
- (void)setOrigin:(CGPoint)origin;

// removes all subviews from a view
- (void)removeAllSubviews;

// get the view's parent view controller
- (UIViewController*)viewController;

// QuartzCore helpers
- (BOOL)isDoubleSided;
- (void)setDoubleSided:(BOOL)doubleSided;

- (CGFloat)cornerRadius;
- (void)setCornerRadius:(CGFloat)cornerRadius;

- (CGFloat)borderWidth;
- (void)setBorderWidth:(CGFloat)borderWidth;

- (UIColor*)borderColor;
- (void)setBorderColor:(UIColor*)borderColor;

@end