package  {
	import flash.display.*;
	import fl.events.*;
	import fl.controls.*;
	import flash.geom.*;
	import fl.containers.UILoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.events.MouseEvent;
	
	public class GameView extends MovieClip{
		private var children:Array;
		private var w:Number;
		private var h:Number;
		private var compH:Number;
		private var padding:Number;
		private var margin:Number;
		private var scrollPanel:ScrollPanel;
		private var mutex:Boolean;
		private var clickFun:Function;
		public function GameView(x:Number, y:Number, w:Number, h:Number,clickFun:Function = null,compH:Number = 120,padding:Number = 10,margin:Number = 10) {
			children = new Array();
			mutex = false;
			Util.adjust(this,x,y);
			this.w = w;
			this.h = h;
			this.compH = compH;
			this.padding = padding;
			this.margin = margin;
			this.clickFun = clickFun;
			addChild(scrollPanel=new ScrollPanel(w,h));		
		}
		private function addGame(g_id:String,gName:String,gLevel:String,gType:String,gDesc:String,gThumb:String, loadFin:Function=null){
			var button:Button = Util.newButton(margin,(compH+padding)*children.length+margin,w-20-2*margin,compH,"");
			if(gDesc == null || Util.trim(gDesc).length == 0){
				gDesc = gName + " is a " + gType + " game for " + gLevel + " students.";
			}
			var newX:Number = 300;
			var newY:Number = 12;
			var gdesc:Label = Util.newLabel(newX+7,newY+23,gDesc,13);
			gdesc.wordWrap = true;
			gdesc.setSize(button.width-newX-22,100)
			gdesc.textField.height = 100;		
			var sp:Sprite = new Sprite();
			Util.fillRect(sp,newX,5,2,compH-10,0x888888);
			Util.drawRect(sp, 6,6, compH-12,compH-12,1,0x444444);
			button.addChild(sp);
			button.addChild(Util.newLabel(compH,5,gName, 25));		
			button.addChild(Util.newLabel(compH,35,gLevel,15));		
			button.addChild(Util.newLabel(compH,55,gType,15));			
			button.addChild(Util.newLabel(newX+7,newY,"Description:",18));	
			button.addChild(Util.newLabel(w-2*margin-81-(g_id.length)*9,5,"GameID:"+g_id,15));		
			button.addChild(gdesc);
			
			var thumb:UILoader = new UILoader();
			Util.adjust(thumb,7,7,106,107);
			thumb.addEventListener(Event.COMPLETE, loadComp);
			thumb.addEventListener(IOErrorEvent.IO_ERROR, loadIOError);
			function loadComp(e:Event){	
				button.addChild(thumb);
				if(loadFin!=null){
					loadFin();
				}
			}
			function loadIOError(e:IOErrorEvent){				
				trace("error");
				thumb.load(new URLRequest("../Images/pentopus.png"));
			}			
			if(gThumb == null || Util.trim(gThumb).length == 0){
				gThumb = "../Images/pentopus.png";
			}
			thumb.load(new URLRequest(gThumb));
			///////////////////////////////////////////
			button.addEventListener(MouseEvent.CLICK,clicked);
			function clicked(e:MouseEvent){
				if(clickFun!=null){
					clickFun(g_id);
				}
			}
			///////////////////////////////////////////
			children.push(button);
			scrollPanel.addChild(button);
			scrollPanel.enable((compH+padding)*(children.length-1)+compH+2*margin);
		}
		public function refreshList(fun:Function=null){
			if(!mutex){
				mutex = true;				
				children = new Array();
				scrollPanel.emptyContainer();
				Util.newURLRequest("http://localhost/science pluz/php/getgames.php/",loadComp,this,0,0,this.w,this.h);
				function loadComp(str:String,fun2:Function=null){
					var xml:XML = new XML(str);
					var i:Number=-1;
					function loadNext(){
						i++;
						if(i<xml.game.length()){
							addGame(xml.game[i].g_id,xml.game[i].gname,xml.game[i].glevel,xml.game[i].gtype,xml.game[i].gdesc,xml.game[i].gthumb,loadNext);
						}else{
							if(fun!=null){
								fun();
							}
							if(fun2!=null){
								fun2();
							}
							mutex = false;
						}
					}
					loadNext();
				}
			}
		}
		
	}
	
}
