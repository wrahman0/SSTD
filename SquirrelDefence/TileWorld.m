#import "TileWorld.h"
#import "Tile.h"

@interface TileWorld ()

@end

@implementation TileWorld {
	NSMutableArray *_tiles;
	
}

static int MAP_HEIGHT=10;
static int MAP_WIDTH=17;

- (id)initWithMapfile:(NSString*)f {
	if ((self = [super init])) {
		SKTextureAtlas * worldTextures = [SKTextureAtlas atlasNamed:@"World1"];
        
        NSError * err;
        NSStringEncoding * enc;
        NSString * mapPath = [[NSBundle mainBundle] pathForResource:@"World1" ofType:@"txt"];
        NSString * map = [NSString stringWithContentsOfFile:mapPath usedEncoding:&enc error:&err];
        
		_tiles = [NSMutableArray arrayWithCapacity:170];
		Tile * tile;
		for(int y=0;y<MAP_HEIGHT;y++){
			for(int x=0;x<MAP_WIDTH;x++){
                char t =[map characterAtIndex:y*(MAP_WIDTH+1)+x];
				if(t=='P'){
                    tile = [[PathTile alloc] initWithTexture:0 xpos:x ypos:y];
					//[(PathTile*)tile setNextTile:(y*MAP_WIDTH +x+1)];//set next node to next in chain
				} else {
					tile = [[BuildTile alloc] initWithTexture:0
							xpos: x ypos: y];
				}
                tile.texture = [worldTextures textureNamed:[NSString stringWithFormat:@"%@%02d",[tile getTexName],[tile texId]]];
				[self addChild:tile];
				[_tiles insertObject:tile atIndex:(y*MAP_WIDTH +x)];
			}
		}
	}
	return self;
}	
- (Tile *)getTileId:(int)x{
	return _tiles[x];
}
- (Tile *)getTileX:(int)x
	Y:(int)y{
	return _tiles[y*MAP_WIDTH +x];
}
@end
