package{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.DisplayObject;

	public class ScrollPanel extends MovieClip{
		var upBut:MovieClip;
		var centerBut:MovieClip;
		var downBut:MovieClip;
		var scroller:MovieClip;
		var shield:MovieClip;
		var maxH:Number;
		var panelW:Number;
		var panelH:Number;
		var scrollBounds:Rectangle;
		var container:MovieClip;
		var numberOfFrames:Number = 5;
		var col1:Number = 0x999999;
		var col2:Number = 0xDDDDDD;
		var col3:Number = 0x555555;
		function ScrollPanel(panelW:Number,panelH:Number,maxH:Number=0,x:Number=0,y:Number = 0){
			Util.adjust(this,x,y);
			container = Util.newMovieClip(0,0);
			upBut = Util.newMovieClip(panelW-20,0);
			centerBut = Util.newMovieClip(panelW-20,20);
			downBut = Util.newMovieClip(panelW-20,panelH-21); 
		    scroller = Util.newMovieClip(panelW-18,20); 
			this.panelW = panelW;
			this.panelH = panelH;
			shield= new MovieClip();
			//upBut.graphics.lineStyle(1);
			//centerBut.graphics.lineStyle(1);
			//downBut.graphics.lineStyle(1);
			Util.fillRect(upBut,0,0,20,20,col1);
			Util.fillTri(upBut,5,5,10,10,true,col2);			
			Util.fillRect(centerBut,0,0,20,panelH-41,col1);			
			Util.fillRect(downBut,0,0,20,20,col1);
			Util.fillTri(downBut,5,5,10,10,false,col2);
			initScrollBar();
			super.addChild(container);
			super.addChild(upBut);
			super.addChild(centerBut);
			super.addChild(downBut);
			super.addChild(scroller);
			shield.addEventListener(Event.ADDED_TO_STAGE,refill);
			function refill(e:Event){				
				shield.graphics.clear();
				Util.fillRect(shield,0,0,stage.stageWidth,stage.stageHeight,0,0);
			}
			super.addChild(Util.newOutlinedSprite(0,0,panelW+1,panelH-1,1,0x555555,1));
			super.addChild(Util.newOutlinedSprite(panelW-20,0,21,panelH-1,1,0x555555,1));
			enable(Math.max(panelH,maxH));
		}
		private function initScrollBar(){
			this.scroller.addEventListener(MouseEvent.MOUSE_DOWN,dragOn);	
			this.upBut.addEventListener(MouseEvent.MOUSE_DOWN,scrollUp);
			this.downBut.addEventListener(MouseEvent.MOUSE_DOWN,scrollDown);	
			this.centerBut.addEventListener(MouseEvent.MOUSE_DOWN,scrollCenter);			
			var dragging:Boolean = false;
			var scrolling:Number = 0;
			function drag(){				
				if(!dragging){
					dragging = true;
					scroller.stage.addChild(shield);				
				}
			}
			function scrollUp(e:MouseEvent){
				scrolling = -1;
				drag();
			}
			function scrollDown(e:MouseEvent){
				scrolling = 1;
				drag();
			}
			function scrollCenter(e:MouseEvent){
				if(e.stageY<scroller.y){
					scrolling = -3;
				}else if(e.stageY>scroller.y+(panelH-41)*(panelH/maxH)){
					scrolling = 3;
				}
				drag();
			}
			function dragOn(e:MouseEvent){
				e.target.startDrag(false,scrollBounds);	
				drag();
			}
			function dragOff(e:MouseEvent){
				if(dragging){
					e.target.stopDrag();
					scrolling = 0;
					dragging = false;
					scroller.stage.removeChild(shield);
				}
			}
			function scrollContainer(e:Event){
				if(Math.abs(scrolling) > 1 && scroller.hitTestPoint(stage.mouseX,stage.mouseY)){
					scrolling = 0;
				}
				scroll(scrolling*5);
				var scrollRatio:Number = (scroller.y-scrollBounds.y)/(scrollBounds.height);
				var destY:Number = (panelH-maxH)*scrollRatio;
				if(container.y < destY){
					container.y += (destY-container.y)/numberOfFrames;
				}else if(container.y > destY){					
					container.y -= (container.y-destY)/numberOfFrames;
				}				
				if(Math.abs(container.y - destY) < 0.01){					
					container.y = destY;
				}
			}
			shield.addEventListener(MouseEvent.MOUSE_UP,dragOff);
			shield.addEventListener(MouseEvent.MOUSE_OUT,dragOff);
			addEventListener(Event.ENTER_FRAME,scrollContainer);			
		}
		public function scroll(amt:Number){
			scroller.y = Math.max(20,Math.min(20+(panelH-40)*(1-(panelH/maxH)),scroller.y+amt));			
		}
		public function enable(maxH:Number){
			var newH:Number = Math.max(maxH,panelH);
			if(this.maxH != newH){
				this.maxH = newH;
				this.scrollBounds = new Rectangle(panelW-18,20,0,Math.max((panelH-40)*(1-(panelH/this.maxH)),1));
				this.scroller.graphics.clear();
				this.scroller.graphics.lineStyle(0.5);
				Util.fillRect(this.scroller,0,0,15,(panelH-41)*(panelH/this.maxH),col3);
			}
			
		}
		public override function addChild(disp:DisplayObject):DisplayObject{
			container.addChild(disp);
			return disp;
		}
		public function emptyContainer(){
			while(container.numChildren > 0){
				container.removeChildAt(0);
			}
			enable(0);
		}
	}
	
	
}