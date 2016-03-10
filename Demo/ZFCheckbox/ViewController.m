//
//  ViewController.m
//  ZFCheckbox
//
//  Created by Amornchai Kanokpullwad on 30/03/2015.
//
//

#import "ViewController.h"
#import "ZFCheckbox.h"
#import "ZFCheckbox-Swift.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet Checkbox  *checkbox;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.checkbox.animateDuration = 0.5;
//    self.checkbox.lineWidth = 2;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
