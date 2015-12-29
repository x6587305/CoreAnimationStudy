//
//  CAMediaTimingVC.m
//  ZJKitDemo
//
//  Created by xiezhaojun on 15/12/28.
//  Copyright © 2015年 xiezhaojun. All rights reserved.
//

#import "CAMediaTimingVC.h"
/**
 *  CAMediaTiming Protocol
 这个协议定义着一系列的属性控制着动画时间
 //@property CFTimeInterval beginTime; 开始时间 默认0
 //@property CFTimeInterval duration; 动画时长
 //@property float speed; 动画的速度。默认是1
//@property CFTimeInterval timeOffset; 偏移量 t = (tp - begin) * speed + offset.用来speed = 0 做动画暂停。用offset 实现暂停的状态。 默认是0
//@property float repeatCount; 重复的次数
 
//@property CFTimeInterval repeatDuration; 重复的时间
 //@property BOOL autoreverses;/* When true, the object plays backwards after playing forwards. Defaults
 * to NO. */

//@property(copy) NSString *fillMode; 当动画执行结束之后执行的动作。`backwards', `forwards', `both' and `removed'. 默认为 removed。

/*
 1.time
 layer 本身的事件存在一个Hierarchical Time 的概念。
 calayer 的duration 和 repeatCount/repeatDuration属性并不会影响到子动画
 但是beginTime, timeOffset, 和 speed 却影响到子动画
 在 core animation中使用一个全局时间 mach time
 CFTimeInterval time = CACurrentMediaTime();
 这个值在不同的设备中是不同的。（重启设备之后会清零。因为他的表示的就是这个设备上次reboot到现在的时间）主要是处理相对时间的。
 当设备休眠之后 这个时间也会休眠。所以对于长时间任务使用这个事件很有问题。
 
 而每一个子layer 都有自己的时间的概念。而因为 beginTime, timeOffset和 speed的不同 导致跟全局时间不同。需要方法转换
 - (CFTimeInterval)convertTime:(CFTimeInterval)t fromLayer:(CALayer *)l;
 - (CFTimeInterval)convertTime:(CFTimeInterval)t toLayer:(CALayer *)l;
 当在多个layers 中拥有不同beginTime, timeOffset和 speed 并且你需要同步动画的时候。需要处理好这个转换
 2 pause
 动画一旦加入到layer上面去将没法改变。
 暂停动画 首先要明白 我们移除动画。然后设置model layer 为 presentationLayer 的情况也能实现动画暂停但是不利于 动画回复。
 可以设置speed 为0 这样就暂停了动画。再把model设置一下就ok了。一开始尝试的时候。我是直接设置speed为0.然后设置model layer的属性等于 presentationLayer 的属性。可是由于speed 属性的影响是异步的。导致不停的暂停 重新开始。会发现整个layer都发生不可知的变化。这样并不是我所希望的。
 然后使用了timeOffset 跟 beginTime 协同操作 这样效果好很多。
 
 当speed 小于1 的时候。都会显示model layer的情况。
 */

@interface CAMediaTimingVC ()
@property(nonatomic,strong) CALayer *shipLayer;
@property(nonatomic,strong)UIBezierPath *bezierPath;
@property(nonatomic,strong)UIButton *startOrPauseButton;
@end

@implementation CAMediaTimingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1  setTitle:@"1s后开始动画3次" forState:UIControlStateNormal];
    [button1  setBackgroundColor:[UIColor blueColor]];
    button1 .frame = CGRectMake(0, 400, 200, 50);
    [button1  addTarget:self action:@selector(begin) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:button1 ];
    
    self.startOrPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.startOrPauseButton  setTitle:@"暂停" forState:UIControlStateNormal];
    [self.startOrPauseButton  setBackgroundColor:[UIColor blueColor]];
    self.startOrPauseButton .frame = CGRectMake(0, 450, 200, 50);
    [self.startOrPauseButton  addTarget:self action:@selector(pauseOrStart) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.startOrPauseButton ];
    
    
    
    
    //create a path
    self.bezierPath = [[UIBezierPath alloc] init];
    [self.bezierPath moveToPoint:CGPointMake(0, 150)];
    [self.bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = self.bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    
    //add the ship
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 64, 64);
    self.shipLayer.position = CGPointMake(0, 150);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed:@"3"].CGImage;
    UIPanGestureRecognizer *ges = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:ges];
    [self.view.layer addSublayer:self.shipLayer];
}

-(void)begin{
     CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.duration = 1;
    /**
      下面的暂停等功能会影响这个shipLayer 的本地时间 要转换时间
     */
//    animation.beginTime = CACurrentMediaTime() +1;
    animation.beginTime =   [ self.view.layer convertTime:CACurrentMediaTime() +1 toLayer:self.shipLayer];
    animation.repeatCount =3;
//    animation.repeatDuration = INFINITY;// 特别大的一个值 表示无限循环;
    animation.keyPath = @"position";
    animation.path = self.bezierPath.CGPath;
    /*
     可以设置fillMode 决定动画结束完成之后的 layer的展示。如果设置成kCAFillModeForwards 最终的状态就会留在界面上。需要注意。要使用这种功能。需要将removedOnCompletion 设置为NO。
     当然这样也有不好的地方 animation 会一直留在layer上面。浪费很大的性能。所以addAnimation 方法需要传入key 以便于不需要的时候移除这个 animation。
     */
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;//kCAFillModeRemoved;//kCAFillModeBoth;//kCAFillModeBackwards;//kCAFillModeForwards;
    [self.shipLayer addAnimation:animation forKey:@"shipLayerAnimation"];
}


- (void)pan:(UIPanGestureRecognizer *)pan{
    CGFloat x = [pan translationInView:self.view].x;
    x /= 320.0;
    
    CFTimeInterval timeOffset = self.shipLayer.timeOffset;
    timeOffset = timeOffset + 10* x;
    //MIN(9.999, MAX(10.0, timeOffset - x));
    
    self.shipLayer.timeOffset = timeOffset;
    [pan setTranslation:CGPointZero inView:self.view];
}
-(void)pauseOrStart{
    static bool ispause = NO;
    if(ispause){
        
        CFTimeInterval pausedTime = [self.shipLayer timeOffset];
        self.shipLayer.speed = 1.0;
        self.shipLayer.timeOffset = 0.0;
        self.shipLayer.beginTime = 0.0;
        CFTimeInterval timeSincePause = [self.shipLayer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        self.shipLayer.beginTime = timeSincePause;
        [self.startOrPauseButton setTitle:@"暂停（这时可以滑动屏幕调整位置）" forState:UIControlStateNormal];
        
    }else{
        CFTimeInterval pausedTime = [self.shipLayer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.shipLayer.speed = 0.0;
        self.shipLayer.timeOffset = pausedTime;
        
        [self.startOrPauseButton setTitle:@"开始（这时可以滑动屏幕调整位置）" forState:UIControlStateNormal];

    }
    
    
    ispause = !ispause;
}
- (void)animationDidStart:(CABasicAnimation *)anim finished:(BOOL)flag {
    //set the backgroundColor property to match animation toValue
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    self.baseAnimationLayer3.backgroundColor = (__bridge CGColorRef)anim.toValue;
//    [CATransaction commit];
}
- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    //set the backgroundColor property to match animation toValue
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    CALayer *layer = [anim valueForKey:@"baseAnimationLayer"];
//    layer.backgroundColor = (__bridge CGColorRef)anim.toValue;
//    [CATransaction commit];
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

@end
