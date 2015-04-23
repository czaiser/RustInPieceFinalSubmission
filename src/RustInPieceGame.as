package
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import citrus.core.starling.StarlingCitrusEngine;
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="0x33CCFF")]
	public class RustInPieceGame extends StarlingCitrusEngine
	{
		
		private var loader:Loader;
		
		public function RustInPieceGame()
		{
			setUpStarling(true);
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);
			loader.load(new URLRequest("../levels/level1.swf"));
			
			//load background music
			sound.addSound('backgroundMusic', {sound:"../sounds/levelOneMusicVersionII.mp3", loops:-1, volume: 0.5});
			
			//load sound effects
			//load 'hero jump' sound effect
			sound.addSound('heroJump', {sound:"../sounds/effects/hero_jump.mp3"});
			
			//load 'hero hurt' sound effect
			sound.addSound("heroHurt", {sound:"../sounds/effects/hero_hurt.mp3"});
			
			//load 'enemy kill' sound effect
			sound.addSound('enemyKill', {sound:"../sounds/effects/enemyOne_hurt.mp3"});
			
			//load collect battery sound effects
			sound.addSound('collectBattery', {sound:"../sounds/effects/collectBattery.mp3"});
		}
		
		protected function onLoad(e:Event):void
		{
			state = new Level1(e.target.loader.content);
			
			loader.removeEventListener(Event.COMPLETE, onLoad);
			loader.unloadAndStop(true);
		}
	}
}