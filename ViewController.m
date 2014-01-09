//
//  ViewController.m
//  MapViewExample1
//
//  Created by Ravi Shankar on 04/01/14.
//  Copyright (c) 2014 Ravi Shankar. All rights reserved.
//

#import "ViewController.h"
#import "MapViewAnnotation.h"

@interface ViewController ()

@end

@implementation ViewController

#define METERS_PER_MILE 1609.344

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.mapview addAnnotations:[self createAnnotations]];
    
    [self zoomToLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)createAnnotations
{
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    
    //Read locations details from plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"locations" ofType:@"plist"];
    NSArray *locations = [NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *row in locations) {
        NSNumber *latitude = [row objectForKey:@"latitude"];
        NSNumber *longitude = [row objectForKey:@"longitude"];
        NSString *title = [row objectForKey:@"title"];
        
        //Create coordinates from the latitude and longitude values
        CLLocationCoordinate2D coord;
        coord.latitude = latitude.doubleValue;
        coord.longitude = longitude.doubleValue;
        
        MapViewAnnotation *annotation = [[MapViewAnnotation alloc] initWithTitle:title AndCoordinate:coord];
        [annotations addObject:annotation];
        
    }
    return annotations;
}

- (void)zoomToLocation
{
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 13.03297;
    zoomLocation.longitude= 80.26518;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 7.5*METERS_PER_MILE,7.5*METERS_PER_MILE);
    [self.mapview setRegion:viewRegion animated:YES];
    
    [self.mapview regionThatFits:viewRegion];
}

@end
