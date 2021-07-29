//
//  DetailsViewController.h
//  Communite
//
//  Created by Zavien Sibilia on 7/19/21.
//

#import "Event.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) Event *event;
@property (strong, nonatomic) PFGeoPoint *geopoint;

@end

NS_ASSUME_NONNULL_END
