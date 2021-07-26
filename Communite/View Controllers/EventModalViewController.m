//
//  EventModalViewController.m
//  Communite
//
//  Created by Zavien Sibilia on 7/26/21.
//

#import "EventModalViewController.h"

@interface EventModalViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hostProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *eventHostLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *rsvpButton;

@end

@implementation EventModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set details text
//    PFUser *creator = self.event[@"creator"];
//    self.eventHostLabel.text = creator.username;
//    self.eventNameLabel.text = self.event[@"eventName"];
}
- (IBAction)didTapRSVP:(id)sender {
    
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
