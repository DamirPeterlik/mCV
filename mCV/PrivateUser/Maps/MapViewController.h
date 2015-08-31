//
//  MapViewController.h
//  mCV
//
//  Created by Damir Peterlik on 31/08/15.
//  Copyright (c) 2015 Damir Peterlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController
{
    MKMapView *mapView;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)setMap:(id)sender;

@end
