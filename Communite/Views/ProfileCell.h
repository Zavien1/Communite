//
//  ProfileCell.h
//  Communite
//
//  Created by Zavien Sibilia on 8/2/21.
//

#import "Event.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (weak, nonatomic) Event *event;

@end

NS_ASSUME_NONNULL_END
