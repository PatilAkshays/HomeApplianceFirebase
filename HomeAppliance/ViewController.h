//
//  ViewController.h
//  HomeAppliance
//
//  Created by Mac on 17/08/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import <FirebaseDatabase/FirebaseDatabase.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
{
    
    NSMutableDictionary *deviceDictionary;
    
    FIRDatabaseReference *rootDatabaseRef;
    UISegmentedControl *mySegement;
}
@property (strong, nonatomic) IBOutlet UITextField *textFieldName;
@property (strong, nonatomic) IBOutlet UITextField *textFieldCompany;
@property (strong, nonatomic) IBOutlet UITextField *textFieldPrice;
@property (strong, nonatomic) IBOutlet UIButton *buttonSave;
- (IBAction)buttonSagement:(id)sender;
- (IBAction)buttonSave:(id)sender;


@end

