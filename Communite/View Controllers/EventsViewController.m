//
//  EventsViewController.m
//  Communite
//
//  Created by Zavien Sibilia on 7/13/21.
//

#import "DetailsViewController.h"
#import "Event.h"
#import "EventCell.h"
#import "EventsViewController.h"
#import "Parse/Parse.h"

@interface EventsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* events;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation EventsViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self fetchEvents];
}

- (void)viewWillAppear:(BOOL)animated {
    // Reloads posts when page is viewed
    [self.tableView reloadData];
}


- (void)fetchEvents{
    // construct PFQuery
    PFQuery *eventQuery = [PFQuery queryWithClassName:@"Event"];
    [eventQuery orderByDescending:@"createdAt"];
    [eventQuery includeKey:@"creator"];
    [eventQuery includeKey:@"eventName"];
    [eventQuery includeKey:@"eventDescription"];
    [eventQuery includeKey:@"eventLocation"];
    [eventQuery includeKey:@"eventStartDate"];
    [eventQuery includeKey:@"eventEndDate"];
    [eventQuery includeKey:@"rsvpCount"];
    eventQuery.limit = 20;
    
    // fetch data asynchronously
    [eventQuery findObjectsInBackgroundWithBlock:^(NSArray<Event *> * _Nullable events, NSError * _Nullable error){
        if(events){
            self.events = [Event createEventArray:events];
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }
        else{
            NSLog(@"Error querying for data %@", error.localizedDescription);
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EventCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"EventCell" forIndexPath:indexPath];
    Event *event = self.events[indexPath.row];
    [cell generateCell:event];
    
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
