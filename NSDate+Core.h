
enum AKWeekday
{
	// we're assuming a gregorian calendar here
	Sunday		= 1,
	Monday,
	Tuesday,
	Wednesday,
	Thursday,
	Friday,
	Saturday
};
typedef enum AKWeekday AKWeekday;

@interface NSDate (Core)

// returns an NSDate containing teh next weekday date
+ (NSDate*)dateWithNextWeekday:(AKWeekday)weekday;
// returns an NSDate containing teh next weekday date after the specified date
+ (NSDate*)dateWithNextWeekday:(AKWeekday)weekday afterDate:(NSDate*)date;

// returns the date's specified calendar components
- (NSDateComponents*)components:(NSUInteger)components;

// returns the date's gregorian weekday
- (AKWeekday)weekday;

// returns the same date at 0000 hours
- (NSDate*)normalizedDate;

// returns the next date for the specified weekday (if weekday == [self weekday] then date = self + 7 days)
- (NSDate*)dateForNextWeekday:(AKWeekday)weekday;

@end
