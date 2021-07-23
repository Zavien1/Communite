//
//  HostEventViewController.m
//  Communite
//
//  Created by Zavien Sibilia on 7/19/21.
//

#import "Event.h"
#import "HostEventViewController.h"
#import "Parse/Parse.h"
#import "SearchVenueTextField.h"


@interface HostEventViewController ()

@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *eventNameTextField;
@property (weak, nonatomic) IBOutlet SearchVenueTextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *eventStartDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *eventEndDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *createEventButton;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) PFGeoPoint *point;

@end

@implementation HostEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
