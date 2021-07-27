//
//  Venue.h
//  Communite
//
//  Created by Zavien Sibilia on 7/26/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Venue : NSObject

@property (nonatomic, strong) NSString *venueName;
@property (nonatomic, strong) NSString *venueAddress;;
@property (nonatomic, strong) NSString *venueCategory;
@property (nonatomic, strong) NSNumber *venueLat;
@property (nonatomic, strong) NSNumber *venueLong;

@end

NS_ASSUME_NONNULL_END
