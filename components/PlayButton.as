package components
{
	import flash.display.MovieClip;
	
	public class PlayButton extends MovieClip{
		
		public function PlayButton()
		{
			super();
			init();
		}
		
		private function init():void{
			gotoAndStop("_off");
			this.buttonMode=true;
			this.mouseChildren=false;
			this.alpha=0.2;
		}
	}
}