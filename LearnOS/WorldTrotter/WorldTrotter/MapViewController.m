//
//  MapViewController.m
//  WorldTrotter
//
//  Created by 王籽涵 on 2020/7/1.
//  Copyright © 2020 王籽涵. All rights reserved.
//

#import "MapViewController.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController ()

@property(nonatomic, strong) MKMapView *mapView;


@end

@implementation MapViewController

- (void)loadView {
    self.mapView = [MKMapView new];
    self.view = self.mapView;
    
    NSString *standardSting =  NSLocalizedString(@"Standard", @"Standard map view");
    NSString *hybridSting =  NSLocalizedString(@"Hybrid", @"Hybrid map view");
    NSString *satelliteSting =  NSLocalizedString(@"Satellite", @"Satellite map view");
    
//    NSArray *items = [NSArray arrayWithObjects: @"Standard", @"Hybrid", @"Satellite", nil];
    NSArray *items = [NSArray arrayWithObjects: standardSting, hybridSting, satelliteSting, nil];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    [segmentedControl setBackgroundColor:[UIColor.whiteColor colorWithAlphaComponent:0.5]];
    [segmentedControl setSelectedSegmentIndex:0];
    
    [segmentedControl addTarget:self action:@selector(mapTypeChanged:) forControlEvents:UIControlEventValueChanged];
    
    [segmentedControl setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.view addSubview:segmentedControl];
    
    NSLayoutConstraint *topConstraint, *leadingConstraint, *trailingConstraint;
    
    topConstraint = [[segmentedControl topAnchor] constraintEqualToAnchor:[self.view.safeAreaLayoutGuide topAnchor] constant:8];
//    NSLayoutConstraint *leadingConstraint = [[segmentedControl leadingAnchor] constraintEqualToAnchor:[self.view leadingAnchor]];
//    NSLayoutConstraint *trailingConstraint = [[segmentedControl trailingAnchor] constraintEqualToAnchor:[self.view trailingAnchor]];
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    leadingConstraint = [[segmentedControl leadingAnchor] constraintEqualToAnchor:margins.leadingAnchor];
    trailingConstraint = [[segmentedControl trailingAnchor] constraintEqualToAnchor:margins.trailingAnchor];
    
    [topConstraint setActive:true];
    [leadingConstraint setActive:true];
    [trailingConstraint setActive:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"MapViewController loaded its view.");
}

- (void)mapTypeChanged: (UISegmentedControl *)segControl {
    switch (segControl.selectedSegmentIndex) {
        case 0:
            [self.mapView setMapType:MKMapTypeStandard];
            break;
        case 1:
            [self.mapView setMapType:MKMapTypeHybrid];
            break;
        case 2:
            [self.mapView setMapType:MKMapTypeSatellite];
            break;
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
