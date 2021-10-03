//
//  ViewController.m
//  CustomDrawing
//
//  Created by Aoife McManus on 9/29/21.
//

#import "ViewController.h"
#import <UIKit/UIGraphicsRendererSubclass.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize YourView;

struct Spirograph{
    int innerR;
    int outerR;
    int distance;
    CGFloat amount;
};

- (int)getGCD:(int)innerR
joiningArgument2:(int)outerR{
    if(innerR==outerR){
        return innerR;
    }
    if(innerR>outerR){
        return [self getGCD:innerR-outerR joiningArgument2:outerR];
    }
    return [self getGCD:innerR joiningArgument2:outerR-innerR];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage* returnImage=[self getImage];
    UIImageView *dot =[[UIImageView alloc] initWithImage:returnImage];
    [self.view addSubview:dot];
    
}
- (UIImage*)getImage{
    int x=0;
    int y=0;
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:CGSizeMake(200, 200)];
    UIImage *image = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull context) {
        [[UIColor darkGrayColor] setStroke];
        [context strokeRect:renderer.format.bounds];
        [[UIColor colorWithRed:158/255.0 green:215/255.0 blue:245/255.0 alpha:1] setFill];
        [context fillRect:CGRectMake(1, 1, 140, 140)];
        [[UIColor colorWithRed:145/255.0 green:211/255.0 blue:205/255.0 alpha:1] setFill];
        [context fillRect:CGRectMake(60, 60, 140, 140) blendMode:kCGBlendModeMultiply];
        
        [[UIColor colorWithRed:203/255.0 green:222/255.0 blue:116/255.0 alpha:0.6] setFill];
        CGContextFillEllipseInRect(context.CGContext, CGRectMake(60, 60, 140, 140));
      }];
    return image;
}



@end
