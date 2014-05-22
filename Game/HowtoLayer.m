//
//  HowtoLayer.m
//  Game
//
//  Created by user on 13. 6. 13..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "HowtoLayer.h"
#import "MenuLayer.h"


@implementation HowtoLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	HowtoLayer *layer = [HowtoLayer node];
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
    if( (self=[super init]) ) {
        CCSprite *howto = [CCSprite spriteWithFile:@"howto.png"];
        howto.position = ccp(240, 160);
        [self addChild: howto];
        
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


