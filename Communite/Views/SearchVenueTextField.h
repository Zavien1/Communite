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

@end

NS_ASSUME_NONNULL_END
