//
//  DetailsViewController.m
//  Communite
//
//  Created by Zavien Sibilia on 7/19/21.
//

#import "DetailsViewController.h"
#import "MapKit/Mapkit.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *hostProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *hostedByLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAttendingLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *eventRSVPButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation DetailsViewController

const double ZOOM_X = 500;
const double ZOOM_Y = 500;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFUser *creator = self.event[@"creator"];
    NSString *eventHost = creator.username;
    NSString *hostedBy = [@"Hosted By: " stringByAppendingString:eventHost];
    self.hostedByLabel.text = hostedBy;
    PFFileObject *image = creator[@"userProfileImage"];
    [self.hostProfileImage setImageWithURL:[NSURL URLWithString:image.url]];
    self.eventDescriptionLabel.text = self.event[@"eventDescription"];
    self.eventTitleLabel.text = self.event[@"eventName"];
    NSString *totalRSVP = [NSString stringWithFormat:@"%@", self.event[@"rsvpCount"]];
    NSString *totalAttending = [totalRSVP stringByAppendingString:@" People Attending"];
    self.totalAttendingLabel.text = totalAttending;
    self.eventAddressLabel.text = self.event[@"eventAddress"];
    
    // Show event on map.
    self.geopoint = self.event[@"eventLocation"];
    CLLocationCoordinate2D mapCoordinates = CLLocationCoordinate2DMake(self.geopoint.latitude, self.geopoint.longitude);
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(mapCoordinates, ZOOM_X, ZOOM_Y);
    MKPointAnnotation *marker = [[MKPointAnnotation alloc] init];
    marker.coordinate = mapCoordinates;
    [self.mapView setCenterCoordinate:mapCoordinates];
    [self.mapView setRegion:viewRegion animated:YES];
    [self.mapView addAnnotation:marker];
    
    if ([creator.username isEqual:[PFUser currentUser].username]) {
        [self.eventRSVPButton setTitle:@"Cancel Event" forState:UIControlStateNormal];
    } else {
        [self.eventRSVPButton setTitle:@"Cancel Reservation" forState:UIControlStateNormal];
    }
    
    
}

- (IBAction)didTapCancelRSVP:(id)sender {
    PFQuery *eventQuery = [PFQuery queryWithClassName:@"Event"];
    [eventQuery includeKey:@"creator"];
    [eventQuery whereKey:@"objectId" equalTo:self.event.objectId];
    [eventQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable events, NSError * _Nullable error) {
        if (events != nil) {
            PFObject *receivedEvent = events[0];
            PFUser *creator = receivedEvent[@"creator"];
            if ([creator.username isEqual:[PFUser currentUser].username]) {
                NSLog(@"hello");
                [PFObject deleteAllInBackground:events block:^(BOOL succeeded, NSError * _Nullable error) {
                    if (succeeded) {
                        NSLog(@"success");
                        [self dismissViewControllerAnimated:YES completion:nil];
                    } else {
                        NSLog(@"error deleting event %@", error.localizedDescription);
                    }
                }];
            } else {
//                Event *receivedEvent = events[0];
//                NSMutableArray *usersWhoRSVP = receivedEvent[@"usersAttending"];
//                NSNumber *numberOfRSVPs = receivedEvent[@"rsvpCount"];
//                NSNumber *newRSVPs = [NSNumber numberWithInt:([numberOfRSVPs intValue] - 1)];
//                receivedEvent[@"rsvpCount"] = newRSVPs;
//
//                [usersWhoRSVP removeObject:[PFUser currentUser].username];
//                receivedEvent[@"usersAttending"] = usersWhoRSVP;
//                [receivedEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//                    if (error) {
//                        NSLog(@"Failed to RSVP for event %@", error.localizedDescription);
//                    } else {
//                        [self dismissViewControllerAnimated:YES completion:nil];
//                    }
//                }];
            }
            
        } else {
            NSLog(@"error %@", error.localizedDescription);
        }
    }];
};

@end
