//
//  ExplicitAnimationVC.m
//  ZJKitDemo
//
//  Created by xiezhaojun on 15/12/25.
//  Copyright © 2015年 xiezhaojun. All rights reserved.
//

#import "ExplicitAnimationVC.h"
/**
 *   
 CABasicAnimation 主要有这个三个值。看名字也能明白作用。需要注意的是  动画的类型是 通过keyPath 来设置的. 在某种程度上 跟 implicit animations. 里面默认的actions 字典有点像的
 id fromValue  开始的值
 id toValue   结束的值
 id byValue  变化的值
 这三个值并不需要都提供 甚至不应该都提供。因为会冲突。获取原则CABasicAnimation文档里面有描述
 */
@interface ExplicitAnimationVC()
@property(nonatomic,strong) CALayer *baseAnimationLayer;
@property(nonatomic,strong) CALayer *baseAnimationLayer2;
@property(nonatomic,strong) CALayer *baseAnimationLayer3;
@property(nonatomic,strong) CALayer *keyFrameAnimationLayer1;
@property(nonatomic,strong) CALayer *keyFrameAnimationLayer2;
@property(nonatomic,strong) CALayer *keyFrameAnimationLayer3;

@property(nonatomic,strong) CALayer *groupAnimationLayer;
@property(nonatomic,strong) UIImageView *transitionsAnimationView;
@end
@implementation ExplicitAnimationVC
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.baseAnimationLayer = [CALayer layer];
    self.baseAnimationLayer.backgroundColor = [UIColor whiteColor].CGColor;
    self.baseAnimationLayer.frame = CGRectMake(0, 0, 95, 95);
    [self.view.layer addSublayer:self.baseAnimationLayer];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1  setTitle:@"base " forState:UIControlStateNormal];
    [button1  setBackgroundColor:[UIColor blueColor]];
    button1 .frame = CGRectMake(0, 100, 95, 45);
    [button1  addTarget:self action:@selector(baseAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1 ];
    
    
    self.baseAnimationLayer2 = [CALayer layer];
    self.baseAnimationLayer2.backgroundColor = [UIColor whiteColor].CGColor;
    self.baseAnimationLayer2.frame = CGRectMake(100, 0, 95, 95);
    [self.view.layer addSublayer:self.baseAnimationLayer2];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2  setTitle:@"base2" forState:UIControlStateNormal];
    [button2  setBackgroundColor:[UIColor blueColor]];
    button2 .frame = CGRectMake(100, 100, 95, 45);
    [button2  addTarget:self action:@selector(baseAnimation2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2 ];
    
    
    self.baseAnimationLayer3 = [CALayer layer];
    self.baseAnimationLayer3.backgroundColor = [UIColor whiteColor].CGColor;
    self.baseAnimationLayer3.frame = CGRectMake(200, 0, 95, 95);
    [self.view.layer addSublayer:self.baseAnimationLayer3];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3  setTitle:@"base 3" forState:UIControlStateNormal];
    [button3  setBackgroundColor:[UIColor blueColor]];
    button3 .frame =  CGRectMake(200, 100, 95, 45);
    [button3  addTarget:self action:@selector(baseAnimation3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3 ];
    
    
    self.keyFrameAnimationLayer1 = [CALayer layer];
    self.keyFrameAnimationLayer1.backgroundColor = [UIColor whiteColor].CGColor;
    self.keyFrameAnimationLayer1.frame = CGRectMake(0, 150, 95, 95);
    [self.view.layer addSublayer:self.keyFrameAnimationLayer1];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4  setTitle:@"keyframe1" forState:UIControlStateNormal];
    [button4  setBackgroundColor:[UIColor blueColor]];
    button4 .frame = CGRectMake(0, 250, 95, 45);
    [button4  addTarget:self action:@selector(keyFrameAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4 ];
    
    self.keyFrameAnimationLayer2 = [CALayer layer];
    self.keyFrameAnimationLayer2.backgroundColor = [UIColor whiteColor].CGColor;
    self.keyFrameAnimationLayer2.frame = CGRectMake(100, 150, 95, 95);
    [self.view.layer addSublayer:self.keyFrameAnimationLayer2];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button5  setTitle:@"keyframe2" forState:UIControlStateNormal];
    [button5  setBackgroundColor:[UIColor blueColor]];
    button5 .frame = CGRectMake(100, 250, 95, 45);
    [button5  addTarget:self action:@selector(keyFrameAnimation2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5 ];
    
    
    self.keyFrameAnimationLayer3 = [CALayer layer];
    self.keyFrameAnimationLayer3.backgroundColor = [UIColor whiteColor].CGColor;
    self.keyFrameAnimationLayer3.frame = CGRectMake(200, 150, 95, 95);
    [self.view.layer addSublayer:self.keyFrameAnimationLayer3];
    
    UIButton *button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button6  setTitle:@"keyframe3" forState:UIControlStateNormal];
    [button6  setBackgroundColor:[UIColor blueColor]];
    button6 .frame = CGRectMake(200, 250, 95, 45);
    [button6  addTarget:self action:@selector(keyFrameAnimation3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button6 ];
    
    
    
    
    self.groupAnimationLayer = [CALayer layer];
    self.groupAnimationLayer.backgroundColor = [UIColor whiteColor].CGColor;
    self.groupAnimationLayer.frame = CGRectMake(0, 300, 95, 95);
    [self.view.layer addSublayer:self.groupAnimationLayer];
    
    UIButton *button7 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button7  setTitle:@"group" forState:UIControlStateNormal];
    [button7  setBackgroundColor:[UIColor blueColor]];
    button7 .frame = CGRectMake(0, 400, 95, 45);
    [button7  addTarget:self action:@selector(groupAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button7 ];
    
    
    
    self.transitionsAnimationView = [[UIImageView alloc]init];
    self.transitionsAnimationView.backgroundColor = [UIColor whiteColor];
    self.transitionsAnimationView.frame = CGRectMake(100, 300, 95, 95);
    [self.view addSubview:self.transitionsAnimationView];
    
    UIButton *button8 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button8  setTitle:@"transition1" forState:UIControlStateNormal];
    [button8  setBackgroundColor:[UIColor blueColor]];
    button8 .frame = CGRectMake(100, 400, 95, 45);
    [button8  addTarget:self action:@selector(transitionsAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button8 ];
    
    UIButton *button9 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button9  setTitle:@"transition2" forState:UIControlStateNormal];
    [button9  setBackgroundColor:[UIColor blueColor]];
    button9 .frame = CGRectMake(100, 450, 95, 45);
    [button9  addTarget:self action:@selector(transitionsAnimation2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button9 ];
    
    
    UIButton *button10 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button10  setTitle:@"transition3" forState:UIControlStateNormal];
    [button10  setBackgroundColor:[UIColor blueColor]];
    button10 .frame = CGRectMake(100, 500, 95, 45);
    [button10  addTarget:self action:@selector(transitionsAnimation3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button10 ];
    
//    groupAnimationLayer

}
/**
  
 *  这里你会发现 动画完成之后 回复到了model layer 的结果。因为我们只是做了动画。并没有改变model layer。
 而 Implicit Animations没有这样的问题 是因为 系统帮我们做了这样的事情。
 

 */
-(void)baseAnimation{
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //create a basic animation
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.duration = 2;
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)color.CGColor;
    [self.baseAnimationLayer addAnimation:animation forKey:nil];
}



-(void)baseAnimation2{
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //create a basic animation
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.duration = 2;
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)color.CGColor;
    
    //这下面通过动画开始前先改变了model layer
    //这是学习测试写的。真正的使用 还是要用presentationLayer 来作为fromValue 因为可能上一个动画没完。所以下面那个方法才是比较好的
    //不过不能理解的是 如果不获取一下 presentationLayer 会闪一下。即使这个layer 并没使用，而且也排除是上一个动画进行过程中切换的。（实际上如果都闪一下 我反而能理解了。为什么会获取一下presentationLayer 反而不闪了呢。毕竟我是先改变的model layer 再做的动画 。 交换位置就没有这个问题了。放在这里 只是疑惑 获取presentationLayer 之后为什么会不闪了  ）
    CALayer *layer =self.baseAnimationLayer.presentationLayer;
    //(self.baseAnimationLayer.presentationLayer ?:self.baseAnimationLayer);
    //    animation.fromValue =(__bridge id)layer.backgroundColor;
    //    NSLog(@"%@",(__bridge id)self.baseAnimationLayer.backgroundColor);
    //    NSLog(@"%@",(__bridge id)layer.backgroundColor);
    
    animation.fromValue = (__bridge id)self.baseAnimationLayer2.backgroundColor;
    
    //将这一段代码放到 添加动画的下面即使不获取presentationLayer 也不会闪了。
    [CATransaction begin];
    //因为是自己添加的layer 是有Implicit Animations 动画的
    [CATransaction setDisableActions:YES];
    self.baseAnimationLayer2.backgroundColor = color.CGColor;
    [CATransaction commit];
    
    //apply animation to layer
    [self.baseAnimationLayer2 addAnimation:animation forKey:nil];
    
    /**
     *  用下面的方法 比较合适
     */
    //    [self applyBasicAnimation:animation toLayer:self.baseAnimationLayer];
}
- (void)applyBasicAnimation:(CABasicAnimation *)animation toLayer:(CALayer *)layer{
    //set the from value (using presentation layer if available)
    animation.fromValue = [layer.presentationLayer ?: layer valueForKeyPath:animation.keyPath];
    //update the property in advance
    //note: this approach will only work if toValue != nil
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [layer setValue:animation.toValue forKeyPath:animation.keyPath];
    [CATransaction commit];
    //apply animation to layer
    [layer addAnimation:animation forKey:nil];
}



/**
 *  使用代理 来实现 是个很好的悬着
 CABasicAnimation 存在一个特殊的delegate CAAnimationDelegate 来处理动画完成后的回调
 
 --CAAnimationDelegate 并不真实的存在于某个头文件里面 在CAAnimation 里面可以看到他(一个nsobject 的分类)的方法
 
 - (void)animationDidStart:(CAAnimation *)anim;
 - (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
 通过监听动作完成之后在修改该model layer的值。并且不加动画来实现同样的效果。
 貌似会闪一下。。我们的产品 肯定又要叫了 不让闪！！！！
 原因其实很简单 完成的回调方法只保证是完成之后调用。但是并不是毫无间隙的调用。在调用完成回调之前。颜色当然会恢复到原来的颜色s
 
另外 CABasicAnimation 是kvc 的。可以setvalue 保存一定的状态。在代理方法里面 valueForKey 获取出来。比如
 */
-(void)baseAnimation3{
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //create a basic animation
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.duration = 2;
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)color.CGColor;
    
    animation.delegate = self;
    [animation setValue:self.baseAnimationLayer3 forKey:@"baseAnimationLayer"];
    //apply animation to layer
    [self.baseAnimationLayer3 addAnimation:animation forKey:nil];
    

}
- (void)animationDidStart:(CABasicAnimation *)anim finished:(BOOL)flag {
    //set the backgroundColor property to match animation toValue
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.baseAnimationLayer3.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}
- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    //set the backgroundColor property to match animation toValue
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CALayer *layer = [anim valueForKey:@"baseAnimationLayer"];
    layer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}
-(void)keyFrameAnimation{
    //通过CAKeyframeAnimation 创建整个变化过程
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor, (__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor greenColor].CGColor, (__bridge id)[UIColor blueColor].CGColor ];
    //apply animation to layer
    [self.keyFrameAnimationLayer1 addAnimation:animation forKey:nil];
}


-(void)keyFrameAnimation2{

    
    //
    //可以设置动画的path
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)]; [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    //add the shipfinish
//    CALayer *shipLayer = [CALayer layer];
//    shipLayer.frame = CGRectMake(0, 0, 64, 64);
//    shipLayer.position = CGPointMake(0, 150);
//    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"3"].CGImage;
//    [self.view.layer addSublayer:shipLayer];
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = bezierPath.CGPath;
    //设置这个 就可以根据路径自动改变方向了。
    animation.rotationMode = kCAAnimationRotateAuto;
    [self.keyFrameAnimationLayer2 addAnimation:animation forKey:nil];
}


//    //Virtual Properties旋转一圈这样的需求 如果直接设置M_PI *2 毫无疑问没有效果 因为 M_PI*2 跟 0 是一样你的。
//    //这里就也需需要使用复杂的CAKeyframeAnimation 幸运的是 我们也可以使用 Virtual Properties。因为animation.keyPath 是基于key的。而有"transform.rotation"这个key 是负责旋转
//    //这里的keypath 并不是传统上面KVC的 key 因为transform并不是一个 oc对象。而是一个结构体
-(void)keyFrameAnimation3{
    
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.duration = 2.0;
//    animation.keyPath = @"transform";
//    animation.values = @[ [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1)], [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI/2, 0, 0, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI*1.5, 0, 0, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI*2, 0, 0, 1)]];
//    [self.keyFrameAnimationLayer3 addAnimation:animation forKey:nil];
    
    //这个是base animation 的 可是主要需要跟key farme 做对比 所以放在这里了
    /* 主要有下面那些key
     rotation.x
     Set to an NSNumber object whose value is the rotation, in radians, in the x axis.
     rotation.y
     Set to an NSNumber object whose value is the rotation, in radians, in the y axis.
     rotation.z
     Set to an NSNumber object whose value is the rotation, in radians, in the z axis.
     rotation
     Set to an NSNumber object whose value is the rotation, in radians, in the z axis. This field is identical to setting the rotation.z field.
     scale.x
     Set to an NSNumber object whose value is the scale factor for the x axis.
     scale.y
     Set to an NSNumber object whose value is the scale factor for the y axis.
     scale.z
     Set to an NSNumber object whose value is the scale factor for the z axis.
     scale
     Set to an NSNumber object whose value is the average of all three scale factors.
     translation.x
     Set to an NSNumber object whose value is the translation factor along the x axis.
     translation.y
     Set to an NSNumber object whose value is the translation factor along the y axis.
     translation.z
     Set to an NSNumber object whose value is the translation factor along the z axis.
     translation
     Set to an NSValue object containing an NSSize or CGSize data type. That data type indicates the amount to translate in the x and y axis.
     */
    CABasicAnimation *animation2 = [CABasicAnimation animation];
        //如果是@"transform.rotation" 值就是@(M_PI * 2) 如果是 @"transform“ 就应该是[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)] 但是如果是M_PI *2 就是解决不了的了 必然需要  @"transform.rotation";
    animation2.duration = 2.0;
//    animation2.keyPath = @"transform";
//    animation2.byValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    animation2.keyPath = @"transform.rotation";
    animation2.byValue = @(M_PI * 2);
    [self.keyFrameAnimationLayer3 addAnimation:animation2 forKey:nil];
}




/*无论是 base animation 还是 keyframe animation 都是针对一个属性 对于多个属性的变化 需要
 CAAnimationGroup
 */
-(void)groupAnimation{
        UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
        [bezierPath moveToPoint:CGPointMake(0, 150)];
        [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
        //draw the path using a CAShapeLayer
        CAShapeLayer *pathLayer = [CAShapeLayer layer];
        pathLayer.path = bezierPath.CGPath;
        pathLayer.fillColor = [UIColor clearColor].CGColor;
        pathLayer.strokeColor = [UIColor redColor].CGColor;
        pathLayer.lineWidth = 3.0f;
        [self.view.layer addSublayer:pathLayer];
        //add a colored layer

        //create the position animation
        CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
        animation1.keyPath = @"position";
        animation1.path = bezierPath.CGPath;
        animation1.rotationMode = kCAAnimationRotateAuto;
        //create the color animation
        CABasicAnimation *animation2 = [CABasicAnimation animation];
        animation2.keyPath = @"backgroundColor";
        animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
        //create group animation CAAnimationGroup 也是 CAAnimation 的子类
        CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
        groupAnimation.animations = @[animation1, animation2];
        groupAnimation.duration = 4.0;
        //add the animation to the color layer
        [self.groupAnimationLayer addAnimation:groupAnimation forKey:nil];
}

/**
 *   类似property animate都是针对某些属性进行变化 有时候需要的动画没法用 property animate表示。比如需要切换图片什么的。
 这时候就需要转场动画的概念 .transitions 不像 property animate那样是在两个值之间变化。而是定义一系列行为 让老的layer消失 新的layer出现
 CATransition 类处理transitions
 catranstion 有个type 属性 定义如下
 kCATransitionFade
 kCATransitionMoveIn //新的移动进来 旧的消失
 kCATransitionPush //两个一起动
 kCATransitionReveal//旧的移走 新的出现
 还有个 subtype 定义方向
 kCATransitionFromRight
 kCATransitionFromLeft
 kCATransitionFromTop
 kCATransitionFromBottom
 
 // Custom Transitions
 // CATransition 的动画就那么几种 有很大的限制。而
 // UIView +transitionFromView:toView:duration:options:completion:
 // 和+transitionWithView:duration:options:animations:
 // 又有很大的不同
 // UIViewAnimationOptionTransitionFlipFromLeft //翻转
 // UIViewAnimationOptionTransitionFlipFromRight
 // UIViewAnimationOptionTransitionCurlUp //向上翻页
 // UIViewAnimationOptionTransitionCurlDown
 // UIViewAnimationOptionTransitionCrossDissolve //渐变
 // UIViewAnimationOptionTransitionFlipFromTop
 // UIViewAnimationOptionTransitionFlipFromBottom
 
 */
-(void)transitionsAnimation{
    UIImage *image1 = [UIImage imageNamed:@"1.jpg"];
    
    NSArray *images = @[image1, [UIImage imageNamed:@"2.jpg"],
                        [UIImage imageNamed:@"3.jpg"], [UIImage imageNamed:@"4.jpg"]];
    static NSUInteger index = 0;
    index = (index + 1) % [images count];
    UIImage *image = images[index];
    
    /**
     *  对于自己创建的layer 系统本来就有 Implicit Transitions 动画。当然backing layer 默认是disable 的。
     */
//    self.transitionsAnimationView.layer.contents = (__bridge id _Nullable)(image.CGImage);
//    self.groupAnimationLayer.contents = (__bridge id _Nullable)(image.CGImage);
//    return;
    
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromRight;
    //apply transition to imageview backing layer
    [self.transitionsAnimationView.layer addAnimation:transition forKey:nil];

    self.transitionsAnimationView.layer.contents = (__bridge id _Nullable)(image.CGImage);
    


    /**
     Custom Transitions
     CATransition 的动画就那么几种 有很大的限制。而
     UIView +transitionFromView:toView:duration:options:completion:
     和+transitionWithView:duration:options:animations:
     又有很大的不同
     UIViewAnimationOptionTransitionFlipFromLeft //翻转
     UIViewAnimationOptionTransitionFlipFromRight
     UIViewAnimationOptionTransitionCurlUp //向上翻页
     UIViewAnimationOptionTransitionCurlDown
     UIViewAnimationOptionTransitionCrossDissolve //渐变
     UIViewAnimationOptionTransitionFlipFromTop
     UIViewAnimationOptionTransitionFlipFromBottom
     
     */
    //
    
    //    [UIView transitionWithView:self.imageView duration:1.0
    //                       options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
    //                           //cycle to next image
    //            UIImage *currentImage = self.imageView.image;
    //            NSUInteger index = [self.images indexOfObject:currentImage];
    //            index = (index + 1) % [self.images count];
    //            self.imageView.image = self.images[index];
    //    } completion:NULL];
    
    
    
}
/*
 因为Transitions 并不是针对layer 的某个属性的动画。所以我们可以不管任何变化 都可以做转场动画的效果
 */

-(void)transitionsAnimation2{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromRight;
    transition.duration = 2;
    [self.view.layer addAnimation:transition forKey:nil];
//    UIViewController *vc = [[UIViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:NO];
    
 
}

/**
 *  我们可以利用 layer 的renderInContext 属性绘制出一张图片。
 这样就可以用常规的 各种 动画来实现转场动画
 */
-(void)transitionsAnimation3{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    //insert snapshot view in front of this one
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = self.view.bounds;
    [self.view addSubview:coverView];
    //update the view (we'll simply randomize the layer background color)
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    //perform animation (anything you like)
    [UIView animateWithDuration:1.0 animations:^{
        //scale, rotate and fade the view
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2); coverView.transform = transform;
        coverView.alpha = 0.0;
    } completion:^(BOOL finished){
        //remove the cover view now we're finished with it
        [coverView removeFromSuperview]; }];
}

 

@end
