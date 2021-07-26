//
//  HomeViewController.h
//  Communite
//
//  Created by Zavien Sibilia on 7/12/21.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

NS_ASSUME_NONNULL_END
