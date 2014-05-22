//
//  InfoLayer.m
//  Game
//
//  Created by user on 13. 6. 13..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "InfoLayer.h"
#import "MenuLayer.h"

@implementation InfoLayer
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	InfoLayer *layer = [InfoLayer node];
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
    if( (self=[super init]) ) {
        CCSprite *info = [CCSprite spriteWithFile:@"info.png"];
        info.position = ccp(239, 159);
        [self addChild: info];
        
        CCMenuItem *back = [CCMenuItemImage itemWithNormalImage:@"out.png" selectedImage:@"out_s.png" target:self selector:@selector(toBack:)];
        CCMenu *menu = [CCMenu menuWithItems:back, nil];
        menu.position = ccp(430, 280);
        [self addChild:menu];

    }
	return self;
}
-(void)toBack:(id)sender
{
    [[CCDirector sharedDirector]replaceScene:[MenuLayer scene]];
}
- (void) dealloc
{
	[super dealloc];
}
@end
