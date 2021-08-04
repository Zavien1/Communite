//
//  ProfileCell.h
//  Communite
//
//  Created by Zavien Sibilia on 8/2/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDateLabel;

@end

NS_ASSUME_NONNULL_END
