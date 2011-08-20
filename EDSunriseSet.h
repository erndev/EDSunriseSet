//
//  EDSunriseSet.h
//
//  Created by Ernesto García  on 20/08/11.
//  Copyright 2011 Ernesto García. All rights reserved.
//

//  C/C++ sun calculations created by Paul Schlyter
//  sunriset.c 
//  http://stjarnhimlen.se/english.html
//  SUNRISET.C - computes Sun rise/set times, start/end of twilight, and
//  the length of the day at any date and latitude
//  Written as DAYLEN.C, 1989-08-16
//  Modified to SUNRISET.C, 1992-12-01
//  (c) Paul Schlyter, 1989, 1992
//  Released to the public domain by Paul Schlyter, December 1992
//


#import <Foundation/Foundation.h>

@interface EDSunriseSet : NSObject
{
@private
    NSCalendar  *_calendar;
    NSTimeZone  *_utcTimeZone;
    double      _latitude;
    double      _longitude;
    NSTimeZone  *_timezone;
    // UTC dates
    NSDate      *_sunrise, *_sunset;
    NSDate      *_civilTwilightStart, *_civilTwilightEnd;
    NSDate      *_nauticalTwilightStart, *_nauticalTwilightEnd;
    NSDate      *_astronomicalTwilightStart, *_astronomicalTwilightEnd;
    
}
-(EDSunriseSet*)initWithTimezone:(NSTimeZone*)timezone latitude:(double)latitude longitude:(double)longitude;
+(EDSunriseSet*)sunrisesetWithTimezone:(NSTimeZone*)timezone latitude:(double)lat longitude:(double)longt;
-(void)calculateSunriseSunset:(NSDate*)date;
-(void)calculateTwilight:(NSDate*)date;
-(void)calculate:(NSDate*)date;
-(NSDateComponents*)localSunrise;
-(NSDateComponents*)localSunset;
-(NSDateComponents*)localCivilTwilightStart;
-(NSDateComponents*)localCivilTwilightEnd;
-(NSDateComponents*)localNauticalCivilTwilightStart;
-(NSDateComponents*)localNauticalCivilTwilightEnd;
-(NSDateComponents*)localAstronomicalTwilightStart;
-(NSDateComponents*)localAstronomicalTwilightEnd;

@property (readonly,retain) NSDate *sunset;
@property (readonly,retain) NSDate *sunrise;
@property (readonly,retain) NSDate *civilTwilightStart;
@property (readonly,retain) NSDate *civilTwilightEnd;
@property (readonly,retain) NSDate *nauticalTwilightStart;
@property (readonly,retain) NSDate *nauticalTwilightEnd;
@property (readonly,retain) NSDate *astronomicalTwilightStart;
@property (readonly,retain) NSDate *astronomicalTwilightEnd;

@end
