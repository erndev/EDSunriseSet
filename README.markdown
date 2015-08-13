EDSunriseSet
---------------
Objective-C class to calculate Sunrise, Sunset, and Twilight times based on the user's current location and time zone.

`EDSunriseSet` is an Objective-C wrapper for the C languages routines created by [Paul Schlyter].
Calculation is done entirely by the C-code routines. `EDSunrisetSet` bridges those calculations to common cocoa classes like `NSDate` and `NSTimeZone`.

Features
---------------
  - Calculates Sunrise and Sunset times
  - Calculates Civil, Nautical, and Astronomical twilight  
  - Times are calculated based on the provided timezone, latitute, and longitude

Documentation
---------------

> **API has changed in version 2.0. If you want the old version, go to [1.0].**

In order to use the class, just use this initializer:

    -(EDSunriseSet)initWithDate:(NSDate*)date timezone:(NSTimeZone*)timezone latitude:(double)latitude longitude:(double)longitude 

 
 or you can use the class convience method: 

    -(EDSunriseSet*)sunrisesetWithDate:(NSDate*)date timezone:(NSTimeZone*)timezone latitude:(double)latitude longitude:(double)longitude
    
This method returns an `EDSunriseSet` object which can be used to access the following `NSDateComponents` each containing a date, hour, minute, and second:

  - The local sunrise time, `localSunrise`  
  - The local sunset time, `localSunset`  
  - The time when civil twilight (when the sun is 6 degrees below the horizon) begins and ends, `localCivilTwilightStart` and `localCivilTwilightEnd`  
  - The time when nautical twilight (when the sun is 12 degrees below the horizon) begins and ends, `localNauticalCivilTwilightStart` and `localNauticalCivilTwilightEnd`  
  - The time when astronomical twilight (when the sun is 18 degrees below the horizon) begins and ends, `localAstronomicalTwilightStart` and `localAstronomicalTwilightEnd`

You may also access `NSDate` proprties on `EDSunriseSet` which provides a read-only value of the date for the specified property. These properties include `sunrise` and `sunset` among others.
    
License
---------------
EDSunriseSet license is MIT based. Attribution is appreciated, but not required.

  [Paul Schlyter]: http://stjarnhimlen.se/english.html
  [1.0]: https://github.com/erndev/EDSunriseSet/tree/1.0