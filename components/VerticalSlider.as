package components {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class VerticalSlider extends MovieClip {
		
		protected var _ratio:Number = 0;
		
		public function VerticalSlider() {
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
			handle.y = mouseY;
			if (handle.y < track.y) {
				handle.y = track.y;
			} else if (handle.y > track.y + track.height) {
				handle.y = track.y + track.height;
			}
			_ratio = 1 - ((handle.y - track.y) / track.height);
			e.updateAfterEvent();
			dispatchEvent(new Event(Event.CHANGE));
		}
		private function trackMouseDownListener(e:MouseEvent):void {
			mouseMoveListener(e.clone() as MouseEvent);
			mouseDownListener(e.clone() as MouseEvent);
		}
		protected function positionHandleAtRatio():void {
			handle.y = track.y + track.height - (track.height * _ratio);
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