//
//  ViewController.m
//  SignUpApp
//
//  Created by tops on 2/18/16.
//  Copyright (c) 2016 tops. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize txt_ct,txt_fnm,txt_lnm,txt_pass,txt_st,txt_unm,img_vw;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    arr_st=[[NSArray alloc]init];
    arr_ct=[[NSArray alloc]init];
    
    NSURL *url_st=[NSURL URLWithString:@"http://krushna2016-001-site1.ctempurl.com/webservice02172016.asmx/JsonCrud1GetAllStates"];
    
    NSData *data_st=[NSData dataWithContentsOfURL:url_st];
    
    arr_st=[NSJSONSerialization JSONObjectWithData:data_st options:kNilOptions error:nil];
    
    pkr_st=[[UIPickerView alloc]init];
    pkr_st.dataSource=self;
    pkr_st.delegate=self;
    [txt_st setInputView:pkr_st];
    
    txt_ct.delegate=self;
    pkr_ct=[[UIPickerView alloc]init];
    pkr_ct.dataSource=self;
    pkr_ct.delegate=self;
    [txt_ct setInputView:pkr_ct];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==txt_ct)
    {
        if (txt_st.text.length>0)
        {
            NSArray *arr_st_nm=[arr_st valueForKey:@"state_nm"];
            //NSLog(@"%@",arr_st_nm);
            
            NSInteger indexst=[arr_st_nm indexOfObject:txt_st.text];
            //NSLog(@"%d",(int)indexst);
            
            NSString *st_formt=[NSString stringWithFormat:@"http://krushna2016-001-site1.ctempurl.com/webservice02172016.asmx/JsonCrud2GetCityByState?state_id=%@",[[arr_st objectAtIndex:indexst]objectForKey:@"state_id"]];
            
            NSURL *url_ct=[NSURL URLWithString:st_formt];
            NSData *data_ct=[NSData dataWithContentsOfURL:url_ct];
            arr_ct=[NSJSONSerialization JSONObjectWithData:data_ct options:kNilOptions error:nil];
            [pkr_ct reloadAllComponents];
        }
    }
}
// returns the number of 'columns=1' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger index;
    if (pickerView==pkr_st)
    {
        index=arr_st.count;
    }
    else if (pickerView==pkr_ct)
    {
        index=arr_ct.count;
    }
    return index;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *index=@"";
    if (pickerView==pkr_st)
    {
        index=[[arr_st objectAtIndex:row]objectForKey:@"state_nm"];
    }
    else if (pickerView==pkr_ct)
    {
         index=[[arr_ct objectAtIndex:row]objectForKey:@"city_nm"];
    }
    return index;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==pkr_st)
    {
        txt_st.text=[[arr_st objectAtIndex:row]objectForKey:@"state_nm"];
    }
    else if (pickerView==pkr_ct)
    {
        txt_ct.text=[[arr_ct objectAtIndex:row]objectForKey:@"city_nm"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_submit_action:(id)sender
{
    NSArray *arr_st_nm=[arr_st valueForKey:@"state_nm"];
    NSInteger indexst=[arr_st_nm indexOfObject:txt_st.text];
    NSString *state_id=[[arr_st objectAtIndex:indexst]objectForKey:@"state_id"];
    
    NSArray *arr_ct_nm=[arr_ct valueForKey:@"city_nm"];
    NSInteger indexct=[arr_ct_nm indexOfObject:txt_ct.text];
    NSString *city_id=[[arr_ct objectAtIndex:indexct]objectForKey:@"city_id"];
    
    
    
    NSURL *url_post=[NSURL URLWithString:@"http://krushna2016-001-site1.ctempurl.com/webservice02172016.asmx/JsonCrud3InsertUserData?"];
    
    NSMutableURLRequest *req=[[NSMutableURLRequest alloc]initWithURL:url_post];
    
    NSString *st_body=[NSString stringWithFormat:@"txt_fnm=%@&txt_lnm=%@&u_st=%@&u_ct=%@&u_photo=%@&u_unm=%@&u_pass=%@",txt_fnm.text,txt_lnm.text,state_id,city_id,[self encodeToBase64String:img_vw.image],txt_unm.text,txt_pass.text];
    
    [req setHTTPBody:[st_body dataUsingEncoding:NSUTF8StringEncoding]];
    [req setHTTPMethod:@"POST"];
    
    NSURLConnection *con=[NSURLConnection connectionWithRequest:req delegate:self];
    if (con)
    {
        
    }

}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSString *st=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",st);
}
- (IBAction)btn_upload_action:(id)sender
{
    UIImagePickerController *img_pkr=[[UIImagePickerController alloc]init];
    img_pkr.delegate=self;
    img_pkr.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:img_pkr animated:YES completion:nil];
}
- (NSString *)encodeToBase64String:(UIImage *)image
{
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *img=info[UIImagePickerControllerOriginalImage];
    img_vw.image=img;
}
@end
