package components {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class HorizontalSlider extends MovieClip {
		
		protected var _ratio:Number = 0;
		
		public function HorizontalSlider() {
			super();
			handle.buttonMode = true;
			handle.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener, false, 0, true);
			track.addEventListener(MouseEvent.MOUSE_DOWN, trackMouseDownListener, false, 0, true);
		}
		private function mouseDownListener(e:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveListener, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpListener, false, 0, true);
		}
		private function mouseUpListener(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveListener);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
		}
		protected function mouseMoveListener(e:MouseEvent):void {
			handle.x = mouseX;
			if (handle.x < track.x) {
				handle.x = track.x;
			} else if (handle.x > track.x + track.width) {
				handle.x = track.x + track.width;
			}
			_ratio = (handle.x - track.x) / track.width;
			e.updateAfterEvent();
			dispatchEvent(new Event(Event.CHANGE));
		}
		private function trackMouseDownListener(e:MouseEvent):void {
			mouseMoveListener(e.clone() as MouseEvent);
			mouseDownListener(e.clone() as MouseEvent);
		}
		protected function positionHandleAtRatio():void {
			handle.x = track.x + (track.width * _ratio);
		}
		public function get ratio():Number {
			return _ratio;
		}
		public function set ratio(value:Number):void {
			if (value > 1) {
				value = 1;
			} else if (value < 0) {
				value = 0;
			}
			_ratio = value;
			positionHandleAtRatio();
		}
		
	}
	
}