package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.display.SpreadMethod;
	import fl.containers.UILoader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;

	public class ImageViewer extends MovieClip {
		private var scrollPanel:ScrollPanel;
		private var selIndex:Number = -1;
		private var xml:XML;
		public function ImageViewer(x:Number,y:Number,w:Number,h:Number,fin:Function,can:Function) {
			Util.adjust(this,x,y);
			var sel:Sprite = Util.newFilledSprite(0,0,100,100,0x00AAF7);
			var bg:Sprite = Util.newButtonSprite(0,0,w,h,selectNone,"",0,0,0,Util.bgColor,Util.bgColor);
			bg.buttonMode = false;
			addChild(bg);
			Util.fillRect(this,0,0,w,h,Util.bgColor);
			var frame:Sprite = Util.newFilledSprite(0,0,w,90,Util.darkGray);
			Util.fillRect(frame,0,0,20,h,Util.darkGray);
			Util.fillRect(frame,800-20,0,w-800+20,h,Util.darkGray);
			Util.fillRect(frame,0,h-50,w,80,Util.darkGray);
			Util.fillRect(frame,10,50,w-20,2);
			Util.fillRect(frame,800,60,2,h-70);
			addChild(frame);
			addChild(Util.newLabel(10,10,"Image View",35,false,false,Util.yellow));
			addChild(Util.newLabel(180,23,"(select an image below)",17,false,false,Util.yellow));
			addChild(Util.newButtonSprite(20+(760-160)/2-20,h-40,75,30,finish,"Select",6,0,25));
			addChild(Util.newButtonSprite(20+(760-160)/2+70,h-40,75,30,cancel,"Cancel",1,0,25));
			addChild(Util.newButtonSprite(760-30,60,50,25,refreshImg,"Refresh",0,2,15));
			addChildAt(scrollPanel = new ScrollPanel(760,h-140,1000,20,90),1);
			function selectNone(){
				selIndex = -1;
				if(sel.parent != null){
					sel.parent.removeChild(sel);
				}
			}
			function cancel() {
				can();
			}
			function finish() {
				if(xml==null || selIndex < 0){					
					fin(null);					
				}else{
					fin(xml.image[selIndex]);
				}
			}
			function refreshImg() {
				scrollPanel.emptyContainer();
				var disabler:Sprite = Util.newSprite(0,0);
				Util.fillRect(disabler,760-30,60,50,25,Util.darkGray);
				Util.fillRect(disabler,0,h-40,800,40,Util.darkGray);
				Util.fillRect(disabler,20,90,761,h-140,0);
				addChild(disabler);
				Util.newURLRequest("http://localhost/science pluz/php/getImageNames.php/",loadComp,
				   scrollPanel.parent,20,90,700,h-190);
				function loadComp(str:String,fun2:Function) {
					xml = new XML(str);
					//trace(xml);
					var uiloader:UILoader = new UILoader();
					var i:Number = -1;
					function imageLoaded(e:Event) {
						var spr:Sprite = Util.newButtonSprite((i%6)*(740/6)+(740/6-100)/2,int(i/6)*(740/6)+(740/6-100)/2,100,100,clicked);
						const index:Number = i;
						spr.addChild(uiloader);
						scrollPanel.enable(int((i+1)/6)*(740/6)+(740/6-100)/2);
						
						function clicked(){
							spr.addChildAt(sel,0);
							selIndex = index;
						}
						
						
						
						scrollPanel.addChild(spr);
						loadNext();
					}
					function loadNext() {
						i++;
						if (i < xml.image.length()) {
							Util.adjust(uiloader = new UILoader(),1,1,98,98);
							Util.fillRect(uiloader,0,0,85,85,0,0);
							uiloader.buttonMode = true;
							uiloader.load(new URLRequest(String(xml.image[i].address)+String(xml.image[i].filename)));
							uiloader.addEventListener(Event.COMPLETE,imageLoaded);
						}else{
							removeChild(disabler);
							fun2();
						}
					}
					loadNext();
				}
			}
			refreshImg();
		}

	}

}