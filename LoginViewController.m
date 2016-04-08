//
//  LoginViewController.m
//  SignUpApp
//
//  Created by tops on 2/18/16.
//  Copyright (c) 2016 tops. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize txt_pass,txt_unm;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn_login_action:(id)sender
{
    NSString *st_login=[NSString stringWithFormat:@"http://krushna2016-001-site1.ctempurl.com/webservice02172016.asmx/JsonCrud4CheckLogin?u_nm=%@&u_pass=%@",txt_unm.text,txt_pass.text];
    NSURL *url=[NSURL URLWithString:st_login];
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSString *st=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    st=[st stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
    NSLog(@"%d",[st intValue]);
    
    if ([st intValue]>0)
    {
        DetailViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        detail.str_detail=st;
        
        [self.navigationController pushViewController:detail animated:YES];
    }
    else
    {
        UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Invalid" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
    }
}
@end
