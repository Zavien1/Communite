//
//  HostEventViewController.h
//  Communite
//
//  Created by Zavien Sibilia on 7/19/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HostEventViewControllerDelegate

- (void)didPost;

@end

@interface HostEventViewController : UIViewController

@property (weak, nonatomic) id<HostEventViewControllerDelegate> delegate;
@property (weak, nonatomic) NSArray *venuesArray;

@end

NS_ASSUME_NONNULL_END
