#import "UIView+Core.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Core)

- (CGFloat)left
{
	CGRect frame = [self frame];
	return frame.origin.x;
}

- (void)setLeft:(CGFloat)left
{
	CGRect frame = [self frame];
	frame.origin.x = left;
	[self setFrame:frame];
}


- (CGFloat)right
{
	CGRect frame = [self frame];
	return (frame.origin.x + frame.size.width);
}

- (void)setRight:(CGFloat)right
{
	CGRect frame = [self frame];
	frame.origin.x = right - frame.size.width;
	[self setFrame:frame];
}


- (CGFloat)top
{
	CGRect frame = [self frame];
	return frame.origin.y;
}

- (void)setTop:(CGFloat)top
{
	CGRect frame = [self frame];
	frame.origin.y = top;
	[self setFrame:frame];
}


- (CGFloat)bottom
{
	CGRect frame = [self frame];
	return (frame.origin.y + frame.size.height);
}

- (void)setBottom:(CGFloat)bottom
{
	CGRect frame = [self frame];
	frame.origin.y = bottom - frame.size.height;
	[self setFrame:frame];
}


- (CGSize)size
{
	CGRect frame = [self frame];
	return frame.size;
}

- (void)setSize:(CGSize)size
{
	CGRect frame = [self frame];
	frame.size = size;
	[self setFrame:frame];
}


- (CGFloat)width
{
	CGRect frame = [self frame];
	return frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
	CGRect frame = [self frame];
	frame.size.width = width;
	[self setFrame:frame];
}


- (CGFloat)height
{
	CGRect frame = [self frame];
	return frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
	CGRect frame = [self frame];
	frame.size.height = height;
	[self setFrame:frame];
}


- (CGPoint)origin
{
	CGRect frame = [self frame];
	return frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
	CGRect frame = [self frame];
	frame.origin = origin;
	[self setFrame:frame];
}


- (void)removeAllSubviews
{
	while ([[self subviews] count])
		[[[self subviews] lastObject] removeFromSuperview];
}


- (UIViewController*)viewController
{
	for (UIView *next = [self superview]; next; next = [next superview])
	{
		UIResponder *nextResponder = [next nextResponder];
		if ([nextResponder isKindOfClass:[UIViewController class]])
			return (UIViewController*)nextResponder;
	}
	return nil;
}


- (BOOL)isDoubleSided
{
	return [[self layer] isDoubleSided];
}

- (void)setDoubleSided:(BOOL)doubleSided
{
	[[self layer] setDoubleSided:doubleSided];
}


- (CGFloat)cornerRadius
{
	return [[self layer] cornerRadius];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
	[[self layer] setCornerRadius:cornerRadius];
}


- (CGFloat)borderWidth
{
	return [[self layer] borderWidth];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
	[[self layer] setBorderWidth:borderWidth];
}


- (UIColor*)borderColor
{
	return [UIColor colorWithCGColor:[[self layer] borderColor]];
}

- (void)setBorderColor:(UIColor*)borderColor
{
	[[self layer] setBorderColor:[borderColor CGColor]];
}

@end