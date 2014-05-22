//
//  GameLayer.m
//  Game
//
//  Created by user on 13. 6. 13..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "MenuLayer.h"

#define FRONT_CLOUD_SIZE 400
#define BACK_CLOUD_SIZE  380
#define FRONT_CLOUD_TOP  310
#define BACK_CLOUD_TOP   230

@implementation GameLayer
@synthesize rightRunBtn;
@synthesize leftRunBtn;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameLayer *layer = [GameLayer node];
	[scene addChild: layer];
	return scene;
}

//움직이는 배경
-(void) createBackgroundParallax
{
    winSize = [[CCDirector sharedDirector]winSize];
    
    backgrundTrack = [CCSprite spriteWithFile:@"track.png"];
    backgrundTrack.anchorPoint = ccp(0, 0);
    backgrundTrack.position = ccp(winSize.width/2.0, winSize.height/2.0);
    CCParallaxNode *voidNode = [CCParallaxNode node];
    [voidNode addChild:backgrundTrack z:0 parallaxRatio:ccp(1.25f, 0) positionOffset:CGPointZero];
    [self addChild:voidNode z:0 tag:100];
    
}
//배경 구름 이미지
- (void)createCloudWithSize:(int)imgSize top:(int)imgTop fileName:(NSString*)fileName interval:(int)interval z:(int)z {
    id enterRight	= [CCMoveTo actionWithDuration:interval position:ccp(0, imgTop)];
    id enterRight2	= [CCMoveTo actionWithDuration:interval position:ccp(0, imgTop)];
    id exitLeft		= [CCMoveTo actionWithDuration:interval position:ccp(-imgSize, imgTop)];
    id exitLeft2	= [CCMoveTo actionWithDuration:interval position:ccp(-imgSize, imgTop)];
    id reset		= [CCMoveTo actionWithDuration:0  position:ccp( imgSize, imgTop)];
    id reset2		= [CCMoveTo actionWithDuration:0  position:ccp( imgSize, imgTop)];
    id seq1			= [CCSequence actions: exitLeft, reset, enterRight, nil];
    id seq2			= [CCSequence actions: enterRight2, exitLeft2, reset2, nil];
    
    CCSprite *spCloud1 = [CCSprite spriteWithFile:fileName];
    [spCloud1 setAnchorPoint:ccp(0,1)];
    [spCloud1.texture setAliasTexParameters];
    [spCloud1 setPosition:ccp(0, imgTop)];
    [spCloud1 runAction:[CCRepeatForever actionWithAction:seq1]];
    [self addChild:spCloud1 z:z ];
    
    CCSprite *spCloud2 = [CCSprite spriteWithFile:fileName];
    [spCloud2 setAnchorPoint:ccp(0,1)];
    [spCloud2.texture setAliasTexParameters];
    [spCloud2 setPosition:ccp(imgSize, imgTop)];
    [spCloud2 runAction:[CCRepeatForever actionWithAction:seq2]];
    [self addChild:spCloud2 z:z ];
}
-(id) init
{
    if( (self=[super init]) ) {
        
        [self scheduleOnce:@selector(delayStart:) delay:4.0f];
          
        [self createBackgroundParallax];
        [self createBtnImg];
        [self createKwang];
        [self createYoo];
        [self countDown];
        
        [self createCloudWithSize:FRONT_CLOUD_SIZE top:FRONT_CLOUD_TOP fileName:@"cloud_front.png" interval:15 z:2];
        [self createCloudWithSize:BACK_CLOUD_SIZE  top:BACK_CLOUD_TOP  fileName:@"cloud_back.png"  interval:30 z:1];
        
        sound = [SimpleAudioEngine sharedEngine];
        [sound playBackgroundMusic:@"backgroundBGM.WAV" loop:YES];
        
        CCMenuItem * btnRe = [CCMenuItemImage itemWithNormalImage:@"btn_pause.png" selectedImage:@"btn_pause_s.png" target:self selector:@selector(toBack:)];
        CCMenu *remenu = [CCMenu menuWithItems:btnRe, nil];
        remenu.position = ccp(450, 300);
        [self addChild:remenu z:3];
        
    }
	return self;
}

//4초 후에 터치 시작됨
-(void) delayStart:(ccTime)dt
{
    self.isTouchEnabled = YES;
}

//터치 처리하는 곳
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    winSize = [[CCDirector sharedDirector]winSize];
    
    CCAnimation *yooAni = [[CCAnimation alloc] init];
    [yooAni setDelayPerUnit:0.1];
    [yooAni addSpriteFrameWithFilename:@"yoo1.png"];
    [yooAni addSpriteFrameWithFilename:@"yoo2.png"];
    [yooAni addSpriteFrameWithFilename:@"yoo3.png"];
    CCAnimate *yooAnimate = [CCAnimate actionWithAnimation:yooAni];
    
    CCNode *voidNode = [self getChildByTag:100];
    
    id bgMove;
    id yooMove;
    if (yoo.position.x < winSize.width/2-100) {
        yooMove = [CCMoveBy actionWithDuration:0.1f position:ccp(12, 0)];
        id totalAction = [CCSpawn actions:yooMove,yooAnimate, nil];
        [yoo runAction:totalAction];
    }else if(yoo.position.x >= winSize.width/2-100){
        yooMove = [CCMoveBy actionWithDuration:0.1f position:ccp(5.8f, 0)];
        id totalAction = [CCSpawn actions:yooMove,yooAnimate, nil];
        [yoo runAction:totalAction];
        bgMove = [CCMoveBy actionWithDuration:0.1f position:ccp(-10.5, 0)];
        [voidNode runAction:bgMove];
    }
    [self scheduleOnce:@selector(gameOver:)delay:0.1];
}

//버튼 이미지
-(void) createBtnImg
{
    CCSprite *leftRun = [[CCSprite alloc]initWithFile:@"btn_run.png"];
    self.leftRunBtn = leftRun;
    self.leftRunBtn.position = ccp(150, 30);
    [self addChild:self.leftRunBtn z:1];
    [leftRun release];

    CCSprite *rightRun = [[CCSprite alloc]initWithFile:@"btn_run.png"];
    self.rightRunBtn = rightRun;
    self.rightRunBtn.position = ccp(330, 30);
    [self addChild:self.rightRunBtn z:1];
    [rightRun release];
}

//광수 이미지
-(void)createKwang
{
    kwang = [CCSprite spriteWithFile:@"kwang.png"];
    kwang.position = ccp(70, 180);
    [self addChild:kwang z:3];
    
    CCAnimation *kwangAni = [[CCAnimation alloc]init];
    [kwangAni setDelayPerUnit:0.1];
    [kwangAni addSpriteFrameWithFilename:@"kwang.png"];
    [kwangAni addSpriteFrameWithFilename:@"kwang3.png"];
    [kwangAni addSpriteFrameWithFilename:@"kwang1.png"];
    CCAnimate *kwangAnimate = [CCAnimate actionWithAnimation:kwangAni];
    id kwangAni_1 = [CCRepeatForever actionWithAction:kwangAnimate];
    [kwang runAction:kwangAni_1];
    id delay = [CCDelayTime actionWithDuration:4];
    id Move  = [CCMoveBy actionWithDuration:8 position:ccp(345, 0)];
    id totalAction = [CCSequence actions:delay,Move, nil];
    [kwang runAction:totalAction];
}

//재석 이미지
-(void)createYoo
{
    yoo = [CCSprite spriteWithFile:@"yoo1.png"];
    yoo.position = ccp(50, 130);
    [self addChild:yoo z:4];
}

//카운트 다운 이미지
-(void)countDown
{
    winSize = [[CCDirector sharedDirector]winSize];
    CCSprite *num = [CCSprite spriteWithFile:@"num01.png"];
    num.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:num z:9 tag:1000];
    
    CCAnimation *numAni = [[CCAnimation alloc]init];
    [numAni setDelayPerUnit:1];
    [numAni addSpriteFrameWithFilename:@"num03.png"];
    [numAni addSpriteFrameWithFilename:@"num02.png"];
    [numAni addSpriteFrameWithFilename:@"num01.png"];
    [numAni addSpriteFrameWithFilename:@"start.png"];
    CCAnimate *numAnimate = [CCAnimate actionWithAnimation:numAni];
    id remove = [CCCallFunc actionWithTarget:self selector:@selector(countDownRemove)];
    id numTotal = [CCSequence actions:numAnimate,remove, nil];
    [num runAction:numTotal];
}

//카운트 다운 start끝나면 지워지는 부분
-(void)countDownRemove
{
    [self removeChildByTag:1000 cleanup:NO];
}

//gameOver로직 구현
-(void)gameOver:(id)sender
{
    if ( yoo.position.x >= 370) {
        if (yoo.position.x > kwang.position.x) {
            [self performSelector: @selector(GameOverWin:) ];
            [self unschedule:@selector(gameOver:)];
            [sound stopBackgroundMusic];
            self.isTouchEnabled = NO;
        }
    }else if (kwang.position.x >= 380 ){
        if (yoo.position.x < kwang.position.x) {
            [self performSelector: @selector(GameOverLose:)];
            [self unschedule:@selector(gameOver:)];
            [sound stopBackgroundMusic];
            self.isTouchEnabled = NO;
        }
    }
}

//GameOverWin로직 구현
-(void)GameOverWin:(id)sender
{
    winSize = [[CCDirector sharedDirector]winSize];
    CCSprite *win =[CCSprite spriteWithFile:@"youWin.png"];
    win.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:win z:20];
    
    winEffect = [sound playEffect:@"winBGM.mp3"];
}
//GameOverLose로직 구현
-(void)GameOverLose:(id)sender
{
    winSize = [[CCDirector sharedDirector]winSize];
    CCSprite *lose =[CCSprite spriteWithFile:@"youLose.png"];
    lose.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:lose z:20];
    
    LoseEffect = [sound playEffect:@"loseBGM.mp3"];
}

//menu로 돌아가는 매뉴 부분
-(void)toBack:(id)sender
{
    [[CCDirector sharedDirector]replaceScene:[MenuLayer scene]];
    [sound stopBackgroundMusic];
    [sound stopEffect:winEffect];
    [sound stopEffect:LoseEffect];
}
- (void) dealloc
{
    [leftRunBtn release];
    [rightRunBtn release];
	[super dealloc];
}

@end
