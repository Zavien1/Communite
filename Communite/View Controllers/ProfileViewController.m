//
//  ProfileViewController.m
//  Communite
//
//  Created by Zavien Sibilia on 7/13/21.
//

#import "Event.h"
#import "Parse/Parse.h"
#import "ProfileCell.h"
#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userCurrentLocationAddress;
@property (weak, nonatomic) IBOutlet UILabel *totalEventsAttended;
@property (weak, nonatomic) IBOutlet UILabel *totalEventsHosted;
@property (strong, nonatomic) NSArray *events;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setBasicProfile];
    [self fetchUserData];
}

-(void)viewDidAppear:(BOOL)animated {
    // Reload post every time you view the page
    [self fetchUserData];
}

- (void)fetchUserData {
    // Construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query includeKey:@"image"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query orderByDescending:@"createdAt"];
    
    // Fetch posts asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *events, NSError *error) {
        if (events != nil) {
            self.events = [Event createEventArray:events];
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)setBasicProfile {
    PFUser *user = [PFUser currentUser];
    // Setting username label
    self.userNameLabel.text = user.username;
    self.userCurrentLocationAddress.text = user[@"userAddress"];
    self.totalEventsHosted.text = user[@"eventsHosted"];
    self.totalEventsAttended.text = user[@"eventsAttended"];
    PFFileObject *image = user[@"userProfileImage"];
    [self.userProfileImage setImageWithURL:[NSURL URLWithString:image.url]];
    
    // Setting navigation bar title
    self.navigationItem.title = [NSString stringWithFormat:@"%@'s Profile", [PFUser currentUser].username];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProfileCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ProfileCell" forIndexPath:indexPath];
    
    Event *event = self.events[indexPath.row];
    
    cell.eventNameLabel.text = event[@"eventName"];
    
    return cell;
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
