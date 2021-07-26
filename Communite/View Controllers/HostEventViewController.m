//
//  HostEventViewController.m
//  Communite
//
//  Created by Zavien Sibilia on 7/19/21.
//

#import "Event.h"
#import "HomeViewController.h"
#import "HostEventViewController.h"
#import "Parse/Parse.h"
#import "SearchVenueTextField.h"


@interface HostEventViewController ()

@property (nonatomic) double userLat;
@property (nonatomic) double userLong;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *eventNameTextField;
@property (weak, nonatomic) IBOutlet SearchVenueTextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *eventStartDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *eventEndDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *createEventButton;
@property (strong, nonatomic) PFGeoPoint *point;

@end

@implementation HostEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeViewController *homeViewController;
    homeViewController.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    homeViewController.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [homeViewController.locationManager startUpdatingLocation];
    
    self.userLong = homeViewController.locationManager.location.coordinate.longitude;
    self.userLat = homeViewController.locationManager.location.coordinate.latitude;
    [self fetchPlaces];
}


- (void)fetchPlaces {
    
    NSString *lat = [NSString stringWithFormat:@"%.20f", self.userLat];
    NSString *lon = [NSString stringWithFormat:@"%.20f", self.userLong];
    NSString *comma = @",";
    NSString *latFormatting = [lat stringByAppendingString:comma];
    NSString *longFormatting = [latFormatting stringByAppendingString:lon];
    NSString *urlString = @"https://api.foursquare.com/v2/venues/search?ll=";
    NSString *halfUrl = [urlString stringByAppendingString:longFormatting];
    NSString *fullUrl = [halfUrl stringByAppendingString:@"&limit=50&radius=20&client_id=BU5XORQ1GAHTPDGDGW1EJPBMVHVHVZQBGGCKSAGUAGSYRSJ2&client_secret=1Y555WLVJGRWJ2GLXYHZVGFTGNJZKWUBV5C2X1U42YC3UKI0"];
    
    NSLog(@"%@", fullUrl);
    
    NSURL *url = [NSURL URLWithString:fullUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error" message:@"Failed to connect to the internet" preferredStyle:(UIAlertControllerStyleAlert)];
               
               // create an OK action
               UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * _Nonnull action) {
                                                                        // handle response here.
                                                                }];
               // add the OK action to the alert controller
               [alert addAction:okAction];
                                        
               [self presentViewController:alert animated:YES completion:^{
               // optional codefor what happens after the alert controller has finished presenting
               }];
           }
           else{
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               self.venuesArray = dataDictionary[@"response"];
               NSLog(@"%@", self.venuesArray);
           }
       }];
    [task resume];
}

- (IBAction)didTapCreate:(id)sender {
    
    [self retrieveGeocodeAddress];
    
    NSLog(@"This is the callback %@", self.point);
    
    Event *event = [PFObject objectWithClassName:@"Event"];
    event[@"creator"] = PFUser.currentUser;
    event[@"eventName"] = self.eventNameTextField.text;
    event[@"eventDescription"] = self.eventDescriptionTextField.text;
    event[@"eventStartDate"] = self.eventStartDatePicker.date;
    event[@"eventEndDate"] = self.eventEndDatePicker.date;
//    event[@"eventLocation"] = self.point;
    
    [event saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.delegate didPost];
        }
        else{
            NSLog(@"Error posting event %@", error.localizedDescription);
        }
    }];
}

- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)retrieveGeocodeAddress {
//    NSString *address = self.eventAddressTextField.text;
//    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks2, NSError *error)
//     {
//        NSLog(@"this is the address: %@", address);
//        if ([placemarks2 count] > 0) {
//            CLPlacemark *placemark = [placemarks2 lastObject];
//            NSArray *lines = placemark.addressDictionary[@"FormattedAddressLines"];
//            CLLocation *location = placemark.location;
//            
//            NSString *str_lat = [NSString stringWithFormat: @"%f", location .coordinate.latitude];
//            NSString *str_long = [NSString stringWithFormat: @"%f", location.coordinate.longitude];
//            NSString *finalAddress = [NSString stringWithFormat:@" %@, %@, %@", lines, str_lat , str_long ];
//            
//            NSLog(@"Placemarks %@", placemarks2);
//
//            self.point = [PFGeoPoint geoPointWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
//            NSLog(@"This is the point inside the function %@", self.point);
//
//        }
//        if(error) {
//            NSLog(@"Error");
//            return;
//        }
//    }];
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
