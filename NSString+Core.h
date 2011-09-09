
@interface NSString (Core)

// runs CFURLCreateStringByAddingPercentEscapes using the specified parameters
+ (NSString*)stringByAddingPercentEscapesUsingEncoding:(CFStringEncoding)encoding
							charactersToLeaveUnescaped:(NSString*)charactersToLeaveUnescaped
						 legalURLCharactersToBeEscaped:(NSString*)legalURLCharactersToBeEscaped
											  toString:(NSString*)string;

// runs above method using @"!*‚Äô();:@&=+$,/?%#[]" as legalURLCharactersToBeEscaped
+ (NSString*)stringByURLEncodingString:(NSString*)string;

// returns a URL encoded version of self with @"!*‚Äô();:@&=+$,/?%#[]" as legalURLCharactersToBeEscaped
- (NSString*)stringByEncodingURL;

// returns a URL encoded version of self using specified parameters
- (NSString*)stringByAddingPercentEscapesUsingEncoding:(CFStringEncoding)encoding
							charactersToLeaveUnescaped:(NSString*)charactersToLeaveUnescaped
						 legalURLCharactersToBeEscaped:(NSString*)legalURLCharactersToBeEscaped;

// returns a URL string representation of the specified dictionary
+ (NSString*)stringWithQueryDictionary:(NSDictionary*)dictionary;

// returns a query dictionary from the receiver using the specified encoding
- (NSDictionary*)queryDictionaryUsingEncoding:(NSStringEncoding)encoding;

// returns a new string by adding the query dictionary to the receiver
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)dictionary;

// returns YES if the receiver only contains whitespaces and newlines
- (BOOL)isWhitespaceAndNewlines;

// returns YES if the receiver is empty or only contains whitespaces
- (BOOL)isEmptyOrWhitespace;

@end
