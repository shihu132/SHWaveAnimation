//
//  SHWaveView.h
//  SHWaveAnimation
//
//  Created by joyshow on 2018/11/19.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kScreen_Width  [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height

@interface SHWaveView : UIView

@property(nonatomic,strong)UIImageView   *sh_backImageView;
@property(nonatomic,strong)UIImageView   *sh_waveImageView;
@property(nonatomic,strong)CAShapeLayer  *sh_waveLayer;
@property(nonatomic,strong)CADisplayLink *sh_displayLink;

@property(nonatomic,assign)CGFloat sh_waveHeight;
@property(nonatomic,assign)CGFloat sh_maxAmplitude;
@property(nonatomic,assign)CGFloat sh_phase;
@property(nonatomic,assign)CGFloat sh_iftPhase;
@end

NS_ASSUME_NONNULL_END
