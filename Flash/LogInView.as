package  {
	import flash.display.MovieClip;
	import fl.controls.TextInput;
	
	public class LogInView extends MovieClip{

		public function LogInView(x:Number, y:Number, w:Number,h:Number,us:Function,ad:Function) {
			Util.adjust(this,x,y);
			Util.fillRect(this,0,0,w,h,Util.bgColor);
			Util.fillRect(this,(w-400)/2,(h-300)/2-50,400,200,Util.darkGray);
			addChild(Util.newLabel(0,100,"Log In to edit games!",35,false,false,Util.yellow,true,w));
			var un:TextInput = Util.newTextInput(565,154,230,25);
			var pw:TextInput = Util.newTextInput(565,204,230,25);
			addChild(Util.newLabel(450,150,"Username:",25,false,false,Util.yellow));
			addChild(Util.newLabel(450,200,"Password:",25,false,false,Util.yellow));
			addChild(un);
			addChild(pw);
			var user = Util.newButtonSprite((w-70)/2-40,250,70,25,us,"User",10,0,20);
			addChild(user);
			var admin = Util.newButtonSprite((w-70)/2+40,250,70,25,ad,"Admin",7,0,20);
			addChild(admin);
			pw.displayAsPassword = true;
		}

	}
	
}
