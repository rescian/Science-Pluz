package {
	import fl.controls.*;
	import fl.controls.dataGridClasses.DataGridColumn;
	import flash.text.*;
	import fl.data.DataProvider;
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flashx.textLayout.formats.TextAlign;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;



	public class Util {
		public static const bgColor:Number = 0xFFFFA3;
		public static const yellow:Number = 0xFFE219;
		public static const darkGray:Number = 0x111111;
		public static const gameTypes:Array = new Array("Identification",
													  "Multiple Choice",
													  "Matching",
													  "Point and Click");
		public static const gameLevels:Array = new Array("Grade 1",
													   "Grade 2",
												 	   "Grade 3",
													   "Grade 4",
													   "Grade 5",
													   "Grade 6",
													   "High School I",
													   "High School II",
													   "High School III",
													   "High School IV");
		public function Util(util:Util) {
		}
		public static function drawRect(disp:Sprite,x:Number,y:Number,w:Number,h:Number,size:Number=1,color:Number=0,alpha:Number=1) {
			disp.graphics.lineStyle(size,color,alpha);
			disp.graphics.drawRect(x,y,w-1,h);
			disp.graphics.lineStyle();
		}
		public static function fillRect(disp:Sprite,x:Number,y:Number,w:Number,h:Number,color:Number=0,alpha:Number=1) {
			disp.graphics.beginFill(color,alpha);
			disp.graphics.drawRect(x,y,w,h);
			disp.graphics.endFill();
		}
		public static function fillRRect(disp:Sprite,x:Number,y:Number,w:Number,h:Number,rad:Number,color:Number=0,alpha:Number=1) {
			disp.graphics.beginFill(color,alpha);
			disp.graphics.drawRoundRect(x,y,w,h,rad,rad);
			disp.graphics.endFill();
		}
		public static function fillTri(disp:Sprite,x:Number,y:Number,w:Number,h:Number,up:Boolean = true, color:Number=0,alpha:Number=1) {
			disp.graphics.beginFill(color,alpha);
			var verts:Vector.<Number> = new Vector.<Number>();
			if (up) {
				verts.push(x,y+h,x+w/2,y,x+w,y+h);
			} else {
				verts.push(x,y,x+w/2,y+h,x+w,y);
			}
			disp.graphics.drawTriangles(verts);
			disp.graphics.endFill();
		}
		public static function newMovieClip(x:Number, y:Number):MovieClip {
			var mv:MovieClip =  new MovieClip();
			mv.x = x;
			mv.y = y;
			return mv;
		}
		public static function newSprite(x:Number, y:Number):Sprite {
			var sp:Sprite =  new Sprite();
			sp.x = x;
			sp.y = y;
			return sp;
		}
		public static function newFilledSprite(x:Number, y:Number,w:Number,h:Number,col:Number=0,alp:Number=1,lsize:Number=0,lcol:Number=0,lalp:Number=1):Sprite {
			var sp:Sprite =  new Sprite();
			sp.x = x;
			sp.y = y;
			if (lsize > 0) {
				sp.graphics.lineStyle(lsize,lcol,lalp);
			}
			Util.fillRect(sp,0,0,w,h,col,alp);
			return sp;
		}
		public static function newRFilledSprite(x:Number, y:Number,w:Number,h:Number,r:Number,col:Number=0,alp:Number=1,lsize:Number=0,lcol:Number=0,lalp:Number=1):Sprite {
			var sp:Sprite =  new Sprite();
			sp.x = x;
			sp.y = y;
			if (lsize > 0) {
				sp.graphics.lineStyle(lsize,lcol,lalp);
			}
			Util.fillRRect(sp,0,0,w,h,r,col,alp);
			return sp;
		}
		public static function newOutlinedSprite(x:Number, y:Number,w:Number,h:Number,lsize:Number=0,lcol:Number=0,lalp:Number=1):Sprite {
			var sp:Sprite =  new Sprite();
			sp.x = x;
			sp.y = y;
			Util.drawRect(sp,0,0,w,h,lsize,lcol,lalp);
			return sp;
		}
		public static function newButton( x:Number, y:Number, w:Number,h:Number,str:String):Button {
			var butt:Button =  new Button();
			butt.x = x;
			butt.y = y;
			butt.setSize(w,h);
			butt.label = str;
			return butt;
		}
		public static function newLabel(x:Number,y:Number,str:String, size:Number, bold:Boolean = false, underline:Boolean = false,col:Number=0,center:Boolean = false,w:Number = 0):Label {
			var lbl:Label = new Label();
			lbl.text = str;
			lbl.x = x;
			lbl.y = y;
			var tf:TextFormat = new TextFormat();
			tf.font = new TWCenMT().fontName;
			tf.size = size;
			tf.bold = bold;
			tf.color = col;
			if(center){
				tf.align = TextAlign.CENTER;
				lbl.autoSize = "center";
				lbl.width = w;
				lbl.wordWrap = true;
			}
			tf.underline = underline;

			lbl.textField.background = false;
			lbl.textField.antiAliasType = AntiAliasType.ADVANCED;
			lbl.autoSize = TextFieldAutoSize.LEFT;
			lbl.setStyle("embedFonts", true);
			lbl.setStyle("textFormat", tf);
			return lbl;
		}
		public static function newTextInput(x:Number,y:Number,w:Number,h:Number,str:String=null,size:Number = 17):TextInput {
			var txt:TextInput = new TextInput();
			Util.adjust(txt,x,y,w,h);
			var tf:TextFormat = new TextFormat();
			tf.font = new TWCenMT().fontName;
			tf.size = size;
			if(str!= null){
				txt.text = str;
			}

			txt.textField.background = true;
			txt.textField.backgroundColor = Util.bgColor;
			txt.textField.antiAliasType = AntiAliasType.ADVANCED;
			txt.setStyle("embedFonts", true);
			txt.setStyle("textFormat", tf);
			return txt;
		}
		public static function newTextArea(x:Number,y:Number,w:Number,h:Number,str:String=null):TextArea {
			var txt:TextArea = new TextArea();
			Util.adjust(txt,x,y,w,h);
			var tf:TextFormat = new TextFormat();
			if(str!= null){
				txt.text = str;
			}
			tf.font = new TWCenMT().fontName;
			tf.size = 17;
			txt.textField.background = true;
			txt.textField.backgroundColor = Util.bgColor;
			txt.textField.antiAliasType = AntiAliasType.ADVANCED;
			txt.setStyle("embedFonts", true);
			txt.setStyle("textFormat", tf);			
			return txt;
		}
		public static function newComboBox(x:Number,y:Number,w:Number,h:Number,arr:Array=null,str:String=null):ComboBox {
			var cmb:ComboBox = new ComboBox();
			Util.adjust(cmb,x,y,w,h);
			if(arr!=null){
				for(var i:Number = 0; i < arr.length;i++){					
					cmb.addItem({"label":arr[i],"data":arr[i]});
				}
				if(str!=null){					
					for(i = 0; i < arr.length;i++){					
						if(cmb.getItemAt(i)["data"] == str){
							cmb.selectedIndex = i;
							break;
						}
					}
				}
			}
			return cmb;
		}
		public static function newDataGrid(x:Number, y:Number, w:Number,h:Number,arr:Array,editable:Boolean=true):DataGrid {
			var dg:DataGrid =  new DataGrid();
			dg.move(x,y);
			dg.setSize(w,h);
			dg.editable = editable;
			for (var i:Number = 0; i < arr.length; i++) {
				dg.addColumn(arr[i]);
			}
			dg.graphics.beginFill(0x999999,1);
			dg.graphics.drawRect(0,0,w,h+1);
			dg.graphics.endFill();
			var sprite:Sprite= new Sprite();
			sprite.x = w;
			sprite.graphics.beginFill(0,1);
			sprite.graphics.drawRect(0,0,2,h+1);
			sprite.graphics.endFill();
			dg.addChild(sprite);
			return dg;
		}
		public static function newDataGridColumn(handle:String, header:String, sortable:Boolean = false,editable:Boolean=true):DataGridColumn {
			var col:DataGridColumn = new DataGridColumn(handle);
			col.headerText = header;
			col.sortable = sortable;
			col.editable = editable;
			return col;
		}

		public static function adjust(disp:DisplayObject,x:Number,y:Number,w:Number=-1,h:Number=-1) {
			disp.x = x;
			disp.y = y;
			if (w != -1) {
				disp.width = w;
			}
			if (h != -1) {
				disp.height = h;
			}
		}

		public static function newProgressBar(x:Number,y:Number,w:Number,h:Number):ProgressBar {
			var inp:ProgressBar = new ProgressBar();
			inp.x = x;
			inp.y = y;
			inp.width = w;
			inp.height = h;
			return inp;
		}
		public static function trim(str:String):String {
			for (var i:Number = 0; str.length != 0 && (str.charAt(i) == " " || str.charAt(i) == "\n"); ) {
				str = str.substr(1);
			}
			for (i= str.length-1; str.length != 0 && (str.charAt(i) == " " || str.charAt(i) == "\n"); i--) {
				str = str.substr(0,str.length - 1);
			}
			return str;
		}
		public static function replace(str:String,what:String, replacement:String):String {
			var newStr:String = "";
			for (var i = str.length-1; i >=0; i--) {
				newStr=(str.charAt(i) == what?replacement:str.charAt(i))+newStr;
			}
			return newStr;
		}
		public static function valParam(str:String):String {
			return replace(str," ","%20")+"&p="+Math.random()*10000;
		}

		public static function newButtonSprite(x:Number,y:Number,w:Number,h:Number,fun:Function = null,txt:String="",lblX:Number=0,lblY:Number=0,size:Number = 13,col1:Number=Util.yellow,col2:Number=0):Sprite {
			var but1:Sprite = Util.newRFilledSprite(x,y,w,h,5,col1);
			var lbl:Label = new Label();
			var tf:TextFormat = new TextFormat();
			tf.font = new TWCenMT().fontName;
			tf.size = size;
			tf.bold = true;
			tf.color = col2;
			lbl.textField.antiAliasType = AntiAliasType.ADVANCED;
			lbl.autoSize = TextFieldAutoSize.LEFT;
			lbl.setStyle("embedFonts", true);
			lbl.setStyle("textFormat", tf);
			lbl.text = txt;
			lbl.x = lblX;
			lbl.y = lblY;
			but1.addChild(lbl);			
			but1.buttonMode = true;
			but1.addEventListener(MouseEvent.MOUSE_OVER,butOver);
			but1.addEventListener(MouseEvent.MOUSE_UP,butOver);
			but1.addEventListener(MouseEvent.MOUSE_OUT,butOut);
			but1.addEventListener(MouseEvent.MOUSE_DOWN,butDown);
			but1.addEventListener(MouseEvent.CLICK,butClick);
			function butOver(e:MouseEvent) {
				but1.graphics.clear();
				Util.fillRRect(but1,0,0,w,h,5,col1);
				tf.color = col2;
				tf.underline = true;
				lbl.setStyle("textFormat", tf);
			}
			function butOut(e:MouseEvent) {
				but1.graphics.clear();
				Util.fillRRect(but1,0,0,w,h,5,col1);
				tf.color = col2;
				tf.underline = false;
				lbl.setStyle("textFormat", tf);
			}
			function butDown(e:MouseEvent) {
				but1.graphics.clear();
				Util.fillRRect(but1,0,0,w,h,5,col2);
				tf.color = col1;
				tf.underline = false;
				lbl.setStyle("textFormat", tf);
			}
			function butClick(e:MouseEvent) {
				trace(fun);
				if (fun != null) {
					fun();
				}
			}
			return but1;
		}
		public static function newURLRequest(loc:String,compFun:Function=null,
		disp:DisplayObjectContainer=null,x:Number=0,y:Number=0,w:Number=1366,h:Number=655) {
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,loadComp);
			loader.addEventListener(IOErrorEvent.IO_ERROR,loadIOError);
			var screen:Sprite =	Util.newLoadingScreen(x,y,w,h);
			if (disp != null) {
				disp.addChild(screen);
			}
			function loadComp(e:Event) {
				if (compFun != null) {
					compFun(loader.data,removeFun);
				}
				function removeFun(){			
					if(disp!=null){
						disp.removeChild(screen);
					}
				}
			}
			function loadIOError(e:IOErrorEvent) {
				screen.addChild(Util.newLabel(w/2-21,(h-90)/2,"IOError",13));
				screen.addChild(Util.newButton(w/2-20,(h-60)/2+2,40,20,"Retry"));
			}
			var string:String = Util.valParam(loc);
			trace(string);
			loader.load( new URLRequest( string ) );
		}
		public static function newProgressScreen(x:Number,y:Number,w:Number,h:Number, 
												 txt:String="Loading", txtX:Number = 0,txtY:Number = 0):Sprite{
			var screen:Sprite = Util.newFilledSprite(x,y,w,h,0);
			var lbl:Label = Util.newLabel(txtX,txtY,txt,25,false,false,Util.yellow);
			screen.addChild(lbl);
			lbl.addEventListener(Event.ENTER_FRAME,enterFrameEvent);
			var frame:Number = 0;
			function enterFrameEvent(e:Event){
				lbl.text = txt;
				for(var i:Number = 0; i < int(frame/10); i++){
					lbl.text+=".";
				}
				frame = (frame+1)%40;
			}
			return screen;
		}
		public static function newLoadingScreen(x:Number,y:Number,w:Number,h:Number){
			return newProgressScreen(x,y,w,h,"Loading",x+(w-100)/2+17,y+(h-140)/2);
		}
	}
}