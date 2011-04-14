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
	
	public class GameEditor extends MovieClip{
		private var gameView:GameView;
		private var createBut:Sprite;
		private var refreshBut:Sprite;
		private var disabler:Sprite;
		private var w:Number;
		private var h:Number;
		public function GameEditor(x:Number, y:Number, w:Number, h:Number) {
			Util.adjust(this,x,y);
			this.w = w;
			this.h = h;
			disabler = Util.newFilledSprite(w-100-79,14,78,23,Util.darkGray);
			Util.fillRect(disabler,90,0,78,23,0x111111);
			addChild(gameView = new GameView(0,50,w,h-50,editGame));
			addChild(Util.newFilledSprite(0,0,w,50,0x111111,1,1,0x555555));
			addChild(createBut = Util.newButtonSprite(w-90-89,14,78,23,createGame,"Create Game",1,3));
			addChild(refreshBut = Util.newButtonSprite(w-89,14,78,23,refreshGames,"Refresh",17,3));
			addChild(Util.newLabel(5,5,"Games Created",35,false,false,Util.yellow));
			addChild(Util.newLabel(230,18,"(click an entry to edit)",17,false,false,Util.yellow));	
			addEventListener(Event.ADDED_TO_STAGE,addedToStage);
			function addedToStage(){
				refreshGames();
			}
		}
		public function hideButtons(){
			//removeChild(createBut);
			//removeChild(refreshBut);
		}
		public function showButtons(){
			//addChild(createBut);
			//addChild(refreshBut);
		}
		public function createGame(){
			hideButtons();
			var newGDial:Sprite = constructDialog1(finish);
			newGDial.addChild(Util.newLabel(10,12,"Create Game",35,false,false,Util.yellow));
			newGDial.addChild(Util.newLabel(207,25,"(please supply the necessary information)",17,false,false,Util.yellow));			
			Util.fillRect(newGDial,540,100,w-570,415,Util.darkGray);
			addChild(newGDial);
			function finish(gname:String,gtype:String,glevel:String,gdesc:String,gthumb:String){
				if(Util.trim(gname).length > 0){
					Util.newURLRequest("http://localhost/science pluz/php/addgame.php/"+
									   "?gname="+gname+
									   "&gtype="+gtype+
									   "&glevel="+glevel+
									   "&gdesc="+gdesc+
									   "&gthumb="+gthumb,loadComp,newGDial,0,0,w,h);				
					function loadComp(str:String,fun2:Function=null){
						gameView.refreshList(reload);
					}
					function reload(){
						removeChild(newGDial);
						showButtons();
					}
				}
			}
		}
		public function editGame(g_id:String){			
			hideButtons();
			Util.newURLRequest("http://localhost/science pluz/php/getgame.php/?g_id="+g_id,
							   gameLoaded,this,0,0,w,h);
			function gameLoaded(str:String,fun2:Function=null){
				var xml:XML = new XML(str);
				var newGDial:Sprite = constructDialog1(finish,xml.gname,xml.gtype,xml.glevel,xml.gdesc,xml.gthumb,fun2);								
				var qaViewer:QAViewer = new QAViewer(540,100,w-570,415,xml);
				newGDial.addChild(Util.newLabel(10,12,"Edit Game",35,false,false,Util.yellow));
				newGDial.addChild(Util.newLabel(160,25,"(please supply the necessary information)",17,false,false,Util.yellow));	
				newGDial.addChild(Util.newLabel(w-105-(g_id.length)*14,20,"GameID:"+g_id,25,false,false,Util.yellow));	
				newGDial.addChild(Util.newButtonSprite(445,26,42,20,deleteGame,"Delete",0,0,15));		
				newGDial.addChild(Util.newLabel(535,70,"Questions and Answers:",25,false,false,Util.yellow));				
				newGDial.addChildAt(qaViewer,0);					
				addChild(newGDial);
				function finish(gname:String,gtype:String,glevel:String,gdesc:String,gthumb:String){
					if(Util.trim(gname).length > 0){
						
						Util.newURLRequest("http://localhost/science pluz/php/editgame.php/"+
										   "?g_id="+g_id+
										   "&gname="+gname+
										   "&gtype="+gtype+
										   "&glevel="+glevel+
										   "&gdesc="+gdesc+
										   "&gthumb="+gthumb+
										   qaViewer.getParam(),loadComp,newGDial,0,0,w,h);				
						function loadComp(str:String,fun2:Function=null){
							gameView.refreshList(reload);
						}
						function reload(){
							removeChild(newGDial);
							showButtons();
						}
					}
				}
				function deleteGame(){
					Util.newURLRequest("http://localhost/science pluz/php/deletegame.php/?g_id="+g_id,
									   loadComp,newGDial,0,0,w,h);				
					function loadComp(str:String,fun2:Function=null){
						gameView.refreshList(reload);
					}
					function reload(){
						removeChild(newGDial);
						showButtons();
					}
				}
			}
		}
		private function constructDialog1(fin:Function,gName:String=null,gType:String=null,gLevel:String=null,gDesc:String=null,gThumb:String="",loadFin:Function=null):Sprite{
			var newGDial:Sprite = Util.newFilledSprite(0,0,w,h,Util.bgColor);
			var frame:Sprite = Util.newFilledSprite(0,0,540,h,Util.darkGray);
			Util.fillRect(frame,540,0,w-540,100,Util.darkGray);
			Util.fillRect(frame,w-30,0,30,h,Util.darkGray);
			Util.fillRect(frame,540,514,w-540,h-514,Util.darkGray);
			Util.fillRect(frame,10,50,w-20,2);
			Util.fillRect(frame,520,60,2,h-70);
			var gname:TextInput=Util.newTextInput(155,75,200,25,gName);
			var gtype:ComboBox=Util.newComboBox(155,115,200,25,Util.gameTypes,gType);
			var glevel:ComboBox=Util.newComboBox(155,155,200,25,Util.gameLevels,gLevel);
			var gdesc:TextArea=Util.newTextArea(15,225,480,290,gDesc);
			var gthumb:String=gThumb;		
			newGDial.addChild(frame);
			newGDial.addChild(Util.newLabel(10,70,"Game Name:",25,false,false,Util.yellow));				
			newGDial.addChild(Util.newLabel(10,110,"Game Type:",25,false,false,Util.yellow));	
			newGDial.addChild(Util.newLabel(10,150,"Game Level:",25,false,false,Util.yellow));	
			newGDial.addChild(Util.newLabel(10,190,"Game Description:",25,false,false,Util.yellow));		
			newGDial.addChild(Util.newLabel(195,198,"(optional)",13,false,false,Util.yellow));		
			newGDial.addChild(Util.newLabel(380,70,"Thumbnail:",25,false,false,Util.yellow));		
			newGDial.addChild(Util.newFilledSprite(156,116,198,23,Util.bgColor));	
			newGDial.addChild(Util.newFilledSprite(156,156,198,23,Util.bgColor));	
			newGDial.addChild(Util.newButtonSprite((520-155)/2+42+40,h-70,75,30,cancel,"Cancel",1,0,25));
			newGDial.addChild(Util.newButtonSprite((520-155)/2-42+35,h-70,75,30,finish,"Finish",8,0,25));
			newGDial.addChild(gname);		
			newGDial.addChild(gtype);	
			newGDial.addChild(glevel);
			newGDial.addChild(gdesc);		
			var thumb:Sprite = Util.newButtonSprite(395,100,80,80,null,"click to change",0,30,13);
			newGDial.addChild(thumb);
			if(Util.trim(gthumb).length > 0){
				var loader:UILoader = new UILoader();
				Util.adjust(loader,0,0,80,80);
				loader.addEventListener(Event.COMPLETE,loadComp);
				function loadComp(e:Event){
					thumb.addChildAt(loader,thumb.numChildren-1);
					if(loadFin !=null){
						loadFin();
					}
				}
				loader.load(new URLRequest(gThumb));
			}else{				
				if(loadFin!=null){
					loadFin();
				}
			}
			thumb.addEventListener(MouseEvent.CLICK,thumbClick);
			function thumbClick(e:MouseEvent){
				var imageviewer:ImageViewer = new ImageViewer(0,0,w,h,finish,cancel);
				addChild(imageviewer);
				function cancel(){
					removeChild(imageviewer);
				}
				function finish(xml:XML){
					for(var i = thumb.numChildren-1; i >= 0;i--){
						if(thumb.getChildAt(i) is UILoader){
							thumb.removeChildAt(i);
							trace("removed");
						}
					}
					if(xml!=null){
						var loader:UILoader = new UILoader();
						Util.adjust(loader,0,0,80,80);
						loader.addEventListener(Event.COMPLETE,loadComp);
						function loadComp(e:Event){
							thumb.addChildAt(loader,thumb.numChildren-1);
						}
						gthumb = String(xml.address)+String(xml.filename);
						loader.load(new URLRequest(gthumb));
					}
					removeChild(imageviewer);
				}
			}
			function cancel(){
				removeChild(newGDial);
				showButtons();
			}
			function finish(){
				fin(gname.text,gtype.selectedLabel,glevel.selectedLabel,gdesc.text,gthumb);
			}
			return newGDial;
		}
		public function refreshGames(){
			hideButtons()
			gameView.refreshList(showButtons);
		}
	}
	
}
