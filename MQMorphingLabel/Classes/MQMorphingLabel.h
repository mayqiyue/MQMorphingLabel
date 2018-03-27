//
//  MQMorphingLabel.h
//  Xoding
//
//  Created by Mayqiyue on 27/03/2018.
//  Copyright © 2018 mayqiyue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MQMAnimationCompletionBlock)(BOOL animationFinished);

@interface MQMorphingLabel : UILabel

@property (nonatomic, strong, readonly) NSString * _Nullable normlString;
@property (nonatomic, strong, readonly) NSAttributedString * _Nullable attributedString;

/// Flag is YES when the animation is playing
@property (nonatomic, readonly) BOOL isAnimationPlaying;

/// Tells the animation to loop indefinitely.
@property (nonatomic, assign) BOOL loopAnimation;

/// Sets the speed of the animation, deault is 0.1 (means every 0.1s, there will show one more character)
@property (nonatomic, assign) CGFloat animationSpeed;

/// Read only of the duration in seconds of the animation at speed of 1
@property (nonatomic, readonly) CGFloat animationDuration;
//
- (void)setMorphingText:(nullable NSString *)string;

- (void)setMorphingAttributedText:(nullable NSAttributedString *)attributedString;

/**
 * Plays the animation from specific progress to a specific progress
 * The animation will start from its current position..
 * If loopAnimation is YES the animation will loop from the startProgress to the endProgress indefinitely
 * If loopAnimation is NO the animation will stop and the comletion block will be called.
 */
- (void)playFromProgress:(CGFloat)fromProgress
              toProgress:(CGFloat)toProgress
          withCompletion:(nullable MQMAnimationCompletionBlock)completion;

/**
 * Plays the animation from progress 0 to the end of the animation.
 * The animation will start from its current position.
 * If loopAnimation is YES the animation will loop from beginning to end indefinitely.
 * If loopAnimation is NO the animation will stop and the comletion block will be called.
 **/
- (void)playWithCompletion:(nullable MQMAnimationCompletionBlock)completion;

/// Plays the animaiton
- (void)play;

/// Stops the animation at the current frame. The completion block will be called.
/// TODO
- (void)pause;

/// Stops the animation and rewinds to the beginning. The completion block will be called.
- (void)stop;

@end

