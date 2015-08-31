//
//  MapViewController.h
//  mCV
//
//  Created by Damir Peterlik on 31/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>


@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) CLLocationManager *locationManager;

- (IBAction)setMap:(id)sender;

@end
