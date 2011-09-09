#import "NSString+Core.h"
#import "NSObject+Core.h"

@implementation NSString (Core)

+ (NSString*)stringByAddingPercentEscapesUsingEncoding:(CFStringEncoding)encoding
							charactersToLeaveUnescaped:(NSString*)charactersToLeaveUnescaped
						 legalURLCharactersToBeEscaped:(NSString*)legalURLCharactersToBeEscaped
											  toString:(NSString*)string
{
	CFStringRef encodedString = CFURLCreateStringByAddingPercentEscapes(NULL, 
																		(CFStringRef)string, 
																		(CFStringRef)charactersToLeaveUnescaped, 
																		(CFStringRef)legalURLCharactersToBeEscaped, 
																		encoding);
	return [(NSString*)encodedString autorelease];
}


+ (NSString*)stringByURLEncodingString:(NSString*)string
{
	return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding
								charactersToLeaveUnescaped:nil
							 legalURLCharactersToBeEscaped:@"!*‚Äô();:@&=+$,/?%#[]"
												  toString:string];
}


- (NSString*)stringByEncodingURL
{
	return [[self class] stringByURLEncodingString:self];
}


- (NSString*)stringByAddingPercentEscapesUsingEncoding:(CFStringEncoding)encoding
							charactersToLeaveUnescaped:(NSString*)charactersToLeaveUnescaped
						 legalURLCharactersToBeEscaped:(NSString*)legalURLCharactersToBeEscaped
{
	return [[self class] stringByAddingPercentEscapesUsingEncoding:encoding
										charactersToLeaveUnescaped:charactersToLeaveUnescaped
									 legalURLCharactersToBeEscaped:legalURLCharactersToBeEscaped
														  toString:self];
}


+ (NSString*)stringWithQueryDictionary:(NSDictionary*)dictionary
{
	NSMutableArray *pairs = [NSMutableArray array];
	
	[dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
		if (![object isKindOfClass:[NSString class]])
			object = [object description];
		key = [key stringByEncodingURL];
		object = [object stringByEncodingURL];
		NSString *pair = [NSString stringWithFormat:@"%@=%@", key, object];
		[pairs addObject:pair];
	}];
	return [pairs componentsJoinedByString:@"&"];
}


- (NSDictionary*)queryDictionaryUsingEncoding:(NSStringEncoding)encoding
{
	NSCharacterSet *delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
	NSMutableDictionary *pairs = [NSMutableDictionary dictionary];
	NSScanner *scanner = [NSScanner scannerWithString:self];
	
	while (![scanner isAtEnd])
	{
		NSString *pairString;
		
		[scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
		[scanner scanCharactersFromSet:delimiterSet intoString:NULL];
		
		NSArray *kvp = [pairString componentsSeparatedByString:@"="];
		if ([kvp count] == 2)
		{
			NSString *key = [[kvp objectAtIndex:0]
							 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			NSString *value = [[kvp objectAtIndex:1]
							   stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			[pairs setObject:value forKey:key];
		}
	}
	
	return [pairs freeze];
}


- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)dictionary
{
	NSString *queryString = [[self class] stringWithQueryDictionary:dictionary];
	return ([self rangeOfString:@"?"].location == NSNotFound ? 
			[self stringByAppendingFormat:@"?%@", queryString] :
			[self stringByAppendingFormat:@"&%@", queryString]);
}


- (BOOL)isWhitespaceAndNewlines
{
	NSCharacterSet *whiteSpaceAndNewlines = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	for (NSInteger i = 0; i < [self length]; i++)
	{
		unichar c = [self characterAtIndex:i];
		if (![whiteSpaceAndNewlines characterIsMember:c])
			return NO;
	}
	return YES;
}


- (BOOL)isEmptyOrWhitespace
{
	return ((![self length]) ||
			(![[self stringByTrimmingCharactersInSet:
				[NSCharacterSet whitespaceAndNewlineCharacterSet]]
			   length]));
}

@end
