//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by 王籽涵 on 2020/7/6.
//  Copyright © 2020 王籽涵. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"

@interface BNRDetailViewController ()

@property(weak, nonatomic) IBOutlet UITextField *nameField;
@property(weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property(weak, nonatomic) IBOutlet UITextField *valueField;
@property(weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation BNRDetailViewController

- (void)setItem:(BNRItem *)item {
    _item = item;
    self.navigationItem.title = _item.itemName;
}


//提前传参
//- (void)loadView {
//    [super loadView];
//    BNRItem *item = self.item;
//    self.nameField.text = [item.itemName copy];
//    self.serialNumberField.text = item.serialNumber;
//    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
//    static NSDateFormatter *dateFormatter = nil;
//    if (!dateFormatter) {
//        dateFormatter = [[NSDateFormatter alloc] init];
//        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
//        dateFormatter.timeStyle = NSDateFormatterNoStyle;
//    }
//    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
//    return;
//}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    BNRItem *item = self.item;
//    self.nameField.text = item.itemName;
//    //
//    NSLog(@"%@", self.nameField.text);
//    self.serialNumberField.text = item.serialNumber;
//    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
//    static NSDateFormatter *dateFormatter = nil;
//    if (!dateFormatter) {
//        dateFormatter = [[NSDateFormatter alloc] init];
//        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
//        dateFormatter.timeStyle = NSDateFormatterNoStyle;
//    }
//    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
//    return;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //手写detailView
    UIView *detailView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [detailView setBackgroundColor:UIColor.whiteColor];
    //4 labels
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 50, 30)];
    name.text = @"Name";
    name.textColor = UIColor.blackColor;
    UILabel *serial = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 50, 30)];
    serial.text = @"Serial";
    serial.textColor = UIColor.blackColor;
    UILabel *value = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 50, 30)];
    value.text = @"Value";
    serial.textColor = UIColor.blackColor;
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(20, 190, UIScreen.mainScreen.bounds.size.width - 40, 30)];
//    date.text = self.dateLabel.text;
    static NSDateFormatter *dateFormatter = nil;
       if (!dateFormatter) {
           dateFormatter = [[NSDateFormatter alloc] init];
           dateFormatter.dateStyle = NSDateFormatterMediumStyle;
           dateFormatter.timeStyle = NSDateFormatterNoStyle;
       }
    date.text = [dateFormatter stringFromDate:self.item.dateCreated];
    date.textColor = UIColor.blackColor;
    [detailView addSubview:name];
    [detailView addSubview:serial];
    [detailView addSubview:value];
    [detailView addSubview:date];
    //3 text field
    UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(80, 100, UIScreen.mainScreen.bounds.size.width - 100, 25)];
    nameField.borderStyle = UITextBorderStyleRoundedRect;
    nameField.text = self.item.itemName;

    nameField.textColor = UIColor.blackColor;
    UITextField *serialField = [[UITextField alloc] initWithFrame:CGRectMake(80, 130, UIScreen.mainScreen.bounds.size.width - 100, 25)];
    serialField.borderStyle = UITextBorderStyleRoundedRect;
    serialField.text = self.item.serialNumber;
    serialField.textColor = UIColor.blackColor;
    UITextField *valueField = [[UITextField alloc] initWithFrame:CGRectMake(80, 160, UIScreen.mainScreen.bounds.size.width - 100, 25)];
    valueField.borderStyle = UITextBorderStyleRoundedRect;
    valueField.text = [NSString stringWithFormat:@"%d", self.item.valueInDollars];
    valueField.textColor = UIColor.blackColor;
    [detailView addSubview:nameField];
    [detailView addSubview:serialField];
    [detailView addSubview:valueField];
    
    self.view = detailView;
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
