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

const double DEFAULT_LAT = 11.2;
const double DEFAULT_LNG = 12.2;

+ (nonnull NSString *)parseClassName {
    return @"Event";
}

+ (void)postUserEvent:(CLLocation * _Nullable)eventLocation
      withDescription:(NSString * _Nullable)eventDescription
        withEventName:(NSString * _Nullable)eventName
             withDate:(NSDate * _Nullable)eventDate
       withCompletion:(PFBooleanResultBlock _Nullable)completion {
    
    Event *newEvent = [Event new];
    newEvent.creator = [PFUser currentUser];
    newEvent.eventName = eventName;
    newEvent.eventDescription = eventDescription;
    newEvent.eventLocation = [self getPFGeoPoint:eventLocation];
    newEvent.rsvpCount = @(0);
    
    [newEvent saveInBackgroundWithBlock: completion];
}

+ (PFGeoPoint *)getPFGeoPoint:(CLLocation * _Nullable)location {
    return [PFGeoPoint geoPointWithLatitude:DEFAULT_LAT longitude:DEFAULT_LNG];
}

- (void)initEventWithObject:(PFObject *)object {
    // Setting Post object given PFObject
    self.creator = object[@"user"];
    self.eventName = object[@"eventName"];
    self.rsvpCount = object[@"rsvpCount"];
    self.objectID = object.objectId;
    self.timeCreatedAt = object.createdAt;
}


@end
