//
//  HomeViewController.m
//  Communite
//
//  Created by Zavien Sibilia on 7/12/21.
//

#import "Event.h"
#import "EventMarker.h"
#import "EventModalViewController.h"
#import "HomeViewController.h"
#import "HostEventViewController.h"
#import "LoginViewController.h"
#import "MapKit/MapKit.h"
#import "Parse/Parse.h"
#import "Trie.h"
#import "SceneDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <UIKit/UIKit.h>
@import CoreLocation;

@interface HomeViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableArray *arrayOfEvents;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.delegate = self;
    
    Trie *t = [[Trie alloc] init];
    [t formatString:@"T-Mobile"];
    
    NSLog(@"View loaded");
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    [self centerViewOnUserLocation];
    [self fetchEvents];
}

- (void)fetchEvents {
    // construct PFQuery
    PFQuery *eventQuery = [PFQuery queryWithClassName:@"Event"];
    [eventQuery orderByDescending:@"createdAt"];
    [eventQuery includeKey:@"creator"];
    [eventQuery includeKey:@"eventName"];
    [eventQuery includeKey:@"eventDescription"];
    [eventQuery includeKey:@"eventLocation"];
    [eventQuery includeKey:@"eventStartDate"];
    [eventQuery includeKey:@"eventEndDate"];
    [eventQuery includeKey:@"rsvpCount"];
    eventQuery.limit = 20;
    
    // fetch data asynchronously
    [eventQuery findObjectsInBackgroundWithBlock:^(NSArray<Event *> * _Nullable events, NSError * _Nullable error) {
        if (events) {
            self.arrayOfEvents = events;
            [self createEventMarker];
            [super viewDidAppear:TRUE];
        } else {
            NSLog(@"Error querying for data %@", error.localizedDescription);
        }
    }];
}

- (void)didPost {
    [self fetchEvents];
}

- (void)createEventMarker {
    for (id event in self.arrayOfEvents) {
        EventMarker *annotation = [[EventMarker alloc] init];
        [annotation generateMarker:event];
        [self.mapView addAnnotation:annotation];
    }
}

- (void)centerViewOnUserLocation {
    if(self.locationManager.location) {
        CLLocationCoordinate2D location = self.locationManager.location.coordinate;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 5000, 5000);
        [self.mapView setRegion:region];
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    EventMarker *marker = view.annotation;
    [self performSegueWithIdentifier:@"rsvpSegue" sender:marker.event];
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
    if([segue.identifier isEqual:@"rsvpSegue"]){
        Event *event = sender;
        UINavigationController *navigationController = [segue destinationViewController];
        EventModalViewController *eventModalViewController = (EventModalViewController*)navigationController.topViewController;
        eventModalViewController.event = event;
    }
}

@end
