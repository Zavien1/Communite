//
//  EventCell.h
//  Communite
//
//  Created by Zavien Sibilia on 7/15/21.
//

#import "Event.h"
#import "MapKit/MapKit.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventTimeLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) Event *event;
@property (strong, nonatomic) PFGeoPoint *geopoint;


- (void)generateCell:(Event *)event;


@end

NS_ASSUME_NONNULL_END
