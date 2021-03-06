/*
 NIBView.h
 
 Copyright 2014/01/01 Guillaume Bohr
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

@class NIBController;

@interface NIBView : UIView

/// Automatically initialized from XIB content
@property (nonatomic, strong) UIViewController *selfController;
@property (nonatomic, weak) UIViewController *weakController;

+ (instancetype)loadInstanceUsingPlaceholder:(NIBView *)placeholder;
+ (instancetype)loadInstanceUsingParentController:(NIBController *)controller;
- (void)setParentController:(NIBController *)controller;
+ (CGSize)defaultNIBSize;

@end
