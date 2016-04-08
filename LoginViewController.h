//
//  LoginViewController.h
//  SignUpApp
//
//  Created by tops on 2/18/16.
//  Copyright (c) 2016 tops. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txt_unm;
@property (weak, nonatomic) IBOutlet UITextField *txt_pass;
- (IBAction)btn_login_action:(id)sender;

@end
