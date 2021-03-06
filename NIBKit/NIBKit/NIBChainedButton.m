/*
 NIBChainedButton.m
 
 Copyright 2014/02/03 Guillaume Bohr
 
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

#import "NIBChainedButton.h"

@implementation NIBChainedButton

@synthesize savedSize;
@synthesize removedFromSuperview;
@synthesize nextView;

- (void)setAutoresizingMask:(UIViewAutoresizing)autoresizingMask
{
    [self checkAutoresizingMask:&autoresizingMask];
    [super setAutoresizingMask:autoresizingMask];
}

- (void)removeFromSuperview
{
    removedFromSuperview = YES;
    [self removeChainedViewFromSuperview];
}

- (void)setHidden:(BOOL)hidden
{
    if (hidden != self.isHidden && !removedFromSuperview)
    {
        [super setHidden:hidden];
        [self setChainedViewHidden:hidden];
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self reframeNextChainedView];
}

- (void)setNextView:(UIView<NIBChainProtocol> *)view
{
    nextView = view;
    [self reframeNextChainedView];
}

@end
