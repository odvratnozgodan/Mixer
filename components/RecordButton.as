package components
{
	import flash.display.MovieClip;
	
	public class RecordButton extends MovieClip	{
		
		public function RecordButton()
		{
			super();
			init();
		}
		
		private function init():void{
			gotoAndStop("_off");
			this.buttonMode=true;
			this.mouseChildren=false;
		}
	}
}