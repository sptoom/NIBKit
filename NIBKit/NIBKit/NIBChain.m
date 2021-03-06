/*
 NIBChain.m
 
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

#import "NIBChain.h"

@implementation UIView (NIBChain)

- (void)checkAutoresizingMask:(UIViewAutoresizing *)autoresizingMask
{
    // Fix to top and disable vertical flexibility
    *autoresizingMask |= UIViewAutoresizingFlexibleBottomMargin;
    *autoresizingMask &= ~UIViewAutoresizingFlexibleTopMargin;
    *autoresizingMask &= ~UIViewAutoresizingFlexibleHeight;
}

- (void)removeChainedViewFromSuperview
{
    // Hide self instead of removing it from its superview (in order to preserve nib chain)
    [self setHidden:YES];
}

- (void)setChainedViewHidden:(BOOL)hidden
{
    UIView<NIBChainProtocol> *castSelf = (UIView<NIBChainProtocol> *)self;
    
    CGRect newFrame = self.frame;
    if (hidden)
    {
        // Save current frame size and shrink after
        castSelf.savedSize = newFrame.size;
        newFrame.size.height = 0.0f;
    }
    else
    {
        // Reset using saved size
        newFrame.size = castSelf.savedSize;
    }
    
    [self setFrame:newFrame];
}

- (void)reframeNextChainedView
{
    UIView<NIBChainProtocol> *castSelf = (UIView<NIBChainProtocol> *)self;
    
    if (castSelf.nextView)
    {
        // Reframe next view
        CGRect nextFrame = castSelf.nextView.frame;
        nextFrame.origin.y = CGRectGetMaxY(self.frame);
        [castSelf.nextView setFrame:nextFrame];
    }
    else
    {
        // Check superview class
        if ([self.superview isMemberOfClass:[UIScrollView class]])
        {
            // Update content size
            UIScrollView *superScrollView = (UIScrollView *)self.superview;
            CGSize newContentSize = CGSizeMake(superScrollView.bounds.size.width, CGRectGetMaxY(self.frame));
            [superScrollView setContentSize:newContentSize];
        }
        else if (self.superview.isHidden && [self.superview conformsToProtocol:@protocol(NIBChainProtocol)])
        {
            // Update super view saved frame
            UIView<NIBChainProtocol> *castSuper = (UIView<NIBChainProtocol> *)self.superview;
            castSuper.savedSize = CGSizeMake(castSuper.savedSize.width, CGRectGetMaxY(self.frame));
        }
        else
        {
            // Reframe super view
            CGRect superFrame = self.superview.frame;
            superFrame.size.height = CGRectGetMaxY(self.frame);
            [self.superview setFrame:superFrame];
        }
    }
}

@end
