//
//  DetailsViewController.m
//  Communite
//
//  Created by Zavien Sibilia on 7/19/21.
//

#import "DetailsViewController.h"
#import "MapKit/Mapkit.h"

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
    // Do any additional setup after loading the view.
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
