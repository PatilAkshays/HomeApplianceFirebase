//
//  ViewController.m
//  HomeAppliance
//
//  Created by Mac on 17/08/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    deviceDictionary = [[NSMutableDictionary alloc]init];
    
    [self.textFieldPrice setKeyboardType:UIKeyboardTypeNumberPad];
    
    rootDatabaseRef = [[FIRDatabase database] reference];
    
    _textFieldName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _textFieldCompany.autocapitalizationType = UITextAutocapitalizationTypeWords;

    self.buttonSave.layer.borderWidth =2;
    
//    self.buttonSave.layer.cornerRadius =25;

    
    self.buttonSave.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == 100 ) {
        [deviceDictionary setValue:textField.text forKey:@"name"];
    }
    else if (textField.tag == 101 ) {
        [deviceDictionary setValue:textField.text forKey:@"company"];
    }
    else if (textField.tag == 102 ) {
        [deviceDictionary setValue:textField.text forKey:@"price"];
    }
    
    [textField resignFirstResponder];
    
    NSLog(@"%@",deviceDictionary);
    return YES;
}



- (IBAction)buttonSagement:(id)sender {
    
    mySegement = sender;
    
    if (mySegement.selectedSegmentIndex == 0) {
        
        [deviceDictionary setValue:@"TV" forKey:@"type"];
    }
    else if (mySegement.selectedSegmentIndex == 1) {
        
        [deviceDictionary setValue:@"Smartphone" forKey:@"type"];
    }
    else if (mySegement.selectedSegmentIndex == 2) {
        
        [deviceDictionary setValue:@"AC" forKey:@"type"];
    }
    
    NSLog(@"%@",deviceDictionary);

}

- (IBAction)buttonSave:(id)sender {
    
    
    [deviceDictionary setObject:self.textFieldName.text forKey:@"name"];
    [deviceDictionary setObject:self.textFieldCompany.text forKey:@"company"];
    [deviceDictionary setObject:self.textFieldPrice.text forKey:@"price"];
    

    [[[rootDatabaseRef child:@"Devices"] childByAutoId] setValue:deviceDictionary withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        if (error) {
            //alert error
            NSLog(@"%@",error.localizedDescription);
            
        }
        else {
            //alert success
            NSLog(@"Success");
        }
        
    }];


    
    self.textFieldName.text = [NSString stringWithFormat:@""];
    self.textFieldCompany.text = [NSString stringWithFormat:@""];
    self.textFieldPrice.text = [NSString stringWithFormat:@""];

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
