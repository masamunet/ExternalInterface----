package
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;

	public class JavascriptTool extends EventDispatcher
	{
		public static const DO_HOGEHOGE:String = "doHogehoge";
		public static const DO_FUGAFUGA:String = "doFugafuga";
		
		private static var _instance:JavascriptTool;
		
		private var _jsNamespace:String;
		
		public static function getInstance(jsNamespace:String = null):JavascriptTool
		{
			if(!JavascriptTool._instance){
				JavascriptTool._instance = new JavascriptTool(new Enforcer());
				if(!jsNamespace){
					throw new JsNamespaceError("Javascriptと連携する名前空間を指定してください。");
				}else{
					JavascriptTool._instance._jsNamespace = jsNamespace;
				}
				try{
					ExternalInterface.addCallback("jsHoge", JavascriptTool._instance.hogehoge);
					ExternalInterface.addCallback("jsFuga", JavascriptTool._instance.fugafuga);
				}catch(error:Error){
					
				}
			}
			return JavascriptTool._instance;
		}
		
		public function ready():void
		{
			try{
				ExternalInterface.call(_jsNamespace + ".ready");
			}catch (error:Error){
				
			}
		}
		
		public function hogehoge():void
		{
			dispatchEvent(new Event(DO_HOGEHOGE));
		}
		
		public function fugafuga():void
		{
			dispatchEvent(new Event(DO_FUGAFUGA));
		}
		
		function JavascriptTool(enforcer:Enforcer):void{}
	}
}
class Enforcer{}
class JsNamespaceError extends Error{
	public function JsNamespaceError(message:String):void
	{
		super(message);
	}
}