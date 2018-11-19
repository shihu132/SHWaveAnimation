//
//  SHWaveView.m
//  SHWaveAnimation
//
//  Created by joyshow on 2018/11/19.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import "SHWaveView.h"

@interface SHWaveView ()

@end

@implementation SHWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    [self addSubview:self.sh_backImageView];
    [self addSubview:self.sh_waveImageView];
    
    int i = arc4random() % 100;
    NSLog(@"=== %d",i);
    self.sh_waveHeight = kScreen_Height /( i / 10);//设置波浪大小
    self.sh_maxAmplitude = self.sh_waveHeight * 0.1f;//振幅
    self.sh_phase = 16;
    self.sh_waveImageView.layer.mask = self.sh_waveLayer;
    
    [self creatDisplayLink];
    [self startLoading];
}

//MAak:-定时器
- (void)creatDisplayLink {

    [_sh_displayLink invalidate];
    _sh_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshWave:)];
    [_sh_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}
//MAak:-定时器
- (void)startLoading {
 
    self.sh_waveLayer.frame = CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height);
    CGPoint position = self.sh_waveLayer.position;
    position.y = position.y - kScreen_Height;
    [self.sh_waveLayer addAnimation:[self creatBasicAnimationFromValue:[NSValue valueWithCGPoint:self.sh_waveLayer.position] toValue:[NSValue valueWithCGPoint:position] duration:13.0f] forKey:@"positionWave"];
    
}

#pragma mark - UIBezierPath
- (void)refreshWave:(CADisplayLink *)displayLink {
    
    self.sh_iftPhase += self.sh_phase;
    UIBezierPath * path = [UIBezierPath bezierPath];
    CGFloat endX = 0;
    for (CGFloat x=0; x<kScreen_Width+1; x += 1) {
        endX = x;
        CGFloat y = self.sh_maxAmplitude * sinf(2*M_PI/kScreen_Width * x + self.sh_iftPhase * M_PI/1080);
        if (x == 0) {
            [path moveToPoint:CGPointMake(x, y)];
        } else {
            [path addLineToPoint:CGPointMake(x, y)];
        }
    }
    CGFloat endY = CGRectGetHeight(self.sh_backImageView.bounds);
    [path addLineToPoint:CGPointMake(endX, endY)];
    [path addLineToPoint:CGPointMake(0, endY)];
    self.sh_waveLayer.path = path.CGPath;
    
}

#pragma mark - 动画
- (CABasicAnimation *)creatBasicAnimationFromValue:(id)fromValue toValue:(id)toValue duration:(CFTimeInterval)duration {
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.duration = duration;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    return animation;
}



#pragma mark - UI
- (UIImageView *)sh_backImageView {
    if (!_sh_backImageView) {
        _sh_backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sh_backImageView_image"]];
        _sh_backImageView.frame = self.bounds;
    }
    return _sh_backImageView;
}

- (UIImageView *)sh_waveImageView {
    if (!_sh_waveImageView) {
        _sh_waveImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sh_waveImageView_image"]];
        _sh_waveImageView.frame = self.bounds;
    }
    return _sh_waveImageView;
}

- (CAShapeLayer *)sh_waveLayer {
    if (!_sh_waveLayer) {
        _sh_waveLayer = [CAShapeLayer layer];
    }
    return _sh_waveLayer;
}

- (void)dealloc {
    [_sh_displayLink invalidate];
    [_sh_waveLayer removeAllAnimations];
    _sh_waveLayer.path = nil;
}

@end
