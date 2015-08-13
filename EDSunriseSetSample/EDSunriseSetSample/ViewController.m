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

static NSInteger const kSunriseRow = 0;
static NSInteger const kSunsetRow = 1;
static NSInteger const kCivilStartRow = 2;
static NSInteger const kCivilEndRow = 3;
static NSInteger const kNauticalStartRow = 4;
static NSInteger const kNauticalEndRow = 5;
static NSInteger const kAstronomicalStartRow = 6;
static NSInteger const kAstronomicalEndRow = 7;



@interface ViewController ()<NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic,weak) IBOutlet NSTableView *tableView;
@property (nonatomic,weak) IBOutlet NSPopUpButton *citiesPopup;
@property (nonatomic,weak) IBOutlet NSDatePicker *datePicker;
@property (nonatomic,strong) NSArray *cities;
@property (nonatomic,strong) NSArray *resultsLabels;
@property (nonatomic,strong) IBOutlet NSDateFormatter *dateFormatter;
@property (nonatomic,strong) EDSunriseSet *sunriset;
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

-(NSArray*)resultsLabels
{
    
    return @[@"Sunrise:", @"Sunset:", @"Civil Twilight Start:", @"Civil Twilight End:", @"Nautical Twilight Start:",
             @"Nautical Twilight End:", @"Astronomical Twilight Start:", @"Astronomical Twilight End:"];
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

-(void)viewDidLayout
{
    [super viewDidLayout];
    [self.tableView.tableColumns.firstObject setWidth:self.tableView.bounds.size.width/2.0];
    [self.tableView.tableColumns.lastObject setWidth:self.tableView.bounds.size.width/2.0];
    
}

-(void)showInfoForSelectedCity
{
    NSInteger index = self.citiesPopup.indexOfSelectedItem;
    
    NSTimeZone *tz = [[NSTimeZone alloc] initWithName:self.cities[index][kCityTimeZone]];
    NSDate *date = self.datePicker.dateValue;
    double longitude = [self.cities[index][kCityLongitude] doubleValue];
    double latitude = [self.cities[index][kCityLatitude] doubleValue];
    
    self.sunriset = [[EDSunriseSet alloc] initWithDate:date timezone:tz latitude:latitude longitude:longitude];
    self.dateFormatter.timeZone = tz;
    [self.tableView reloadData];
    
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


@implementation ViewController (TableDataSourceDelegate)
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.resultsLabels.count;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    NSString *text;
    if( [tableColumn isEqual:tableView.tableColumns.firstObject] ) {
        text = self.resultsLabels[row];
    }
    else
    {
        NSDate *date;
        switch (row ) {
            case kSunriseRow:
                date = self.sunriset.sunrise;
                break;
            case kSunsetRow:
                date = self.sunriset.sunset;
                break;
            case kCivilStartRow:
                date = self.sunriset.civilTwilightStart;
                break;
            case kCivilEndRow:
                date = self.sunriset.civilTwilightEnd;
                break;
            case kNauticalStartRow:
                date = self.sunriset.nauticalTwilightStart;
                break;
            case kNauticalEndRow:
                date = self.sunriset.nauticalTwilightEnd;
                break;
            case kAstronomicalStartRow:
                date = self.sunriset.astronomicalTwilightStart;
                break;
            case kAstronomicalEndRow:
                date = self.sunriset.astronomicalTwilightEnd;
                break;

            
            default:
                break;
        }
        text =  [self.dateFormatter stringFromDate:date] ?: @"?";

    }
    
    [cell.textField setStringValue:text];
    return cell;
}


@end

