
//Header files:
#import "MapScene.h"
#import "TileWorld.h"
#import "MapLoc.h"
#import "EnemyManager.h"
#import "Enemy.h"
#import "MenuLayer.h"
#import "Player.h"
#import "BuildingManager.h"
#import "GameoverScene.h"
#import "InfoLayer.h"

@interface MapScene()
@property BOOL contentCreated;
@end

@implementation MapScene

{
    MenuLayer *_menuLayer;
    InfoLayer *_infoLayer;
    BOOL _dead;
}
    
- (void)didMoveToView: (SKView *)view
{
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents
{
    [Player getPlayer];
    self.backgroundColor = [SKColor whiteColor];
    
    [[TileWorld getInstance] loadMapfile:@"World1"];
    [self addChild:[TileWorld getInstance]];
    
    [[EnemyManager getInstance] setEnemyPath:[[TileWorld getInstance] generatePath]];
    [self addChild:[EnemyManager getInstance]];
    
    [self addChild:[BuildingManager getInstance]];
    
    _menuLayer = [[MenuLayer alloc] init];
    _infoLayer = [[InfoLayer alloc] init];
    _infoLayer.position = CGPointMake(self.frame.size.width/2 - _infoLayer.frame.size.width/2, 10);
    [self addChild:_menuLayer];
    [self addChild:_infoLayer];
    
    _dead = NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_menuLayer touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_menuLayer touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_menuLayer touchesEnded:touches withEvent:event];
}

-(void)update:(CFTimeInterval)currentTime {
    if ([[Player getPlayer] health]<=0){//game over man, game over
        if (!_dead) {
            _dead = YES;
            [[Player getPlayer] destroy];
            [[EnemyManager getInstance] destroy];
            [[BuildingManager getInstance] destroy];
            SKScene *gameoverScene = [[GameoverScene alloc] initWithSize:self.size];
            SKTransition *transition = [SKTransition doorwayWithDuration:0.5];
            [self.view presentScene:gameoverScene transition:transition];
        }
    }
    [[EnemyManager getInstance] updateAll];
    [[BuildingManager getInstance] updateAll];
    //Get the player.
    [_infoLayer update:[Player getPlayer]];
    
}

@end
