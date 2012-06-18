//
//  ViewController.m
//  rotatePopOutfromButton
//
//  Created by David Chang on 6/16/12.
//  Copyright (c) 2012 David Chang. All rights reserved.
//
#define DEGREES_TO_RADIANS(degrees) ((degrees * M_PI)/ 180.0)
#import "ViewController.h"

@interface ViewController ()
{
    
}
@property (nonatomic, strong) CAAnimationGroup *buttonAnimationGroup;
@property (nonatomic, strong) CALayer *rootLayer;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) UIImage *bigImage;
@property (nonatomic, strong) UIImageView *bigImageView;
@end

@implementation ViewController
@synthesize buttonAnimationGroup, rootLayer, aButton;
@synthesize iconImage, bigImage, bigImageView;
#define Animation_Last_Time 2
- (void)viewDidLoad
{
    [super viewDidLoad];
    

    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)showBigImage
{
    NSLog(@"show big image view called.");
    bigImageView = [[UIImageView alloc] initWithImage:bigImage];
    bigImageView.center = aButton.center;
    [self.view addSubview:bigImageView];
}


-(IBAction)ClickButton:(id)sender;
{
    if (rootLayer == nil)
    {
        rootLayer = [[CALayer alloc] init];
    }
    rootLayer.bounds = aButton.frame;
    rootLayer.position = aButton.center;
    UIColor *greenUIColor = [UIColor greenColor];
    rootLayer.backgroundColor = greenUIColor.CGColor;
    //rootLayer.contents = (id)iconImage.CGImage;
    
    [self.view.layer addSublayer:rootLayer];
    aButton.hidden = YES;
    
    
    iconImage = [[UIImage alloc] init];
    iconImage = [UIImage imageNamed:@"icon.jpeg"];
    bigImage = [[UIImage alloc] init];
    bigImage = [UIImage imageNamed:@"big_image.jpg"];
    
    double scaleX = bigImage.size.width/aButton.frame.size.width;
    float scaleY = bigImage.size.height/aButton.frame.size.height;
    NSLog(@"scale animation x %f, y %f", scaleX, scaleY);
    NSLog(@"to radians %f", DEGREES_TO_RADIANS(180));
    
    
	// Do any additional setup after loading the view, typically from a nib.
    CABasicAnimation * rotateZAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];    
    rotateZAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 1];
	rotateZAnimation.duration = Animation_Last_Time;
	rotateZAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation * scaleXAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleXAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleXAnimation.toValue = [NSNumber numberWithFloat:scaleX];
    scaleXAnimation.duration = Animation_Last_Time;
    scaleXAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation * scaleYAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleYAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleYAnimation.toValue = [NSNumber numberWithFloat:scaleY];
    scaleYAnimation.duration = Animation_Last_Time;
    scaleYAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

 //   [rootLayer addAnimation:scaleAnimation forKey:nil];
 //   [rootLayer addAnimation:scaleAnimation forKey:@"scaleY"];
        [buttonAnimationGroup setAnimations:[NSArray arrayWithObjects:scaleXAnimation, nil]];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.duration = Animation_Last_Time;
	animationGroup.repeatCount = 1;
	[animationGroup setAnimations:[NSArray arrayWithObjects:rotateZAnimation, scaleXAnimation, scaleYAnimation, nil]];
    [rootLayer addAnimation:animationGroup forKey:nil];
    
    [self performSelector:@selector(showBigImage) withObject:nil afterDelay:Animation_Last_Time-0.08];
}
@end
