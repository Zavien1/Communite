//
//  EventMarker.h
//  Communite
//
//  Created by Zavien Sibilia on 7/26/21.
//

#import "Event.h"
#import "Parse/Parse.h"
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventMarker : MKPointAnnotation

@property (strong, nonatomic) Event *event;
@property (strong, nonatomic) PFGeoPoint *geopoint;
@property (strong, nonatomic) NSString *eventName;

- (void)generateMarker:(Event *)event;

@end

NS_ASSUME_NONNULL_END
