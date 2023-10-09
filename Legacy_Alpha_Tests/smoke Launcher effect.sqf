
private _fnc = 
{
	private ["_v","_shells","_num","_vel","_useTDir","_angle","_dir","_deltaDir","_arc","_initDist","_posV","_Vdir","_vH","_vV","_smokeg"];
	
	_v = _this select 0;
	_sleepRandom = _this select 1;
	_shells = [];
	
	//Read values from config

	_num=3;
	_vel=14;
	_useTDir=1;
	_angle=90;

	if (_num>0) then
	{
		_dir = direction _v;
		if ((_useTDir==1) && (count weapons _v > 0)) then
		{
			_dir = _v weaponDirection ((weapons _v) select 0);
			_dir = (((_dir select 0) atan2 (_dir select 1))+360)%360;
		};

		_deltaDir = _angle/_num;			//degrees between grenades.
		_arc = _deltaDir*(_num-1);		//total arc to cover, in degrees

		//distance from vehicle center where grenades are created; base it on vertical height
		_initDist = (((boundingBox _v) select 1) select 2)-(((boundingBox _v) select 0) select 2);

		//sleep 0.25;
		_posV = visiblePositionASL _v;
		_Vdir = 30;	                     //angle of elevation. Temporary: launch all grenades at same angle
		//derive velocity
		_vH = _vel * cos _Vdir;          //horizontal component of velocity
		_vV = _vel * sin _Vdir;          //vertical component


		for "_i" from 0 to (_num - 1) do
		{
			//find starting parameters
			_Hdir = ((_i*_deltaDir)+_dir) - _arc/2; //relative direction around vehicle


			_Gvel = [_vH *sin(_Hdir), _vH*cos (_Hdir), _vV]; //initial grenade velocity

			//find starting position for grenades
			_pH = _initDist * cos _Vdir;     //initial distance horizontally away from vehicle center to create grenade
			_pV = _initDist * sin _Vdir;     //vertical distance

			//create / launch the grenade
			_smokeg = "SmokeShellVehicle" createVehicleLocal [0,0,0];
			[_smokeg,_sleepRandom] spawn 
			{
				params ['_smokeg','_sleepRandom'];
				sleep _sleepRandom;
				if (!isNull _smokeg) then {
					deleteVehicle _smokeg;
				};
			};
			_smokeg setPosASL [(_pH * sin _Hdir) + (_posV select 0), (_pH * cos _Hdir)+ (_posV select 1), _pV+ (_posV select 2)];
			_smokeg setVectorUp (_Gvel call BIS_fnc_unitVector);
			_smokeg setVelocity _Gvel;
			_shells set [count _shells, _smokeg];
		};

		//z: only one spawned thread for grenades, should improve scripting performance when there are lots of smoke grenades launched simultanously.
		[_shells,_sleepRandom] spawn 
		{
			params ['_shells','_sleepRandom'];
			scriptName "fn_effectFiredSmokeLauncher_shellLoop";
			private ["_sources","_source2","_source3"];
			_sources = [];
			sleep 0.7;
			
			_smokeColor_green = [[0, 1, 0, 0.7],[0, 1, 0, 0.5], [0, 1, 0, 0.25], [0, 1, 0, 0.8]];
			_smokeColor_blue = [[0, 0, 1, 0.7],[0, 0, 1, 0.5], [0, 0, 1, 0.25], [0, 0, 1, 0.8]];
			_smokeColor_purple = [[1, 0, 1, 0.7],[1, 0, 1, 0.5], [1, 0, 1, 0.25], [1, 0, 1, 0.8]];
			_smokeColor_white = [[1, 1, 1, 0.7],[1, 1, 1, 0.5], [1, 1, 1, 0.25], [1, 1, 1, 1]];
			
			_smokeSize_small = [0.05, 0.8, 1.2, 1.5];
			_smokeSize_default = [0.5, 8, 12, 15];
			
			_smokeLifetime_d = 10;
			_smokeLifetime_short = 1;
			
			_smokeWeight_d = 1.277;
			_smokeWeight_heavy = _smokeWeight_d * 2;
			
			_smokeColor = _smokeColor_green;
			_smokeWeight = _smokeWeight_d;
			
			{
				_source2 = "#particlesource" createVehicleLocal getpos _x;
				_source2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7, 48, 1], "", "Billboard", 1, _smokeLifetime_d, [0, 0, 0],
							[0, 0, 0], 0, _smokeWeight, 1, 0.025, _smokeSize_default, _smokeColor,
							[0.2], 1, 0.04, "", "", _x];
				_source2 setParticleRandom [2, [0.3, 0.3, 0.3], [1.5, 1.5, 1], 20, 0.2, [0, 0, 0, 0.1], 0, 0, 360];
				_source2 setDropInterval 0.2;
				_sources set [count _sources,_source2];

				_source3 = "#particlesource" createVehicleLocal getpos _x;
				_source3 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 7, 0], "", "Billboard", 1, (_smokeLifetime_d / 2), [0, 0, 0],
							[0, 0, 0], 0, _smokeWeight, 1, 0.025, _smokeSize_default, _smokeColor,
							[0.2], 1, 0.04, "", "", _x];
				_source3 setParticleRandom [2, [0.3, 0.3, 0.3], [1.5, 1.5, 1], 20, 0.2, [0, 0, 0, 0.1], 0, 0, 360];
				_source3 setDropInterval 0.15;
				_sources set [count _sources,_source3];
			} forEach _shells;
			
			sleep _sleepRandom;
			{deleteVehicle _x} forEach _sources;
		};
	};


};

JAM_REfnc_smokeLauncherFX = ['asdasd', _fnc];

publicVariable 'JAM_REfnc_smokeLauncherFX';

if (!isNil 'action_smokeLauncher') then {
	player removeAction action_smokeLauncher;
};
action_smokeLauncher = player addAction ['Fire Smoke Launcher',
{
	[[vehicle player,(55+random 3)],
	{
		_this spawn (JAM_REfnc_smokeLauncherFX # 1);
	}] remoteExec ['spawn'];
}];