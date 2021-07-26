//
//  EventMarker.h
//  Communite
//
//  Created by Zavien Sibilia on 7/26/21.
//

#import "Event.h"
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventMarker : MKAnnotationView

@property (weak, nonatomic) Event *event;

@end

NS_ASSUME_NONNULL_END
