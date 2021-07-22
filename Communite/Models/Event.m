//
//  Event.m
//  Communite
//
//  Created by Zavien Sibilia on 7/20/21.
//

#import "Event.h"

@implementation Event

@dynamic eventID;
@dynamic userID;
@dynamic creator;
@dynamic eventName;
@dynamic eventDescription;
@dynamic eventDate;
@dynamic eventLocation;
@dynamic rsvpCount;

+ (nonnull NSString *)parseClassName {
    return @"Event";
}

+ (void)postUserEvent:(CLLocation * _Nullable)eventLocation
      withDescription:(NSString * _Nullable)eventDescription
        withEventName:(NSString * _Nullable)eventName
             withDate:(NSDate * _Nullable)eventDate
       withCompletion:(PFBooleanResultBlock  _Nullable)completion {
    
    Event *newEvent = [Event new];
    newEvent.creator = [PFUser currentUser];
    newEvent.eventName = eventName;
    newEvent.eventDescription = eventDescription;
    newEvent.eventLocation = [self getPFGeoPoint:eventLocation];
    newEvent.rsvpCount = @(0);
    
    [newEvent saveInBackgroundWithBlock: completion];
}

+ (PFGeoPoint *)getPFGeoPoint:(CLLocation * _Nullable)location {
    
    return [PFGeoPoint geoPointWithLatitude:11.2 longitude:12.2];
    
}


@end
