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
    NSString *totalRSVP = [NSString stringWithFormat:@"%i", self.event[@"rsvpCount"]];
    NSString *totalAttending = [totalRSVP stringByAppendingString:@" People Attending"];
    self.totalAttendingLabel.text = totalAttending;
    self.eventAddressLabel.text = self.event[@"eventAddress"];
    
    //Show event on map
    self.geopoint = self.event[@"eventLocation"];
    CLLocationCoordinate2D mapCoordinates = CLLocationCoordinate2DMake(self.geopoint.latitude, self.geopoint.longitude);
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(mapCoordinates, 500, 500);
    MKPointAnnotation *marker = [[MKPointAnnotation alloc] init];
    marker.coordinate = mapCoordinates;
    [self.mapView setCenterCoordinate:mapCoordinates];
    [self.mapView setRegion:viewRegion animated:YES];
    [self.mapView addAnnotation:marker];
}

- (IBAction)didTapCancelRSVP:(id)sender {
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
