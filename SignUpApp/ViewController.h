//
//  ViewController.h
//  SignUpApp
//
//  Created by tops on 2/18/16.
//  Copyright (c) 2016 tops. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,NSURLConnectionDelegate>
{
    NSArray *arr_st;
    UIPickerView *pkr_st;
    
    UIPickerView *pkr_ct;
    NSArray *arr_ct;
}
@property (weak, nonatomic) IBOutlet UITextField *txt_fnm;
@property (weak, nonatomic) IBOutlet UITextField *txt_lnm;
@property (weak, nonatomic) IBOutlet UITextField *txt_st;
@property (weak, nonatomic) IBOutlet UITextField *txt_ct;
@property (weak, nonatomic) IBOutlet UITextField *txt_unm;
@property (weak, nonatomic) IBOutlet UITextField *txt_pass;
@property (weak, nonatomic) IBOutlet UIImageView *img_vw;
- (IBAction)btn_submit_action:(id)sender;
- (IBAction)btn_upload_action:(id)sender;


@end

