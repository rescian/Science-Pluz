package {
	import flash.display.MovieClip;
	import fl.controls.TextInput;
	import fl.controls.Label;
	import flash.events.KeyboardEvent;
	import flashx.textLayout.formats.TextAlign;
	import flash.events.Event;

	public class Identification extends MovieClip {
		private var xml:XMLList;
		private var w:Number;
		private var h:Number;
		private var old:Number;
		public function Identification(x:Number,y:Number,w:Number,h:Number,xml:XML) {
			Util.adjust(this,x,y);
			this.w = w;
			this.h = h;
			this.graphics.lineStyle(1);
			Util.fillRect(this,0,0,w,h,0xFFFFFF);
			this.graphics.lineStyle(0);
			this.xml = xml.qas;
			old = -1;
			startGame();
		}
		function startGame() {
			if (xml.qa.length() > 0) {
				var num:Number = int(Math.random() * xml.qa.length());
				while(xml.qa.length() > 1 && old == num){
					num = int(Math.random() * xml.qa.length());					
				}
				old = num;
				trace(num,xml.qa[num].qtext);
				var inp:TextInput = Util.newTextInput((w-200)/2,(h-30)/2,200,30,"",25);
				inp.textField.background = false;
				var lbl:Label = Util.newLabel(0,(h-30)/2-80,xml.qa[num].qtext,35,true,false,0,true,w);
				addChild(lbl);
				addChild(inp);
				var res:Label = Util.newLabel(0,(h-30)/2+33,"",35,true,false,0,true,w);						
				addChild(res);
				inp.addEventListener(KeyboardEvent.KEY_DOWN,enterDown);
				inp.addEventListener(Event.ADDED_TO_STAGE,added);
				function added(e:Event){					
					stage.focus = inp;
				}
				function enterDown(e:KeyboardEvent){
					if(e.charCode == 13){
						res.text = (xml.qa[num].atext.toLowerCase() == Util.trim(inp.text).toLowerCase()?"Correct!":"Wrong!");
						inp.removeEventListener(KeyboardEvent.KEY_DOWN,enterDown);
						addEventListener(Event.ENTER_FRAME,enterF);
						var s = -1;
						function enterF(e:Event){
							s++;
							if(s > 20){
								removeEventListener(Event.ENTER_FRAME,enterF);							
								removeChild(lbl);
								removeChild(inp);
								removeChild(res);
								startGame();
							}
						}
					}
				}
			}
		}

	}

}