//
//  ViewController.m
//  EDSunriseSetSample
//
//  Created by ernesto on 13/8/15.
//  Copyright (c) 2015 cocoawithchurros. All rights reserved.
//

#import "ViewController.h"
#import "EDSunriseSet.h"

static NSString * const kCityName  = @"name";
static NSString * const kCityLongitude  = @"longitude";
static NSString * const kCityLatitude  = @"latitude";
static NSString * const kCityTimeZone = @"timezone";

@interface ViewController ()
@property (nonatomic,weak) IBOutlet NSTextField *sunsetTextField;
@property (nonatomic,weak) IBOutlet NSTextField *sunriseTextField;
@property (nonatomic,weak) IBOutlet NSPopUpButton *citiesPopup;
@property (nonatomic,weak) IBOutlet NSDatePicker *datePicker;
@property (nonatomic,strong) NSArray *cities;
@property (nonatomic,strong) IBOutlet NSDateFormatter *dateFormatter;
@end

@implementation ViewController

-(NSArray *)cities
{
    if( !_cities ) {
        _cities = @[
                    @{ kCityName:@"Madrid" , kCityLatitude:@(40.4165), kCityLongitude:@(-3.70256), kCityTimeZone:@"Europe/Madrid"},
                    @{ kCityName:@"Beijing", kCityLatitude:@(39.9075), kCityLongitude:@(116.39723), kCityTimeZone:@"Asia/Shanghai" },
                    @{ kCityName:@"Cupertino", kCityLatitude:@(37.3229978) , kCityLongitude:@(-122.0321823), kCityTimeZone:@"America/Los_Angeles"},
                    @{ kCityName:@"New York", kCityLatitude:@(40.7127837) , kCityLongitude:@(-74.0059413), kCityTimeZone:@"America/New_York" },
                    @{ kCityName:@"Tokyo" , kCityLatitude:@(35.6894875) , kCityLongitude:@(139.6917064), kCityTimeZone:@"Asia/Tokyo"},
                    @{ kCityName:@"Sydney" , kCityLatitude:@(-33.8674869) , kCityLongitude:@(151.2069902), kCityTimeZone:@"Australia/Sydney"}
                    ];
    }
    return _cities;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.datePicker setDateValue:[NSDate new]];
    [self populateCities];
    
    
}


-(void)populateCities
{
    
    for (NSDictionary *city in self.cities ) {
        [self.citiesPopup addItemWithTitle:city[kCityName]];
    }
    [self.citiesPopup selectItemAtIndex:0];
    [self showInfoForSelectedCity];
}

-(void)showInfoForSelectedCity
{
    NSInteger index = self.citiesPopup.indexOfSelectedItem;
    
    NSTimeZone *tz = [[NSTimeZone alloc] initWithName:self.cities[index][kCityTimeZone]];
    NSDate *date = self.datePicker.dateValue;
    double longitude = [self.cities[index][kCityLongitude] doubleValue];
    double latitude = [self.cities[index][kCityLatitude] doubleValue];
    
    EDSunriseSet *srset = [[EDSunriseSet alloc] initWithDate:date timezone:tz latitude:latitude longitude:longitude];
    self.dateFormatter.timeZone = tz;
    [self.sunriseTextField setStringValue:[self.dateFormatter stringFromDate:srset.sunrise]];
    [self.sunsetTextField setStringValue:[self.dateFormatter stringFromDate:srset.sunset]];
    
}

-(IBAction)cityChanged:(id)sender
{
    [self showInfoForSelectedCity];
}

-(IBAction)dateChanged:(id)sender
{
    [self showInfoForSelectedCity];
}


@end
