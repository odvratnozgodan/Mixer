package components {
//	import components.PanningEvent;
//	import components.SoundButtonEvent;
//	import components.VolumeEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class SoundButton extends MovieClip {
		
		private var _id:int;
		private var title:String;
		private var key:String;
		private var _looping:Boolean;
		private var _percentage:Number;
		private var _volume:Number;
		private var _panning:Number;
		private var _playingState:Boolean;
		private var _delayTimer:Timer;
		
		
		public function SoundButton(id:int, title:String, key:String, looping:Boolean, volume:Number = 1, panning:Number = 0 ) {
			//super();
			stop();
			_id = id;
			this.title = title;
			this.key = key;
			_looping = looping;
			_volume = volume;
			_panning = panning;
			_playingState=false;
			_delayTimer=new Timer(100);
			_delayTimer.addEventListener(TimerEvent.TIMER, delayElapsed);
			
			// Set the volume and panning sliders.
			this.volume = _volume;
			this.panning = _panning;
			// Hide text and type icon until the init function has been called.
			_title.visible = false;
			_key.visible = false;
			_typeIcon.visible = false;
			// Set the progress bar's bar to x scale of 0 by default
			_progressBar._bar.scaleX = 0;
			// Stop mouse input until initialized.
			mouseChildren = false;
			init();
		}
		public function init():void {
			gotoAndStop("_off");
			// Re-enable mouse input.
			mouseChildren = true;
			// Hide the progress bar
			_progressBar.visible = false;
			// Unhide the text and type icon.
			_title.visible = true;
			_key.visible = true;
			_typeIcon.visible = true;
			// Set the type icon to looping or standard.
			if (looping) {
				_typeIcon.gotoAndStop("_loop");
			} else {
				_typeIcon.gotoAndStop("_sound");
			}
			var titleTF:TextField = _title._textField as TextField;
			var keyTF:TextField = _key._textField as TextField;
			titleTF.text = title;
			keyTF.text = String(key).toUpperCase();
			_hitArea = _hitArea as MovieClip;
			_hitArea.buttonMode = true;
			// Add event listeners to the sliders
			
			_horizontalSlider.visible=false;
			_verticalSlider.visible=false;
			
			_horizontalSlider.addEventListener(Event.CHANGE, panningChangeListener, false, 0, true);
			_verticalSlider.addEventListener(Event.CHANGE, volumeChangeListener, false, 0, true);
			_hitArea.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener, false, 0, true);
		}
		private function volumeChangeListener(e:Event):void {
			dispatchEvent(new VolumeEvent(VolumeEvent.VOLUME_CHANGE, this.id, _verticalSlider.ratio));
		}
		private function panningChangeListener(e:Event):void {
			var panning:Number = -1 + (_horizontalSlider.ratio*2);
			dispatchEvent(new PanningEvent(PanningEvent.PANNING_CHANGE, this.id, panning));
		}
		private function mouseDownListener(e:MouseEvent):void {
			dispatchEvent(new SoundButtonEvent(SoundButtonEvent.MOUSE_DOWN, this.id));
		}
		
		public function switchState():void{
			if(!_playingState){
				on();
				if(!looping){
					_delayTimer.reset();
					_delayTimer.start();
				}
				_playingState=true;
			}else{
				if(looping){
					off();
				}
				_playingState=false;				
			}
		}
		
		public function get playingState():Boolean{
			return _playingState;
		}
		
		private function delayElapsed(e:TimerEvent):void{
			_delayTimer.reset();
			off();
			_playingState=false;
		}
		
		public function set volume(value:Number):void {
			_verticalSlider.ratio = value;
		}
		public function set panning(value:Number):void {
			_horizontalSlider.ratio = 0.5+(value*0.5);
		}
		public function get id():int {
			return _id;
		}
		
		public function get keyValue():String {
			return key;
		}
		
		public function get looping():Boolean {
			return _looping;
		}
		
		public function on():void {
			gotoAndStop("_on");
		}
		public function off():void {
			gotoAndStop("_off");
		}
		public function set percentage(value:Number):void {
			_percentage = value;
			_progressBar._bar.scaleX = _percentage;
		}
		public function get percentage():Number {
			return _percentage;
		}
		// Overrides
		override public function get width():Number {
			return 97;
		}
		override public function get height():Number {
			return 97;
		}		
	}
	
}