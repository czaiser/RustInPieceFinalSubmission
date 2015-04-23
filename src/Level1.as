package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.Contacts.b2PolygonContact;
	
	import citrus.core.starling.StarlingState;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Crate;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.MovingPlatform;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	
	import dragonBones.Armature;
	import dragonBones.factorys.StarlingFactory;

	public class Level1 extends StarlingState
	{
		private var level:MovieClip;
		private var hero:Hero;
		private var enemy:Enemy;
		private var platform:Platform;
		private var fall:Sensor;
		private var reset:Boolean = false;
		private var arm:Armature;
		private var factory:StarlingFactory;
		private var coin:Coin;
		private var death:Sensor;
		
		//embedding hero dragon bones from Flash
		[Embed (source="../dragonbones/hero.png", mimeType="application/octet-stream")]
		private var heroDragon:Class;

		public function Level1(lvl:MovieClip)
		{
			super();
			level = lvl;
			var objectsUsed:Array = [Hero, Platform, Sensor, Enemy, Coin, MovingPlatform, Crate];
			
			factory = new StarlingFactory();
			factory.addEventListener(Event.COMPLETE, onDragon);
			factory.parseData(new heroDragon());
		}
		
		//loading Dragon Bones before level initializes
		protected function onDragon(event:Event):void
		{
			arm = factory.buildArmature("hero");
			arm.animation.timeScale = .75;
			init();
		}

		private function init():void
		{
			super.initialize();
			
			var physics:Box2D = new Box2D("box2d");
			//set to true to view boundaries
			//set to false to hide boundaries
			physics.visible = false;
			add(physics);
			
			ObjectMaker2D.FromMovieClip(level);
			
			//adding hero
			hero = new Hero("hero", {x:340, y:600, width:120, height:200.15, view:arm});
			add(hero);

			//adding hero 'jump' sound effect
			hero.onJump.add(heroJump)
			
			//adding kill sound effect to enemy
			hero.onGiveDamage.add(heroAttack);
			
			//adding damage sound effect to hero
			hero.onTakeDamage.add(heroHurt);
				
			//adding battery collection sound effect(s)
			coin = getObjectByName("battery1") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery2") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery3") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery4") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery5") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery6") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery7") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery8") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery9") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery10") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery11") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery12") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery13") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery14") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery15") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery16") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery17") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery18") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery19") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery20") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery21") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery22") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery23") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery24") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery25") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery26") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery27") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery28") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery29") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery30") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery31") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery32") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery33") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			coin = getObjectByName("battery34") as Coin;
			coin.onBeginContact.add(collectBattery);
			
			
			//adding fall - off screen reset
			fall = getObjectByName("fall") as Sensor;
			fall.onBeginContact.add(onFall);
			
			//adding water puddle (death) sensor
			death = getObjectByName("waterPuddle") as Sensor;
			death.onBeginContact.add(onDeath);
			
			//adding camera
			view.camera.setUp(hero,new Rectangle(0,0,8000,1000),null,new Point(.5,.25));
			
			//adding background music
			_ce.sound.playSound('backgroundMusic');	
		}

		//reset (if hero falls off screen)
		//checks to see
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			if(reset) {
				resetHero(340, 600);
			}
		}
		
		//reset hero
		private function resetHero(x:int, y:int):void
		{
			hero.x = 360;
			hero.y = 600;
			
			reset = false;
		}
		
		//checks to see if hero fell
		private function onFall(c:b2PolygonContact):void
		{
			trace("hero fell offscreen");
			//will reset hero to starting position
			reset = true;
		}
		
		private function onDeath(c:b2PolygonContact):void
		{
			trace("hero died");
			//will reset hero to starting position
			reset = true;
		}
		
		//'jump' sound effect function
		private function heroJump():void
		{
			_ce.sound.playSound('heroJump');
			trace("hero jumped");
		}
		
		//'kill' enemy sound effect function
		private function heroAttack():void
		{
			_ce.sound.playSound('enemyKill');
			trace("hero killed enemy");
		}
		
		//hero 'hurt' sound effect function
		private function heroHurt():void
		{
			_ce.sound.playSound('heroHurt');
			trace("hero hurt");
		}
		
		//collect battery sound effect function
		private function collectBattery(contact:b2Contact):void 
		{
			_ce.sound.playSound("collectBattery");
			trace("collected battery");
		}
		
	}
}