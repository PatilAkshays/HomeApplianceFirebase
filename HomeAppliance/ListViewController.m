//
//  ListViewController.m
//  HomeAppliance
//
//  Created by Mac on 17/08/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#import "ListViewController.h"
#import "DeviceTableViewCell.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    allDeviceDictionary = [[NSMutableArray alloc]init];
    rootDatabaseRef = [[FIRDatabase database]reference];
    
    [self fetchAllDevices];
    
    self.buttonDismiss.layer.borderWidth =2;
    
    self.buttonDismiss.layer.cornerRadius = 10;
    
    
    self.buttonDismiss.layer.borderColor = [UIColor brownColor].CGColor;
    
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

-(void)fetchAllDevices {
    

    [[rootDatabaseRef child:@"Devices"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
                NSLog(@"%@",snapshot.value);
        
        NSDictionary *allDevices = snapshot.value;
        
        for (NSString *key in allDevices.allKeys) {
            
            NSDictionary *device = [allDevices valueForKey:key];
            //            NSLog(@"%@",device);
            [allDeviceDictionary addObject:device];
        }
        
        [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:YES];
        
    }];

}

-(void)updateUI {
    
    [self.listTableView reloadData];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return allDeviceDictionary.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Device_Cell"];
    
    
    NSDictionary *deviceDictionary = [allDeviceDictionary objectAtIndex:indexPath.row];
    
    //    NSLog(@"%@",deviceDictionary);
    
    cell.labelName.text = [deviceDictionary valueForKey:@"name"];
    cell.labelPrice.text = [deviceDictionary valueForKey:@"price"];
        cell.labelCompany.text = [[[deviceDictionary valueForKey:@"company"] stringByAppendingString:@""]stringByAppendingString:[deviceDictionary valueForKey:@"type"]];
    return cell;
    
}



- (IBAction)segment:(id)sender {
}
@end
