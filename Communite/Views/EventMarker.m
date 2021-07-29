//
//  EventMarker.m
//  Communite
//
//  Created by Zavien Sibilia on 7/26/21.
//

#import "EventMarker.h"

@implementation EventMarker

- (void)generateMarker:(Event *)event {
    self.event = event;
    self.title = event[@"eventName"];
    self.geopoint = event[@"eventLocation"];
    self.coordinate = CLLocationCoordinate2DMake(self.geopoint.latitude, self.geopoint.longitude);
    self.eventName = event[@"eventName"];
}

@end
