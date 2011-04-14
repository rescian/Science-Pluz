package  {
	import flash.display.MovieClip;
	import fl.controls.Button;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import fl.controls.TextInput;
	import fl.controls.ComboBox;
	import fl.controls.TextArea;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import fl.containers.UILoader;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	
	public class GamePlayer extends MovieClip{
		private var gameView:GameView;
		private var createBut:Sprite;
		private var refreshBut:Sprite;
		private var disabler:Sprite;
		private var w:Number;
		private var h:Number;
		public function GamePlayer(x:Number, y:Number, w:Number, h:Number) {
			Util.adjust(this,x,y);
			this.w = w;
			this.h = h;
			disabler = Util.newFilledSprite(w-100-79,14,78,23,Util.darkGray);
			Util.fillRect(disabler,90,0,78,23,0x111111);
			addChild(gameView = new GameView(0,50,w,h-50,playGame));
			addChild(Util.newFilledSprite(0,0,w,50,0x111111,1,1,0x555555));
			addChild(refreshBut = Util.newButtonSprite(w-89,14,78,23,refreshGames,"Refresh",17,3));
			addChild(Util.newLabel(5,5,"Games Created",35,false,false,Util.yellow));
			addChild(Util.newLabel(230,18,"(click an entry to play)",17,false,false,Util.yellow));	
			addEventListener(Event.ADDED_TO_STAGE,addedToStage);
			function addedToStage(){
				refreshGames();
			}
		}
		public function hideButtons(){
			//removeChild(refreshBut);
		}
		public function showButtons(){
			//addChild(refreshBut);
		}
		public function playGame(g_id:String){			
			hideButtons();
			var newGDial:Sprite = Util.newFilledSprite(0,0,w,h,Util.darkGray);
			Util.newURLRequest("http://localhost/science pluz/php/getgame.php/?g_id="+g_id,
							   gameLoaded,this,0,0,w,h);		
			function gameLoaded(str:String,fun2:Function=null){
				var xml:XML = new XML(str);														
				Util.fillRect(newGDial,10,50,w-20,2);
				newGDial.addChild(Util.newLabel(10,12,xml.gname,35,false,false,Util.yellow));
				newGDial.addChild(new Identification((w-500)/2,60,500,500,xml));
				newGDial.addChild(Util.newButtonSprite(w-65,15,50,22,back,"Back",3,-1,20));
				addChild(newGDial);
				fun2();
				function back(){
					showButtons();
					removeChild(newGDial);
				}
			}
		}
		public function refreshGames(){
			hideButtons();
			gameView.refreshList(showButtons);
		}
	}
	
}
