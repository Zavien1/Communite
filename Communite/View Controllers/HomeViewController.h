//
//  HomeViewController.h
//  Communite
//
//  Created by Zavien Sibilia on 7/12/21.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

NS_ASSUME_NONNULL_END
