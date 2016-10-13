//
//  ViewController.m
//  CPWhereAmIApp
//
//  Created by Student P_07 on 12/10/16.
//  Copyright © 2016 chaitu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.startButton.layer.borderWidth = 2;
    
    self.startButton.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    [self startLocating];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    
    longPress.minimumPressDuration = 2;
    
    [self.myMapView addGestureRecognizer:longPress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleLongPress:(UILongPressGestureRecognizer*)gesture{

    CLLocationCoordinate2D pressedCoordinate;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        CGPoint pressedLocation = [gesture locationInView:gesture.view];
        
        pressedCoordinate = [self.myMapView convertPoint:pressedLocation toCoordinateFromView:gesture.view];
        
        myAnnotation = [[MKPointAnnotation alloc]init];
        
        myAnnotation.coordinate = pressedCoordinate;
        
        
        MKPinAnnotationView *annotationView=[[MKPinAnnotationView alloc]initWithAnnotation:myAnnotation reuseIdentifier:@"pin"];
        annotationView.pinTintColor = [UIColor blueColor];
        

        CLGeocoder *geocoder = [[CLGeocoder alloc]init];
        
        CLLocation *location = [[CLLocation alloc]initWithLatitude:pressedCoordinate.latitude longitude:pressedCoordinate.longitude];
        
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"error:%@",error.localizedDescription);
                myAnnotation.title = @"Unknown Place";
                [self.myMapView addAnnotation:myAnnotation];
            }
            else{
                
            
            if (placemarks.count > 0) {
                
                CLPlacemark *myPlacemark = placemarks.lastObject;
                
                NSString *title = myPlacemark.subLocality;
                
                NSString *subTitle = myPlacemark.locality;
                
                
                myAnnotation.title = title;
                myAnnotation.subtitle = subTitle;
            
                self.addressLabel.text = [NSString stringWithFormat:@"%@,%@",myPlacemark.subLocality,myPlacemark.locality];
                
                NSLog(@"%@",myPlacemark.subLocality);
                
                
                [self.myMapView addAnnotation:myAnnotation];
                
            }
            else {
                
                myAnnotation.title = @"Unknown Place";
                [self.myMapView addAnnotation:myAnnotation];
                
                
                
            }
            
            
            
        }
        
    
    }];
    

   
}
    else if(gesture.state == UIGestureRecognizerStateEnded){
        
    
    }
    
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    
    [self.myMapView addAnnotation:myAnnotation];
    
    MKPinAnnotationView *annotationView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
    annotationView.pinTintColor = [UIColor blueColor];
    annotationView.canShowCallout = YES;
    return annotationView;
    
}



-(void)startLocating{
    myLocation = [[CLLocationManager alloc]init];
    
    myLocation.delegate = self;
    
    [myLocation setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [myLocation requestWhenInUseAuthorization];
    
    [myLocation startUpdatingLocation];
    
    
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *currentLocation = [locations lastObject];
    
    NSLog(@"Latitude:%f",currentLocation.coordinate.latitude);
    NSLog(@"Longitude:%f",currentLocation.coordinate.longitude);
    NSLog(@"Altitude:%f",currentLocation.altitude);
    NSLog(@"Speed:%f",currentLocation.speed);
   // NSLog(@"Direction",currentLocation);

    _latitudeLabel.text = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    _longitudeLabel.text = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    _altitudeLabel.text = [NSString stringWithFormat:@"%f",currentLocation.altitude];
    _SpeedLabel.text = [NSString stringWithFormat:@"%f",currentLocation.speed];
    
    
    
    
    MKCoordinateSpan mySpan = MKCoordinateSpanMake(0.001, 0.001);
    
    MKCoordinateRegion myRegion = MKCoordinateRegionMake(currentLocation.coordinate, mySpan);
    
    [self.myMapView setRegion:myRegion animated:YES];
    
    if (currentLocation != nil) {
        [myLocation stopUpdatingLocation];
        
    }
    
    

    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"%@",error.localizedDescription);
    
}

- (IBAction)startLocatingAction:(id)sender {
    
    [self startLocating];
    
}
- (IBAction)typeChangedSegment:(id)sender {
    
    UISegmentedControl *selectSegment = sender;
    
    
    if (selectSegment.selectedSegmentIndex == 0) {
        [self.myMapView setMapType:MKMapTypeStandard];
        
    }
    else if (selectSegment.selectedSegmentIndex == 1) {
        [self.myMapView setMapType:MKMapTypeSatellite];
        
    }
    else if (selectSegment.selectedSegmentIndex == 2) {
        [self.myMapView setMapType:MKMapTypeHybrid];
        
    }
    
    
    
    
    
    
    
    
}
@end
