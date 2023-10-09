JAM_EZM_fnc_timer = 
{
	params [['_seconds', 0]];
	if (_seconds <= 0) exitWith {};
	if (isNull findDisplay 46) exitWith {};
	if (isNil "isJAMEZMTimerRunning") then 
	{
		isJAMEZMTimerRunning = false;
	};
	if (isJAMEZMTimerRunning) exitWith {systemChat 'A timer is already running!';};
	isJAMEZMTimerRunning = true;
	publicVariable 'isJAMEZMTimerRunning';
	playSound "FD_Timer_F";
	playSound "Orange_PhoneCall_Accept";
	with uiNamespace do 
	{
		if (!isNil "JAM_ctrl_EZMTimer") then 
		{
			ctrlDelete JAM_ctrl_EZMTimer;
		};
		if (isNull findDisplay 312) then 
		{
			JAM_ctrl_EZMTimer = (findDisplay 46) ctrlCreate ["RscStructuredText", -1];
			JAM_ctrl_EZMTimer ctrlSetPosition [0.453 * safezoneW + safezoneX,0.00500001 * safezoneH + safezoneY,0.0928125 * safezoneW,0.088 * safezoneH];
			JAM_ctrl_EZMTimer ctrlSetBackgroundColor [0,0,0,0];
			JAM_ctrl_EZMTimer ctrlSetFade 1;
			JAM_ctrl_EZMTimer ctrlCommit 0;
			JAM_ctrl_EZMTimer ctrlSetFade 0;
			JAM_ctrl_EZMTimer ctrlCommit 1;
		} else 
		{
			_ctrlA = (findDisplay 312) displayCtrl 15513;
			_ctrlPosA = ctrlPosition _ctrlA;
			_ctrlYpos = (_ctrlPosA # 1) - 0.275;
			JAM_ctrl_EZMTimer = (findDisplay 312) ctrlCreate ["RscStructuredText", -1];
			JAM_ctrl_EZMTimer ctrlSetPosition [0.453 * safezoneW + safezoneX,_ctrlYpos,0.0928125 * safezoneW,0.088 * safezoneH];
			JAM_ctrl_EZMTimer ctrlSetBackgroundColor [0,0,0,0];
			JAM_ctrl_EZMTimer ctrlSetFade 1;
			JAM_ctrl_EZMTimer ctrlCommit 0;
			JAM_ctrl_EZMTimer ctrlSetFade 0;
			JAM_ctrl_EZMTimer ctrlCommit 1;
		};
	};
	while {_seconds > 0} do 
	{
		private _timeStr = '';
		_days        = floor(_seconds/24/60/60);
		_hoursLeft   = floor((_seconds) - (_days*86400));
		_hours       = floor(_hoursLeft/3600);
		_minutesLeft = floor((_hoursLeft) - (_hours*3600));
		_minutes     = floor(_minutesLeft/60);
		_remainingSeconds = _seconds % 60;
		if (_days > 0) then 
		{
			_s2 = if (_remainingSeconds < 10) then {('0' + (str _remainingSeconds))} else {_remainingSeconds};
			_m2 = if (_minutes < 10) then {('0' + (str _minutes))} else {_minutes};
			_h2 = if (_hours < 10) then {('0' + (str _hours))} else {_hours};
			_d2 = if (_days < 10) then {('0' + (str _days))} else {_days};
			_timeStr = format 
			[
				"%1 : %2 : %3 : %4",
				_days,
				_h2,
				_m2,
				_s2
			];
		} else 
		{
			if (_hours > 0) then 
			{
				_s2 = if (_remainingSeconds < 10) then {('0' + (str _remainingSeconds))} else {_remainingSeconds};
				_m2 = if (_minutes < 10) then {('0' + (str _minutes))} else {_minutes};
				_h2 = if (_hours < 10) then {('0' + (str _hours))} else {_hours};
				_timeStr = format 
				[
					"%1 : %2 : %3",
					_h2,
					_m2,
					_s2
				];
			} else 
			{
				if (_minutes > 0) then 
				{
					_s2 = if (_remainingSeconds < 10) then {('0' + (str _remainingSeconds))} else {_remainingSeconds};
					_m2 = if (_minutes < 10) then {('0' + (str _minutes))} else {_minutes};
					_timeStr = format 
					[
						"%1 : %2",
						_m2,
						_s2
					];
				} else 
				{
					_s2 = if (_seconds < 10) then {('0' + (str _seconds))} else {_seconds};
					_timeStr = format 
					[
						"%1",
						_s2
					];
				};
			};
		};
		COMMENT "systemChat format 
		[
			'Time remaining: %1',
			_timeStr
		];";
		with uiNamespace do 
		{
			JAM_ctrl_EZMTimer ctrlSetStructuredText parseText format 
			[
				"<t color='#FFFFFF' shadow='0' size='%3' align='center' font='PuristaBold'><t size='%4'>%2<br/><t color='#FFFFFF' shadow='1' size='%3' align='center' font='PuristaBold'>T-%1</t>", 
				_timeStr, 
				"<img image='\A3\ui_f\data\igui\cfg\actions\settimer_ca.paa'/>",
				((safezoneH * 0.5) * 1.2),
				((safezoneH * 0.5) * 2.4)
			];
			JAM_ctrl_EZMTimer ctrlCommit 0;
		};	
		uiSleep 1;
		_seconds = _seconds - 1;
	};
	if (_seconds <= 0) then 
	{
		with uiNamespace do 
		{
			if (!isNil "JAM_ctrl_EZMTimer") then 
			{
				ctrlDelete JAM_ctrl_EZMTimer;
			};
		};
		systemChat "Countdown completed.";
		playSound "FD_Timer_F";
		playSound "Orange_PhoneCall_Reject";
	} else {
		_seconds = _seconds - 1;
	}
};
[10] spawn JAM_EZM_fnc_timer;