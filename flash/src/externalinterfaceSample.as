package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class externalinterfaceSample extends Sprite
	{
		private static const _DEFAULT_JS_NAMESPACE:String = "hogehoge_msturi";
		public function externalinterfaceSample()
		{
			if(stage){
				_init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE, _init);
			}
		}
		
		private function _init(e:Event = null):void
		{
			if(!(!e)){
				removeEventListener(Event.ADDED_TO_STAGE, _init);
			}
			
			var tf:TextField = new TextField();
			tf.border = true;
			tf.autoSize = TextFieldAutoSize.LEFT;
			addChild(tf);
			
			var jsNamespace:String = _DEFAULT_JS_NAMESPACE;
			var flashVars:Object = stage.loaderInfo.parameters;
			if(!(!flashVars.jsNamespace) && flashVars.jsNamespace.length > 0){
				jsNamespace = flashVars.jsNamespace;
			}
			var jsTool:JavascriptTool = JavascriptTool.getInstance(jsNamespace);
			jsTool.ready();
			
			tf.text = "Javascriptからの呼び出しが実行可能になった。";
			
			jsTool.addEventListener(JavascriptTool.DO_HOGEHOGE, function(e:Event):void{
				tf.text = "JavascriptからjsHogeが呼び出された。";
			});
			jsTool.addEventListener(JavascriptTool.DO_FUGAFUGA, function(e:Event):void{
				tf.text = "JavascriptからjsFugaが呼び出された。";
			});
		}
	}
}