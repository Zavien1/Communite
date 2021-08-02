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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
}

@end
