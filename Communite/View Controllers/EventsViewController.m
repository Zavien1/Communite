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
@property (strong, nonatomic) NSMutableArray* arrayOfEvents;


@end

@implementation EventsViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self fetchEvents];
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
            self.arrayOfEvents = events;
            [self.tableView reloadData];
        }
        else{
            NSLog(@"Error querying for data %@", error.localizedDescription);
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EventCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"EventCell" forIndexPath:indexPath];
    Event *event = self.arrayOfEvents[indexPath.row];
    [cell generateCell:event];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqual:@"detailsView"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Event *event = self.arrayOfEvents[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.event = event;
    }
}


@end
