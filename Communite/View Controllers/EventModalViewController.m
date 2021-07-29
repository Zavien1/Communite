//
//  EventModalViewController.m
//  Communite
//
//  Created by Zavien Sibilia on 7/26/21.
//

#import "EventModalViewController.h"
#import "Parse/Parse.h"
#import "UIImageView+AFNetworking.h"

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
    [self generateEvent:self.event];
}

- (IBAction)didTapRSVP:(id)sender {
    
    PFQuery *eventQuery = [PFQuery queryWithClassName:@"Event"];
    [eventQuery whereKey:@"objectId" equalTo:self.event.objectId];
    [eventQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable events, NSError * _Nullable error) {
        if(events != nil){
            Event *receivedEvent = events[0];
            NSMutableArray *usersWhoRSVP = receivedEvent[@"usersAttending"];
            [[PFUser currentUser] fetchIfNeeded];
            if([usersWhoRSVP containsObject:[PFUser currentUser]]){
                NSNumber *numberOfRSVPs = receivedEvent[@"rsvpCount"];
                NSNumber *newRSVPs = [NSNumber numberWithInt:([numberOfRSVPs intValue] - 1)];
                receivedEvent[@"rsvpCount"] = newRSVPs;
                
                [usersWhoRSVP removeObject:[PFUser currentUser]];
                receivedEvent[@"usersAttending"] = usersWhoRSVP;
            }
            else{
                NSNumber *numberOfRSVPs = receivedEvent[@"rsvpCount"];
                NSNumber *newRSVPs = [NSNumber numberWithInt:([numberOfRSVPs intValue] + 1)];
                receivedEvent[@"rsvpCount"] = newRSVPs;
                
                [usersWhoRSVP addObject:[PFUser currentUser]];
                receivedEvent[@"usersAttending"] = usersWhoRSVP;
            }
            [receivedEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if(error){
                    NSLog(@"Failed to RSVP for event %@", error.localizedDescription);
                }
                else{
                    [self generateEvent:receivedEvent];
                }
            }];
        }
        else{
            NSLog(@"error %@", error.localizedDescription);
        }
    }];
}

- (void)generateEvent:(Event *)event{
    self.event = event;
    
    PFUser *creator = self.event[@"creator"];
    NSString *eventHost = creator.username;
    NSString *hostedBy = [@"Hosted By: " stringByAppendingString:eventHost];
    PFFileObject *image = creator[@"userProfileImage"];
    [self.hostProfileImage setImageWithURL:[NSURL URLWithString:image.url]];
    
    NSMutableArray *usersWhoRSVP = self.event[@"usersAttending"];
    if ([usersWhoRSVP containsObject:[PFUser currentUser]]) {
        [self.rsvpButton setBackgroundColor:[UIColor systemGreenColor]];
        [self.rsvpButton setTitle:@"RSVP'D" forState:UIControlStateNormal];
    } else {
        [self.rsvpButton setBackgroundColor:[UIColor systemBlueColor]];
        [self.rsvpButton setTitle:@"RSVP" forState:UIControlStateNormal];
        
    }

    self.eventHostLabel.text = hostedBy;
    self.eventNameLabel.text = self.event[@"eventName"];
    self.eventAddressLabel.text = self.event[@"eventAddress"];
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
