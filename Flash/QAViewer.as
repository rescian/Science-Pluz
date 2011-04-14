package  {
	import fl.controls.ScrollBar;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import fl.controls.TextInput;
	import flash.events.TextEvent;
	import fl.containers.UILoader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.events.MouseEvent;
	
	public class QAViewer extends MovieClip{
		var scrollPanel:ScrollPanel;
		var children:Array;
		var w:Number;
		var h:Number;
		public function QAViewer(x:Number,y:Number,w:Number,h:Number,xml:XML) {
			Util.adjust(this,x,y);
			this.w = w;
			this.h = h;
			addChild(scrollPanel=new ScrollPanel(w,h,1000));
			children = new Array();
			trace(xml);
			for(var i = 0; i < xml.qas.qa.length();i++){
				var qa:XML = xml.qas.qa[i];
				addQA(qa.qtext,qa.qimage,qa.atext,qa.aimage);			
			}
			addEnter();
		}
		public function addQA(qtext:String,qimage:String,atext:String,aimage:String){
			var qa:Sprite = Util.newFilledSprite(10,10+100*children.length,w-20-20,90,Util.darkGray);
			
			var division:Number = w-287;
			var qtextinput:TextInput = Util.newTextInput(93,30,division-103,18,qtext,12);
			var atextinput:TextInput = Util.newTextInput(93,60,division-103,18,atext,12);
			var qimginput:TextInput = Util.newTextInput(0,0,0,18,qimage);
			var aimginput:TextInput = Util.newTextInput(0,0,0,18,aimage);

			qa.addChild(Util.newLabel(8,30,"Question Text:",13,false,false,Util.yellow));
			qa.addChild(Util.newLabel(15,60,"Answer Text:",13,false,false,Util.yellow));
			qa.addChild(qtextinput);
			qa.addChild(atextinput);
			Util.fillRect(qa,0,20,w-20-20,2);
			Util.fillRect(qa,division,25,1,60);
			
			qa.addChild(Util.newLabel(division+5,30,"Question",13,false,false,Util.yellow));
			qa.addChild(Util.newLabel(division+5,40,"    Image:",13,false,false,Util.yellow));
			var qImageSprite:Sprite =Util.newButtonSprite(division+67,30,50,50,null,"Click to Change",1,19,7);
			qa.addChild(qImageSprite);
			qa.addChild(Util.newLabel(division+125,30,"Answer",13,false,false,Util.yellow));
			qa.addChild(Util.newLabel(division+125,40,"  Image:",13,false,false,Util.yellow));
			var aImageSprite:Sprite = Util.newButtonSprite(division+180,30,50,50,null,"Click to Change",2,19,7);
			qa.addChild(aImageSprite);
			
			qa.addChild(Util.newButtonSprite(10,3,38,14,deleteQA,"Delete",1,0,11));		
			var arr:Object = {"qa":qa,"qtext":qtextinput,"qimage":qimginput,"atext":atextinput,"aimage":aimginput};
			children.push(arr);
			scrollPanel.addChild(qa);
			scrollPanel.enable(20+100*children.length);
			if(qimage!=null&&Util.trim(qimage).length > 0){
				var qloader:UILoader = new UILoader();
				Util.adjust(qloader,0,0,50,50);
				qloader.addEventListener(Event.COMPLETE,qloadComp);
				function qloadComp(e:Event){
					qImageSprite.addChildAt(qloader,0);
				}
				qloader.load(new URLRequest(qimage));
			}
			parent.addEventListener(MouseEvent.CLICK,thumbclick1);
			function thumbclick1(e:MouseEvent){
				trace(10,parent);
				var imageviewer:ImageViewer = new ImageViewer(0,0,1250,600,finish,cancel);
				parent.addChild(imageviewer);
				function cancel(){
					parent.removeChild(imageviewer);
				}
				function finish(xml:XML){
					for(var i = qImageSprite.numChildren-1; i >= 0;i--){
						if(qImageSprite.getChildAt(i) is UILoader){
							qImageSprite.removeChildAt(i);
							trace("removed");
						}
					}
					if(xml!=null){
						var loader:UILoader = new UILoader();
						Util.adjust(loader,0,0,80,80);
						loader.addEventListener(Event.COMPLETE,loadComp);
						function loadComp(e:Event){
							qImageSprite.addChildAt(loader,qImageSprite.numChildren-1);
						}
						qimginput.text = String(xml.address)+String(xml.filename);
						loader.load(new URLRequest(qtextinput.text));
					}
					parent.removeChild(imageviewer);
				}
			}
			
			if(aimage!=null&&Util.trim(aimage).length > 0){
				var aloader:UILoader = new UILoader();
				Util.adjust(aloader,0,0,50,50);
				aloader.addEventListener(Event.COMPLETE,aloadComp);
				function aloadComp(e:Event){
					aImageSprite.addChildAt(aloader,0);
				}
				aloader.load(new URLRequest(aimage));
			}
			function deleteQA(){
				for(var i:Number = 0; i < children.length; i++){
					if(arr == children[i]){
						children.splice(i,1);
						break;
					}
				}
				refreshList()
			}
			
		}
		public function addEnter(){
			var qa:Sprite = Util.newFilledSprite(10,10+100*children.length,w-20-20,90,0x113377);
			
			var division:Number = w-287;
			var qtextinput:TextInput = Util.newTextInput(93,30,division-103,18,"",12);
			var atextinput:TextInput = Util.newTextInput(93,60,division-103,18,"",12);
			var qimginput:TextInput = Util.newTextInput(0,0,0,18,"");
			var aimginput:TextInput = Util.newTextInput(0,0,0,18,"");

			qa.addChild(Util.newLabel(8,30,"Question Text:",13,false,false,Util.yellow));
			qa.addChild(Util.newLabel(15,60,"Answer Text:",13,false,false,Util.yellow));
			qa.addChild(qtextinput);
			qa.addChild(atextinput);
			Util.fillRect(qa,0,20,w-20-20,2);
			Util.fillRect(qa,division,25,1,60);
			
			qa.addChild(Util.newLabel(division+5,30,"Question",13,false,false,Util.yellow));
			qa.addChild(Util.newLabel(division+5,40,"    Image:",13,false,false,Util.yellow));
			var qImageSprite:Sprite =Util.newButtonSprite(division+67,30,50,50,null,"Click to Change",1,19,7);
			qa.addChild(qImageSprite);
			qa.addChild(Util.newLabel(division+125,30,"Answer",13,false,false,Util.yellow));
			qa.addChild(Util.newLabel(division+125,40,"  Image:",13,false,false,Util.yellow));
			var aImageSprite:Sprite = Util.newButtonSprite(division+180,30,50,50,null,"Click to Change",2,19,7);
			qa.addChild(aImageSprite);
			
			qa.addChild(Util.newButtonSprite(10,3,38,14,addClick,"ADD",6,0,11));		
			var arr:Object = {"qa":qa,"qtext":qtextinput,"qimage":qimginput,"atext":atextinput,"aimage":aimginput};
			scrollPanel.addChild(qa);
			scrollPanel.enable(120+100*children.length);
			scrollPanel.scroll(1000);			
			function addClick(){	
				if((Util.trim(qtextinput.text)+Util.trim(qimginput.text)).length *
				   (Util.trim(atextinput.text)+Util.trim(aimginput.text)).length > 0 ){
					addQA(qtextinput.text,qimginput.text,atextinput.text,aimginput.text);
					refreshList();
				}
			}
		}
		private function refreshList(){
			scrollPanel.emptyContainer();
			for(var i = 0; i < children.length;i++){
				var qa:Sprite = children[i]["qa"];
				qa.y=10+100*i;
				scrollPanel.addChild(qa);
			}
			addEnter();
			scrollPanel.enable(120+100*children.length);
			scrollPanel.scroll(1000);
		}
		public function getParam():String{
			var req:String="";
			for(var i = 0; i < children.length;i++){
				req+="&qtext"+i+"="+children[i]["qtext"].text+
					 "&qimage"+i+"="+children[i]["qimage"].text+
					 "&atext"+i+"="+children[i]["atext"].text+
					 "&aimage"+i+"="+children[i]["aimage"].text;
			}
			return req;
		}
	}
	
}
