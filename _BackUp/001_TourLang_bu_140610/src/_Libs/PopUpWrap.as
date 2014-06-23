package
{
	import core.IPopUp;
	import core.IWrap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import hb.useful.PanelLayer;
	import hbworks.uilogics.CheckList;
	import hbworks.uilogics.events.CheckListEvent;
	
	/**
	 * ...
	 * @author HobisJung
	 */
	public final class PopUpWrap implements IWrap, IPopUp
	{
		// :: 생성자
		public function PopUpWrap(owner:MovieClip) 
		{
			this._owner = owner;
			this._owner.visible = false;
			
			this.p_init_once();
		}
		
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//// # 초기화 설정 부분
		////////////////////////////////////////////////////////////////////////////////////////////////////
		// -
		private var _owner:MovieClip = null;
		
		// :: 참고한 객체 반환
		public function get_owner():MovieClip
		{
			return this._owner;
		}
		
		
		// -
		private var _onCallBack:Function = null;
		
		// :: 콜백 함수 반환
		public function get_onCallBack():Function
		{
			return this._onCallBack;
		}
		
		// :: 콜백 함수 설정
		public function set_onCallBack(onCallBack:Function):void
		{
			this._onCallBack = onCallBack;
		}
		
		// :: 콜백 함수 호출
		public function dispatchCallBack(eventObj:Object):void
		{
			if (this._onCallBack != null)
			{
				this._onCallBack(eventObj);
			}
		}
		
		
		// :: 객체 비움
		public function clear():void
		{
			this._owner = null;
		}
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// - 메시지 참조
		private var _tempMsg:String = null;
		
		// :: 팝업 초기화
		public function reset(pi:MovieClip):void
		{
			switch (pi)
			{
				case this._owner.pi_1:
				{
					this.p_alert_reset();
					
					break;
				}

				case this._owner.pi_2:
				{
					this.p_new_reset();
					
					break;
				}
				
				case this._owner.pi_3:
				{
					this.p_info_reset();
					
					break;
				}
				
				case this._owner.pi_4:
				{
					this.p_confirm_reset();
					
					break;
				}
			}
		}		
		
		// :: 팝업 닫기
		public function close():void
		{
			this._owner.visible = false;
			
			this._panelLayer.unselect();
			this.reset(this._panelLayer.get_nowPanel());			
		}
		
		// :: 팝업 열기
		public function open(type:String):void
		{
			var t_pi:MovieClip = null;
			var t_tf:TextField = null;
			
			switch (type)
			{
				// 알림 패널
				case '#_1':
				{
					this._panelLayer.select(1);
					this._owner.visible = true;
					
					break;
				}
				
				// 정보입력 패널
				case '#_2':
				{
					this._panelLayer.select(2);
					this._owner.visible = true;
					
					break;
				}
				
				// 프로그램정보 패널
				case '#_3':
				{
					this._panelLayer.select(3);
					this._owner.visible = true;
					
					break;
				}
				
				// 확인 패널
				case '#_4':
				{
					if (this._tempMsg != null)
					{
						t_pi = this._panelLayer.get_nowPanel();
						t_tf = t_pi.body_tf;
						t_tf.text = this._tempMsg;
					}
					
					this._panelLayer.select(4);
					this._owner.visible = true;					
					
					break;
				}		
			}
		}
		
		
		// - 패널레이어 객체
		private var _panelLayer:PanelLayer = null;
		
		// :: 한번만 초기화
		private function p_init_once():void
		{
			this._panelLayer = new PanelLayer(this._owner, 'pi_');
						
			this.p_alert_init();
			this.p_new_init();
			this.p_info_init();
			this.p_confirm_init();
		}
		
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//// # 알림 패널
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// :: 알림 패널 닫기 핸들러
		private function p_alert_close_click(event:MouseEvent):void
		{
			this.close();
		}
		
		// :: 알림 패널 확인 핸들러
		private function p_alert_confirm_click(event:MouseEvent):void
		{
			this.p_alert_close_click(null);
		}		
		
		// :: 알림 패널 초기화
		private function p_alert_reset():void
		{
			var t_pi:MovieClip = this._owner.pi_1;
			var t_tf:TextField = t_pi.body_tf;
			t_tf.text = '';
		}
		
		// :: 알림 패널 한번 초기화
		private function p_alert_init():void
		{
			var t_pi:MovieClip = null;
			var t_mc:MovieClip = null;
			var t_bt:SimpleButton = null;
			
			// 패널 아이템
			t_pi = this._owner.pi_1;
			
			// 닫기
			t_bt = t_pi.close_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_alert_close_click);
			
			// 확인
			t_bt = t_pi.confirm_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_alert_confirm_click);
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//// # 정보입력 패널
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// :: 정보입력 패널 닫기 핸들러
		private function p_new_close_click(event:MouseEvent):void
		{
			this.close();
		}
		
		// :: 정보입력 패널 레이어타입 변경 핸들러
		private function p_new_layerType_change(event:CheckListEvent):void
		{
			var t_cl:CheckList = CheckList(event.currentTarget);
			this._layerTypeIndex = t_cl.selectedIndex;
		}
		
		// :: 정보입력 패널 확인 핸들러
		private function p_new_confirm_click(event:MouseEvent):void
		{
			this.p_new_close_click(null);
			
			
			var t_pi:MovieClip = this._owner.pi_2;
			var t_tf:TextField = null;
			
			
			var t_dataObj:Object = {};
			
			// 이름
			t_tf = t_pi.name_tf;
			t_dataObj.name = t_tf.text;
			
			// 타이틀
			t_tf = t_pi.title_tf;
			t_dataObj.title = t_tf.text;
			
			// 레이어 타입
			switch (this._layerTypeIndex)
			{
				// 32강 선택
				case 0:
				{
					t_dataObj.layerType = '32';
					
					break;
				}

				// 16강 선택
				case 1:
				{
					t_dataObj.layerType = '16';
					
					break;
				}

				// 08강 선택
				case 2:
				{
					t_dataObj.layerType = '8';
					
					break;
				}

				// 04강 선택
				case 3:
				{
					t_dataObj.layerType = '4';
					
					break;
				}
			}
			
			// 아이템 배열
			t_dataObj.items = [];			
			for
			(
				var
					t_la:uint = uint(t_dataObj.layerType),
					i:uint = 0;
					
				i < t_la; i++
			)
			{
				t_dataObj.items.push({name: ''});
			}
			
			if
			(
				(t_dataObj.name != undefined) &&
				(t_dataObj.title != undefined) &&
				(t_dataObj.layerType != undefined) &&
				(t_dataObj.items != undefined)
			)
			{
				this.p_layer_reset();
				t_dataObj.d_isNew = true;
				this.m_dataObj = t_dataObj;
				this.p_layer_checkGoto();
			}
			
			
			this.dispatchCallBack({
				type: 'new_confirm',
				dataObj: t_dataObj
			});
		}
		
		// :: 정보입력 패널 취소 핸들러
		private function p_new_cancel_click(event:MouseEvent):void
		{
			this.p_new_close_click(null);
		}		
		
		// :: 정보입력 패널 리셋
		private function p_new_reset():void
		{
			var t_pi:MovieClip = this._owner.pi_2;
			var t_tf:TextField = null;
			var t_cl:CheckList = null;

			t_tf = t_pi.name_tf;
			t_tf.text = MainProxy.NEW_PROJECT_NAME;
			t_tf = t_pi.title_tf;
			t_tf.text = MainProxy.NEW_TITLE_NAME;

			t_cl = t_pi.d_layerType_cl;
			t_cl.selectedIndexDispatch = 0;
		}		
		
		// - 
		private var _layerTypeCheckList:CheckList = null;
		// -
		private var _layerTypeIndex:int;
		
		// :: 정보입력 패널 한번 초기화
		private function p_new_init():void
		{
			var t_pi:MovieClip = null;
			var t_mc:MovieClip = null;
			var t_bt:SimpleButton = null;
			var t_tf:TextField = null;
			
			// 패널 아이템
			t_pi = this._owner.pi_2;
			
			// 닫기
			t_bt = t_pi.close_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_new_close_click);
			
			
			// 프로젝트 네임 설정
			t_tf = t_pi.name_tf;
			t_tf.text = MainProxy.NEW_PROJECT_NAME;
			t_tf.maxChars = 18;
			
			
			// 타이틀 네임 설정
			t_tf = t_pi.title_tf;
			t_tf.text = MainProxy.NEW_TITLE_NAME;
			t_tf.maxChars = 38;
			
			
			// 토너먼트 타임 체크리스트 객체 설정
			const t_sels:Array =
			[
				t_pi.sel_1,
				t_pi.sel_2,
				t_pi.sel_3,
				t_pi.sel_4
			];
			this._layerTypeCheckList = new CheckList(t_sels);
			this._layerTypeCheckList.addEventListener(CheckListEvent.CHANGE, this.p_new_layerType_change);
			this._layerTypeIndex = 0;
			this._layerTypeCheckList.selectedIndexDispatch = this._layerTypeIndex;
			
			
			// 확인
			t_bt = t_pi.confirm_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_new_confirm_click);
			
			
			// 취소
			t_bt = t_pi.cancel_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_new_cancel_click);			
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//// # 프로그램정보 패널
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// :: 프로그램정보 패널 리셋
		private function p_info_reset():void
		{
		}		
		
		// :: 프로그램정보 패널 한번만 초기화
		private function p_info_init():void
		{
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//// # 확인 패널
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// :: 확인 패널 리셋
		private function p_confirm_reset():void
		{
		}
		
		// :: 확인 패널 한번만 초기화
		private function p_confirm_init():void
		{
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
