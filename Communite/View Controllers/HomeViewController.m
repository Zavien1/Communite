//
//  HomeViewController.m
//  Communite
//
//  Created by Zavien Sibilia on 7/12/21.
//

#import "HomeViewController.h"
#import "HostEventViewController.h"
#import "LoginViewController.h"
#import "MapKit/MapKit.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <UIKit/UIKit.h>
@import CoreLocation;

@interface HomeViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        [self.locationManager requestWhenInUseAuthorization];
    }

    [self.locationManager startUpdatingLocation];
    [self centerViewOnUserLocation];
    
    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(37.785500, -122.421800);
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coordinates];
    [annotation setTitle:@"Tommy's Joynt Party"]; //You can set the subtitle too
    [self.mapView addAnnotation:annotation];
}

- (void)centerViewOnUserLocation{
    if(self.locationManager.location){
        CLLocationCoordinate2D location = self.locationManager.location.coordinate;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 5000, 5000);
        [self.mapView setRegion:region];
    }
}


- (IBAction)didTapLogout:(id)sender {
    [[FBSDKLoginManager new] logOut];
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if(error != nil){
            NSLog(@"User log out failed: %@", error.localizedDescription);
        } else {
            NSLog(@"successfully Logged out");
        }
    }];
    
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [locations lastObject];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqual:@"composeView"]){
        UINavigationController *navigationController = [segue destinationViewController];
        HostEventViewController *hostEventViewController = (HostEventViewController*)navigationController.topViewController;
        hostEventViewController.delegate = self;
    }
    
}

@end
