//
//  ViewController.h
//  rotatePopOutfromButton
//
//  Created by David Chang on 6/16/12.
//  Copyright (c) 2012 David Chang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController
{

    UIButton *aButton;
}

@property (strong, nonatomic) IBOutlet UIButton *aButton;


-(IBAction)ClickButton:(id)sender;

@end
