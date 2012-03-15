package components
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	
	import org.as3wavsound.WavSound;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	
	public class CustomSound extends EventDispatcher {
		
		private var _id:int;
		private var _queueId:int;
		private var _soundPath:String;
		var soundChannel:SoundChannel;
		private var _sound:Sound;
		private var encoder:WaveEncoder;
		private var _loop=false;
		
		public function CustomSound(soundId:int,stream:URLRequest=null, context:SoundLoaderContext=null){
			if(stream!=null){
				_sound=new Sound(stream, context);
				_soundPath=stream.url;
			}
			id=soundId;
			soundChannel=new SoundChannel();
		}
		
		public function set sound(s:Sound):void{
			_sound=s;
		}
		
		public function get sound():Sound{
			return _sound;
		}
		
		public function set id(num:int):void{
			_id=num;
		}
		
		public function get id():int{
			return _id;
		}
		
		public function set queueId(num:int):void{
			_queueId=num;
		}
		
		public function get queueId():int{
			return _queueId;
		}
		
		public function set loop(l:Boolean):void{
			_loop=l;
		}
		
		public function get loop():Boolean{
			return _loop;
		}
		
		public function get path():String{
			return _soundPath;
		}
		
		public function playSound(l:Boolean=false):void{
			loop=l;
			soundChannel=_sound.play();	
			soundChannel.addEventListener(Event.SOUND_COMPLETE, soundCompleteListener, false, 0, true);
		}
		
		public function stopSound():void{
			soundChannel.stop();	
			dispatchEvent(new CustomSoundEvent(CustomSoundEvent.STOPED, this.id));
		}
		
		private function soundCompleteListener(e:Event):void {
			dispatchEvent(new CustomSoundEvent(CustomSoundEvent.COMPLETE, this.id));			
		}
		
		public function clone():Sound{
			var sndBytes:ByteArray=new ByteArray();
			encoder = new WaveEncoder( 0.5 );
			
			var extract:Number = Math.floor ((sound.length/1000)*44100);
			var lng:Number = sound.extract(sndBytes,extract);
			var player:WavSound = new WavSound(encoder.encode(sndBytes, 2));
			return player as Sound;
		}
		
		
		
		
	}
}