package  {
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import fl.containers.UILoader;
	
	public class Header extends MovieClip{

		public function Header(x:Number, y:Number) {
			Util.adjust(this,x,y);
			var loader:UILoader = new UILoader();
			loader.addEventListener(Event.COMPLETE, loadComp);
			var i:Number = 0;
			var images:Array = new Array(
				"../Images/logo.png",
				"../Images/headerinfo.png",
				"../Images/bubble.png",
				"../Images/stripe1.png",
				"../Images/stripe1.png",
				"../Images/stripe1.png",
				"../Images/stripe1.png"
		 	);
			var points:Array = new Array(
				0,150,
				250,200,
				250,20,
				-100,0,
				338,0,
				776,0,
				1214,0
			);
			function loadComp(e:Event){
				trace(e);
				loader.content.x =points[i*2];
				loader.content.y =points[i*2+1];
				addChild(loader.content);
				i++;
				if(i<images.length){
					loader.load(new URLRequest(images[i]));
				}
			}
			loader.load(new URLRequest(images[i]));
			
		}

	}
	
}
