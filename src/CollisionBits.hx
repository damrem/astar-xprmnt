package;

/**
 * @author damrem
 */

class CollisionBits 
{
	public static inline var HERO_CATEGORY:Int = 0x0002;
	public static inline var TILE_CATEGORY:Int = 0x0004;
	public static inline var BOUNDARY_CATEGORY:Int = 0x0008;
	
	public static inline var HERO_MASK:Int = TILE_CATEGORY | BOUNDARY_CATEGORY;
	public static inline var TILE_MASK:Int = HERO_CATEGORY;
	public static inline var BOUNDARY_MASK:Int = HERO_CATEGORY;
}