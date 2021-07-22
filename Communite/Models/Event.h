//
//  Event.h
//  Communite
//
//  Created by Zavien Sibilia on 7/20/21.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Event : PFObject

@property (nonatomic, strong) NSString *eventID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *creator;

@property (nonatomic, strong) NSDate *eventDate;
@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) PFGeoPoint *eventLocation;
@property (nonatomic, strong) NSNumber *rsvpCount;

@end

NS_ASSUME_NONNULL_END
