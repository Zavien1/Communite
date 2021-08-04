//
//  SettingsViewController.m
//  Communite
//
//  Created by Zavien Sibilia on 7/13/21.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "SettingsViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.delegate = self;
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"User log out failed: %@", error.localizedDescription);
        } else {
            NSLog(@"successfully Logged out");
        }
    }];
    
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
}

@end
