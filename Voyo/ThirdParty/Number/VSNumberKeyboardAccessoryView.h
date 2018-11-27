//
//  VSNumberKeyboardAccessoryView.h
//  VIN Scan
//
//  Created by Ryan Worl on 6/12/14.
//  Copyright (c) 2014 Cellaflora. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VSNumberKeyboardAccessoryView : UIView

- (instancetype)initWithTextInput:(UIResponder<UITextInput> *)textInput;

@property (nonatomic, weak) IBOutlet UIButton* oneButton;
@property (nonatomic, weak) IBOutlet UIButton* twoButton;
@property (nonatomic, weak) IBOutlet UIButton* threeButton;
@property (nonatomic, weak) IBOutlet UIButton* fourButton;
@property (nonatomic, weak) IBOutlet UIButton* fiveButton;
@property (nonatomic, weak) IBOutlet UIButton* sixButton;
@property (nonatomic, weak) IBOutlet UIButton* sevenButton;
@property (nonatomic, weak) IBOutlet UIButton* eightButton;
@property (nonatomic, weak) IBOutlet UIButton* nineButton;
@property (nonatomic, weak) IBOutlet UIButton* zeroButton;

@property (nonatomic, weak) IBOutletCollection(UIButton) NSArray* keyButtons;

@end
