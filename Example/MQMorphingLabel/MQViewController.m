//
//  MQViewController.m
//  MQMorphingLabel
//
//  Created by mayqiyue on 03/27/2018.
//  Copyright (c) 2018 mayqiyue. All rights reserved.
//

#import "MQViewController.h"
#import "MQMorphingLabel.h"

@interface MQViewController ()
@property (weak, nonatomic) IBOutlet MQMorphingLabel *labelone;
@property (weak, nonatomic) IBOutlet MQMorphingLabel *labeltwo;

@end

@implementation MQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.labelone.loopAnimation = true;
    [self.labelone setMorphingAttributedText:
     [[NSAttributedString alloc] initWithString:@"This is marphing label one"
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15],
                                                  NSForegroundColorAttributeName: [UIColor blackColor]
                                                  }]];
    [self.labelone playFromProgress:0 toProgress:1.0 withCompletion:^(BOOL animationFinished) {
    }];
    
    self.labeltwo.loopAnimation = true;
    [self.labeltwo setMorphingAttributedText:
     [[NSAttributedString alloc] initWithString:@"This is marphing label two"
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15],
                                                  NSForegroundColorAttributeName: [UIColor blueColor]
                                                  }]];
    [self.labeltwo playFromProgress:0.2 toProgress:0.8 withCompletion:^(BOOL animationFinished) {
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
