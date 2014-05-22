//
//  MenuLayer.m
//  Game
//
//  Created by user on 13. 6. 13..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "GameLayer.h"
#import "HowtoLayer.h"
#import "InfoLayer.h"

@implementation MenuLayer
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	MenuLayer *layer = [MenuLayer node];
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
    if( (self=[super init]) ) {
        CCSprite *bg = [CCSprite spriteWithFile:@"menuBG.png"];
        bg.position = ccp(240, 160);
        [self addChild:bg];
        
		CCMenuItem *start = [CCMenuItemImage itemWithNormalImage:@"btn_start.png" selectedImage:@"btn_start_s.png" target:self selector:@selector(doStart:)];
        CCMenuItem *howto = [CCMenuItemImage itemWithNormalImage:@"btn_howto.png" selectedImage:@"btn_howto_s.png" target:self selector:@selector(doHowto:)];
        CCMenuItem *developer = [CCMenuItemImage itemWithNormalImage:@"btn_info.png" selectedImage:@"btn_info_s.png" target:self selector:@selector(doDeveloper:)];
        start.tag = 100;
        howto.tag = 101;
        developer.tag = 102;
        
        CCMenu *menu = [CCMenu menuWithItems:start,howto,developer, nil];
        [menu alignItemsVerticallyWithPadding:20];
        menu.position  = ccp(240, 130);
        [self addChild:menu];
        
        CCSprite *logo = [CCSprite spriteWithFile:@"Logo.png"];
        logo.position = ccp(240, 200);
        logo.scale = 1.5f;
        [self addChild:logo];
        
        id logoAction = [CCJumpTo actionWithDuration:3 position:ccp(240, 250) height:50 jumps:3];
        [logo runAction:logoAction];
    }
	return self;
}
-(void)doStart:(id)sender
{
    [[CCDirector sharedDirector]replaceScene:[GameLayer scene]];
}
-(void)doHowto:(id)sender
{
    [[CCDirector sharedDirector]replaceScene:[HowtoLayer scene]];
}
-(void)doDeveloper:(id)sender
{
    [[CCDirector sharedDirector]replaceScene:[InfoLayer scene]];
}
- (void) dealloc
{
	[super dealloc];
}
@end
