//
//  ViewController.m
//  CustomDrawing
//
//  Created by Aoife McManus on 9/29/21.
//

#import "ViewController.h"
#import <UIKit/UIGraphicsRendererSubclass.h>
#import <CoreGraphics/CGPath.h>

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

- (CGMutablePathRef)getPath:(struct Spirograph)spirograph{
    int div=[self getGCD:spirograph.innerR joiningArgument2:spirograph.outerR];
    CGFloat outerR=(CGFloat)spirograph.outerR;
    CGFloat innerR=(CGFloat)spirograph.innerR;
    CGFloat distance=(CGFloat)spirograph.distance;
    CGFloat difference=innerR-outerR;
    CGFloat end=ceilf(2*M_PI*outerR/(CGFloat)div*spirograph.amount);
    CGMutablePathRef ref=CGPathCreateMutable();
    for(float i=0; i<end; i+=0.01){
        CGFloat x=difference*cos(i)+distance*cos(difference/outerR*i);
        CGFloat y=difference*sin(i)+distance*sin(difference/outerR*i);
        if(i==0) CGPathMoveToPoint(ref, NULL, x, y);
        else{
            CGPathAddLineToPoint(ref, NULL, x, y);
        }
    }
    return ref;
}

- (UIImageView*)getView:(CGMutablePathRef)path{
    CAShapeLayer* shapeLayer=[[CAShapeLayer alloc]init];
    shapeLayer.path=path;
    UIColor* purp=[UIColor colorWithRed: 0.69 green: 0.41 blue: 0.94 alpha: 1.00];
    UIColor* white=[UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1.00];

    shapeLayer.strokeColor=purp.CGColor;
    shapeLayer.fillColor=white.CGColor;

    shapeLayer.lineWidth=1;
    //shapeLayer.position=CGPointMake(10, 10);
    UIImageView* view=[[UIImageView alloc]initWithFrame:CGRectMake(210, 400, 300, 300)];
    [view.layer insertSublayer:shapeLayer atIndex:0];
    return view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*UIImage* returnImage=[self getImage];
    UIImageView *dot =[[UIImageView alloc] initWithImage:returnImage];
    [self.view addSubview:dot];*/
    struct Spirograph spirograph;
    spirograph.innerR=75.0;
    spirograph.outerR=125.0;
    spirograph.distance=25.0;
    spirograph.amount=1.0;
    CGMutablePathRef ref=[self getPath:spirograph];
    UIImageView* subView=[self getView:ref];
    [self.view addSubview:subView];
    [UIView animateWithDuration:0.5f animations:^{subView.frame = CGRectOffset(subView.frame, 0, 50);
    }];
    
}

- (UIImage*)getImage{
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
