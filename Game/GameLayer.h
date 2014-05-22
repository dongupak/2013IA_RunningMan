//
//  GameLayer.h
//  Game
//
//  Created by user on 13. 6. 13..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
@interface GameLayer : CCLayer
{
    CGSize winSize;
    
    CCSprite *backgrundTrack;
    CCSprite *kwang;
    CCSprite *yoo;
    
    CCSprite *rightRunBtn;
    CCSprite *leftRunBtn;
    
    BOOL isLeftPressed;
    BOOL isRightPressed;
    
    SimpleAudioEngine *sound;
    ALuint winEffect;
    ALuint LoseEffect;
    
    CCLabelTTF *label;
    
}
- (void)createCloudWithSize:(int)imgSize top:(int)imgTop fileName:(NSString*)fileName interval:(int)interval z:(int)z;
+(CCScene *) scene;



@property (nonatomic, retain) CCSprite *leftRunBtn;
@property (nonatomic, retain) CCSprite *rightRunBtn;

@end
