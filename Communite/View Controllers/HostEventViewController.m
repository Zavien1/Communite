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


@interface HostEventViewController () <CLLocationManagerDelegate>

@property (nonatomic) double userLat;
@property (nonatomic) double userLong;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *eventNameTextField;
@property (weak, nonatomic) IBOutlet SearchVenueTextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *eventStartDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *eventEndDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *createEventButton;

@end

@implementation HostEventViewController{
    CLLocationManager *locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
    
    if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        //iOS 8.0 onwards
        [locationManager requestAlwaysAuthorization];
    }
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];

}


- (void)fetchPlaces {
    NSString *lat = [NSString stringWithFormat:@"%.20f", self.userLat];
    NSString *lon = [NSString stringWithFormat:@"%.20f", self.userLong];
    NSString *comma = @",";
    NSString *latFormatting = [lat stringByAppendingString:comma];
    NSString *longFormatting = [latFormatting stringByAppendingString:lon];
    NSString *urlString = @"https://api.foursquare.com/v2/venues/search?ll=";
    NSString *halfUrl = [urlString stringByAppendingString:longFormatting];
    NSString *fullUrl = [halfUrl stringByAppendingString:@"&limit=50&radius=20 &v=20210720&client_id=BU5XORQ1GAHTPDGDGW1EJPBMVHVHVZQBGGCKSAGUAGSYRSJ2&client_secret=1Y555WLVJGRWJ2GLXYHZVGFTGNJZKWUBV5C2X1U42YC3UKI0"];
    fullUrl = [fullUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
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
            self.searchTextField.venuesArray = dataDictionary[@"response"][@"venues"];
        }
    }];
    [task resume];
}

- (IBAction)didTapCreate:(id)sender {
    
    PFGeoPoint *geopoint = [PFGeoPoint geoPointWithLatitude:[self.searchTextField.venueLat doubleValue] longitude:[self.searchTextField.venueLong doubleValue]];
    
    Event *event = [PFObject objectWithClassName:@"Event"];
    event[@"creator"] = PFUser.currentUser;
    event[@"eventName"] = self.eventNameTextField.text;
    event[@"eventDescription"] = self.eventDescriptionTextField.text;
    event[@"eventStartDate"] = self.eventStartDatePicker.date;
    event[@"eventEndDate"] = self.eventEndDatePicker.date;
    event[@"eventLocation"] = geopoint;
    
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

#pragma mark - CLLocationManagerDelegate
 
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                                    initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}
 
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil) {
        self.userLong = currentLocation.coordinate.longitude;
        self.userLat = currentLocation.coordinate.latitude;
        [self fetchPlaces];
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
