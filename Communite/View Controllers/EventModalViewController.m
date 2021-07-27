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
    PFQuery *eventQuery = [PFQuery queryWithClassName:@"Event"];
    [eventQuery whereKey:@"objectId" equalTo:self.event.objectId];
    [eventQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable events, NSError * _Nullable error) {
        if(events != nil){
            Event *queriedEvent = events[0];
            NSMutableArray *usersWhoRSVP = queriedEvent[@"usersLiked"];
            if([usersWhoRSVP containsObject:[PFUser currentUser].username]) {
                NSNumber *numberOfLikes = queriedEvent[@"rsvpCount"];
                NSNumber *newLikes = [NSNumber numberWithInt:([numberOfLikes intValue] - 1)];
                queriedEvent[@"rsvpCount"] = newLikes;
                
                [usersWhoRSVP removeObject:[PFUser currentUser].username];
                queriedEvent[@"rsvpCount"] = usersWhoRSVP;
                
//                [self.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
                
            }
            else{
                NSNumber *numberOfRSVPs = queriedEvent[@"rsvpCount"];
                NSNumber *newRSVPs = [NSNumber numberWithInt:([numberOfRSVPs intValue] + 1)];
                queriedEvent[@"rsvpCount"] = newRSVPs;
                
                [usersWhoRSVP addObject:[PFUser currentUser].username];
                queriedEvent[@"usersLiked"] = usersWhoRSVP;
//                [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-1"] forState:UIControlStateNormal];
            }
            
            [queriedEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if(error){
                    NSLog(@"Failed to like post %@", error.localizedDescription);
                }
                else{
//                    [self generateEvent:queriedEvent];
                }
            }];
        }
        else{
            NSLog(@"error %@", error.localizedDescription);
        }
    }];
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
