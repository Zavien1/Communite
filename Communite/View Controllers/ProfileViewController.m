//
//  ProfileViewController.m
//  Communite
//
//  Created by Zavien Sibilia on 7/13/21.
//

#import "DetailsViewController.h"
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
    [query whereKey:@"creator" equalTo:[PFUser currentUser]];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"creator"];
    [query includeKey:@"eventName"];
    [query includeKey:@"eventDescription"];
    [query includeKey:@"eventLocation"];
    [query includeKey:@"eventStartDate"];
    [query includeKey:@"eventEndDate"];
    [query includeKey:@"rsvpCount"];
    
    // Fetch posts asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *events, NSError *error) {
        if (events != nil) {
            self.events = events;
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
    self.totalEventsHosted.text = [NSString stringWithFormat:@"%@", user[@"eventsHosted"]];
    self.totalEventsAttended.text = [NSString stringWithFormat:@"%@", user[@"eventsAttended"]];
    PFFileObject *image = user[@"userProfileImage"];
    [self.userProfileImage setImageWithURL:[NSURL URLWithString:image.url]];
    
    // Setting navigation bar title
    self.navigationItem.title = [NSString stringWithFormat:@"%@'s Profile", [PFUser currentUser].username];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ProfileCell" forIndexPath:indexPath];
    
    Event *event = self.events[indexPath.row];
    
    cell.eventNameLabel.text = event[@"eventName"];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqual:@"detailsView"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Event *event = self.events[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.event = event;
    }
}


@end
