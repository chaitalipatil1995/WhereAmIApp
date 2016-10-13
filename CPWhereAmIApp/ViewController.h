//
//  ViewController.h
//  CPWhereAmIApp
//
//  Created by Student P_07 on 12/10/16.
//  Copyright © 2016 chaitu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>{
    MKPointAnnotation *myAnnotation;
    CLLocationManager *myLocation;
    
}

@property (strong, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)typeChangedSegment:(id)sender;

@property (strong, nonatomic) IBOutlet MKMapView *myMapView;
- (IBAction)startLocatingAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *altitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *SpeedLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;








@end

