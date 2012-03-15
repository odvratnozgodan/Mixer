package components
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	
	import org.as3wavsound.WavSound;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	
	public class CustomSoundNew extends Sound {
		
		private var _id:int;
		private var _queueId:int;
		private var _soundPath:String;
		private var _offset:int;
		var soundChannel:SoundChannel;
//		private var _sound:Sound;
		private var encoder:WaveEncoder;
		private var _loop=false;
		private var sndTransform:SoundTransform;
		private var _sndBytes:ByteArray;
		
		public function CustomSoundNew(soundId:int=0,startOffset:int=0,stream:URLRequest=null, context:SoundLoaderContext=null){
			
			if(stream!=null){
				super(stream, context);
				this.addEventListener(Event.COMPLETE, soundLoadedHandler);
				_soundPath=stream.url;
			}
			id=soundId;
			offset=startOffset;
			soundChannel=new SoundChannel();
			sndTransform = new SoundTransform();
			sndTransform.volume = 0.2;
			soundChannel.soundTransform = sndTransform;
		}
		
		public function set sound(s:CustomSoundNew):void{
			this=s;
		}
		
		public function get sound():CustomSound{
			return this;
		}
		
		public function set id(num:int):void{
			_id=num;
			
		}
		
		public function get id():int{
			return _id;
		}
		
		public function set offset(num:int):void{
			_offset=num;
		}
		
		public function get offset():int{
			return _offset;
		}
		
		public function set queueId(num:int):void{
			_queueId=num;
		}
		
		public function set soundBytes(b:ByteArray):void{
			_sndBytes=b;
		}
		
		public function get soundBytes():ByteArray{
			return _sndBytes;
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
			if(loop){
				soundChannel=_sound.play(offset,100000);
			}else{
				soundChannel=_sound.play(offset);
			}
			sndTransform.volume = 0.2;
			soundChannel.soundTransform = sndTransform;
			soundChannel.addEventListener(Event.SOUND_COMPLETE, soundCompleteListener, false, 0, true);
		}
		
		public function stopSound():void{
			soundChannel.stop();	
			dispatchEvent(new CustomSoundEvent(CustomSoundEvent.STOPED, this.id));
		}
		
		private function soundCompleteListener(e:Event):void {
			trace(sound.length)
			dispatchEvent(new CustomSoundEvent(CustomSoundEvent.COMPLETE, this.id));			
		}
		
		public function clone():Sound{
			var sndBytes:ByteArray=new ByteArray();
			encoder = new WaveEncoder( 0.5 );
			
			var extract:Number = Math.floor ((sound.length/1000)*44100);
			var lng:Number = sound.extract(sndBytes,extract);
			trace("extract="+extract)
			trace("sndBytes.position="+sndBytes.position)
			trace("sndBytes.length="+sndBytes.length)
			trace("sndBytes.bytesAvailable="+sndBytes.bytesAvailable)
			var player:WavSound = new WavSound(encoder.encode(sndBytes, 2));
			return player as Sound;
		}
		
		public function extractByteArray():void{
			var sndBytes:ByteArray=new ByteArray();
			encoder = new WaveEncoder( 0.5 );
			
			var extract:Number = Math.floor ((sound.length/1000)*44100);
			var startPos:Number = Math.floor ((offset/1000)*44100);
			var lng:Number = sound.extract(sndBytes,extract);
			
			soundBytes=sndBytes;
		}
		
		function soundLoadedHandler(e:Event):void{
			sound.removeEventListener(Event.COMPLETE, soundLoadedHandler);
			extractByteArray();
		}
		
		
	}
}