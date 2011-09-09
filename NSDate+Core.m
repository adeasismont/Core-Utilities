#import "NSDate+Core.h"

@implementation NSDate (Core)

+ (NSDate*)dateWithNextWeekday:(AKWeekday)weekday
{
	return [self dateWithNextWeekday:weekday afterDate:[NSDate date]];
}


+ (NSDate*)dateWithNextWeekday:(AKWeekday)weekday afterDate:(NSDate*)date
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [date components:NSWeekdayCalendarUnit];
	NSInteger offset = -[components weekday] + weekday;
	if (offset == 0) offset = 7;
	
	[components setWeekday:offset];
	
	NSDate *newDate = [calendar dateByAddingComponents:components
												toDate:date
											   options:0];
	return [newDate normalizedDate];
}


- (NSDateComponents*)components:(NSUInteger)components
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	return [calendar components:components fromDate:self];
}


- (AKWeekday)weekday
{
	return [[self components:NSWeekdayCalendarUnit] weekday];
}


- (NSDate*)normalizedDate
{
	NSDateComponents *components = [self components:(NSYearCalendarUnit | 
													 NSMonthCalendarUnit | 
													 NSDayCalendarUnit)];
	return [[NSCalendar currentCalendar] dateFromComponents:components];
}


- (NSDate*)dateForNextWeekday:(AKWeekday)weekday
{
	return [[self class] dateWithNextWeekday:weekday afterDate:self];
}

@end
