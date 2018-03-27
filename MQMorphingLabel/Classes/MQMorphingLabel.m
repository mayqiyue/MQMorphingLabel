//
//  MQMorphingLabel.m
//  Xoding
//
//  Created by Mayqiyue on 27/03/2018.
//  Copyright © 2018 mayqiyue. All rights reserved.
//

#import "MQMorphingLabel.h"
#import "MQWeakProxy.h"

@interface MQMorphingLabel () {
    NSUInteger startLoc, endLoc;
    NSUInteger tickLoc;
}

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSString *normlString;
@property (nonatomic, strong) NSAttributedString *attributedString;
@property (nonatomic, copy) MQMAnimationCompletionBlock completionBlock;


@property (nonatomic, assign) BOOL isAnimationPlaying;

@end

@implementation MQMorphingLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.animationSpeed = 0.1;
}

- (void)setMorphingText:(NSString *)string
{
    self.normlString = string;
}

- (void)setMorphingAttributedText:(NSAttributedString *)attributedString
{
    self.attributedString = attributedString;
}

- (void)playFromProgress:(CGFloat)fromProgress
              toProgress:(CGFloat)toProgress
          withCompletion:(nullable MQMAnimationCompletionBlock)completion
{
    NSAttributedString *attrStr = nil;
    if (self.attributedString.length > 0) {
        attrStr = self.attributedString;
    }
    else if (self.normlString.length > 0) {
        attrStr = [[NSAttributedString alloc] initWithString:self.normlString
                                                  attributes:@{NSFontAttributeName: self.font?:[UIFont systemFontOfSize:12],
                                                               NSForegroundColorAttributeName: self.textColor?:[UIColor blackColor]}];
    }
    if (!attrStr || attrStr.string.length == 0) {
        return;
    }
    fromProgress = MIN(MAX(0, fromProgress), 1);
    toProgress = MIN(MAX(0, toProgress), 1);
    
    if (fromProgress > toProgress) {
        return;
    }
    
    if (self.isAnimationPlaying) {
        if (self.completionBlock) {
            self.completionBlock(false);
            self.completionBlock = nil;
        }
    }
    [self stop];
    
    self.isAnimationPlaying = true;
    self.attributedString = attrStr;
    self.completionBlock = completion;
    
    startLoc = (NSInteger)(attrStr.length * fromProgress);
    endLoc = (NSInteger)(attrStr.length * toProgress);
    tickLoc = startLoc;
    
    MQWeakProxy *proxy = [MQWeakProxy proxyWithTarget:self];
    self.timer = [NSTimer timerWithTimeInterval:self.animationSpeed target:proxy selector:@selector(tick:) userInfo:nil repeats:true];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)playWithCompletion:(nullable MQMAnimationCompletionBlock)completion
{
    [self playFromProgress:0.0 toProgress:1.0 withCompletion:completion];
}

- (void)play
{
    [self playFromProgress:0.0 toProgress:1.0 withCompletion:nil];
}

- (void)pause
{
}

- (void)stop
{
    self.isAnimationPlaying = false;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)tick:(NSTimer *)timer
{
    if (tickLoc <= self.attributedString.length && tickLoc <= endLoc) {
        self.attributedText = [self.attributedString attributedSubstringFromRange:NSMakeRange(0, tickLoc)];
    }
    
    if (tickLoc > endLoc) {
        if (!self.loopAnimation) {
            [self stop];
            if (self.completionBlock) {
                self.completionBlock(true);
                self.completionBlock = nil;
            }
        }
        tickLoc = startLoc;
    }
    tickLoc ++;
}

@end

