//
//  SearchVenueTextField.h
//  Communite
//
//  Created by Zavien Sibilia on 7/22/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchVenueTextField : UITextField <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *venuesArray;
@property (strong, nonatomic) NSNumber *venueLat;
@property (strong, nonatomic) NSNumber *venueLong;
@property (strong, nonatomic) NSString *venueAddress;

@end

NS_ASSUME_NONNULL_END
