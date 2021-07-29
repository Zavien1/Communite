//  EventCell.m
//  Communite
//
//  Created by Zavien Sibilia on 7/15/21.
//

#import "EventCell.h"
#import "Parse/Parse.h"

@implementation EventCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)generateCell:(Event *)event {
    self.event = event;
    PFUser *creator = event[@"creator"];
    self.hostNameLabel.text = creator.username;
    self.eventTitleLabel.text = event[@"eventName"];
    self.geopoint = event[@"eventLocation"];
    CLLocationCoordinate2D mapCoordinates = CLLocationCoordinate2DMake(self.geopoint.latitude, self.geopoint.longitude);
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(mapCoordinates, 500, 500);
    MKPointAnnotation *marker = [[MKPointAnnotation alloc] init];
    marker.coordinate = mapCoordinates;
    [self.mapView setCenterCoordinate:mapCoordinates];
    [self.mapView setRegion:viewRegion animated:YES];
    [self.mapView addAnnotation:marker];
//    self.eventTimeLabel.text = event[@"eventStartDate"];
//    self.addressLabel.text = event[@"eventLocation"];
//
//    if([post[@"likes"] intValue] == 1){
//        self.postLikesLabel.text = [NSString stringWithFormat:@"%@ like", post[@"likes"]];
//    }
//    else{
//        self.postLikesLabel.text = [NSString stringWithFormat:@"%@ likes", post[@"likes"]];
//    }
//
//    //check if user already liked post on load so that like button is highlighted
//    if([post[@"usersLiked"] containsObject:[PFUser currentUser].username]){
//        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-1"] forState:UIControlStateNormal];
//    }
//    else{
//        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
//    }
    
//    
//    PFFileObject *image = post[@"image"];
//    [self.postImage setImageWithURL:[NSURL URLWithString:image.url]];
}

@end
