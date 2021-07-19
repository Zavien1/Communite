//
//  EventCell.h
//  Communite
//
//  Created by Zavien Sibilia on 7/15/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventTimeLabel;

@end

NS_ASSUME_NONNULL_END
