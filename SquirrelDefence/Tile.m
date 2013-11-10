#import <SpriteKit/SpriteKit.h>
#import "Tile.h"

@implementation Tile
- (id)initWithTexture:(int)t
    xpos:(int)x
	ypos:(int)y{
	if((self = [super initWithColor:[SKColor whiteColor] size:CGSizeMake(32.0, 32.0)])){
        self.anchorPoint = CGPointMake(0.0,0.0);
        self.position = CGPointMake(x*32.0,y*32.0);
        self.texId = t;
	}
	return self;
}
- (NSString*)getTexName{
    return @"none";
}
- (BOOL) canBuildHere{
    return NO;
}
@end

@implementation BuildTile
- (id)initWithTexture:(int)t
    xpos:(int)x
    ypos:(int)y{
	if((self = [super initWithTexture:t xpos:x ypos:y])){
		_building = nil;
	}
	return self;
}
- (NSString*)getTexName{
    return @"build";
}
- (BOOL) canBuildHere{
    return _building==nil;
}
@end

@implementation PathTile
- (id)initWithTexture:(int)t
                xpos:(int)x
                ypos:(int)y{
	if((self = [super initWithTexture:t xpos:x ypos:y])){
		_nextTile = -1;
	}
	return self;
}
- (id)initWithTexture:(int)t
                xpos:(int)x
                ypos:(int)y
                nextid:(int)nid{
	if((self = [super initWithTexture:t xpos:x ypos:y])){
		_nextTile = nid;
	}
	return self;
}
- (NSString*)getTexName{
    return @"path";
}
- (BOOL) canBuildHere{
    return NO;
}
@end
