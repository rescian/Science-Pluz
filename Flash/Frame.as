package  {
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import fl.containers.UILoader;
	
	public class Frame extends MovieClip{

		public function Frame(x:Number, y:Number) {
			Util.adjust(this,x,y);
			Util.fillRect(this,0,0,1250,370,Util.bgColor);
			Util.fillRect(this,0,969,1250,226,Util.bgColor);
			var loader:UILoader = new UILoader();
			loader.addEventListener(Event.COMPLETE, loadComp);
			var i:Number = 0;
			var images:Array = new Array(
				"../Images/logo.png",
				"../Images/headerinfo.png",
				"../Images/create_edit_button.png",
				"../Images/bubble.png",
				"../Images/stripe1.png","../Images/stripe1.png","../Images/stripe1.png","../Images/stripe1.png",
				"../Images/stripe2.png","../Images/stripe2.png","../Images/stripe2.png","../Images/stripe2.png"
		 	);
			var points:Array = new Array(
				0,200,
				250,250,
				795,250,
				250,70,
				-100,0,338,0,776,0,1214,0,
				-100,1182,338,1182,776,1182,1214,1182
			);
			function loadComp(e:Event){
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
