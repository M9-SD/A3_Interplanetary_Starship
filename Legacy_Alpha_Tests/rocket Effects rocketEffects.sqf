

RocketEngine1 = createVehicle ["Land_HeliPadEmpty_F",getPosASL JAM_mObj_rocketBase,[],0,"CAN_COLLIDE"];
RocketEngine1 attachTo [JAM_mObj_rocketBase,[0,0,5]];

_engines = [RocketEngine1];
VostokEngines = _engines;

VRL_fnc_launchEffects = 
{	
	private _object = RocketEngine1;
	
	_smokeGroup1 = [];
	_smokeGroup2 = [];

	playSound3D ["A3\Sounds_F\ambient\battlefield\battlefield_jet3.wss", _object, false, getPosATL _object, 5, 2, 10000];



	_source = createVehicle ["#particlesource",getPosATL _object,[],0,"CAN_COLLIDE"];
	
	
	
	_asfs = 
	{
		_source = _this select 0;
		_particle = _this select 1;
		_source setParticleClass _particle;
	};
	JSADYFATwaq25 = ['asd2', _asfs];
	publicVariable 'JSADYFATwaq25';
	
	
	private _fnc = 
	{
		_thrustFX1 = "#particlesource" createVehicleLocal getPosASL _this;
		_thrustFX1 setParticleCircle [0, [0, 0, 0]];
		_thrustFX1 setParticleRandom [0, [0, 0, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
		_thrustFX1 setParticleParams 
		[
			[
				"\A3\data_f\cl_exp", 
				1, 
				0, 
				1
			], 
			"", 
			"Billboard", 
			1, 
			7, 
			[0, 0, 0], 
			[0, 0, -17], 
			0, 
			5, 
			5, 
			0, 
			[25,25,25], 
			[
				[1,1,0.1, 1],
				[1, 0.01, 0.02, 1],
				[1, 0.01, 0.02, 0]
			],
			[0.02], 
			1, 
			0, 
			"", 
			"", 
			_this
		];
		_thrustFX1 setDropInterval 0.025;

		_thrustFX1 attachTo [_this,[0,0,0]];
		
	};
	
	ADHGF5377ftd = ['', _fnc];
	publicVariable 'ADHGF5377ftd';
	
	
	[[_source,'ExpSparks'],
	{
		_this spawn (JSADYFATwaq25 select 1);
	}] remoteExec ["spawn",0,_source];
	
	[_source,[_object,[0,0,0]]] remoteExec ['attachTo'];
	
	
	_smokeGroup1 pushBack _source;
	sleep 5;

	playSound3D ["A3\sounds_f\weapons\explosion\expl_big_1.wss", _object, false, getPosATL _object, 5, 0.1, 10000]; 
	playSound3D ["A3\sounds_f\weapons\heliweap\missiles_AAA.wss", _object, false, getPosATL _object, 5, 0.1, 10000];
	playSound3D ["A3\sounds_f\weapons\explosion\explosion_missile_5.wss", _object, false, getPosATL _object, 5, 0.1, 10000];
	playSound3D ["A3\sounds_f\weapons\explosion\expl_shell_6.wss", _object, false, getPosATL _object, 5, 0.1, 10000];
	playSound3D ["A3\sounds_f\arsenal\weapons_vehicles\missiles\VLS_01_Launch_03.wss", _object, false, getPosATL _object, 5, 0.1, 10000];
	playSound3D ["A3\sounds_f\arsenal\weapons_vehicles\missiles\VLS_01_Launch_02.wss", _object, false, getPosATL _object, 5, 0.1, 10000];
	
	_asfs1q2s = 
	{
		[3] call bis_fnc_earthquake;
		[1] call bis_fnc_earthquake;
	};
	JSADYF21fATwaq25 = ['arsd2', _asfs1q2s];
	publicVariable 'JSADYF21fATwaq25';
	[[],
	{
		_this spawn (JSADYF21fATwaq25 select 1);
	}] remoteExec ["spawn"];

	_source = createVehicle ["#particlesource",getPosATL _object,[],0,"CAN_COLLIDE"];
	
	
	[[_source,'BombSmk3'],
	{
		_this spawn (JSADYFATwaq25 select 1);
	}] remoteExec ["spawn",0,_source];
	
	
	[_source,[_object,[0,0,0]]] remoteExec ['attachTo'];
	_smokeGroup1 pushBack _source;

	_source = createVehicle ["#particlesource",getPosATL _object,[],0,"CAN_COLLIDE"];
	
	[[_source,'HeavyBombSmk3'],
	{
		_this spawn (JSADYFATwaq25 select 1);
	}] remoteExec ["spawn",0,_source];
	
	[_source,[_object,[0,0,0]]] remoteExec ['attachTo'];
	_smokeGroup1 pushBack _source;

	_source = createVehicle ["#particlesource",getPosATL _object,[],0,"CAN_COLLIDE"];
	
	[[_source,'ScudSmoke'],
	{
		_this spawn (JSADYFATwaq25 select 1);
	}] remoteExec ["spawn",0,_source];
	
	[_source,[_object,[0,0,0]]] remoteExec ['attachTo'];
	_smokeGroup2 pushBack _source;

	_light = createVehicle ["#lightpoint",getPosATL _object,[],0,"CAN_COLLIDE"];
	[_light,50] remoteExec ["setLightBrightness",0,_light];
	[_light,[0.75, 0.25, 0.1]] remoteExec ["setLightAmbient",0,_light];
	[_light,[1, 1, 1]] remoteExec ["setLightColor",0,_light];
	[_light,[_object,[0,0,-3]]] remoteExec ['attachTo'];
	_smokeGroup2 pushBack _light;
	{
		_source = createVehicle ["#particlesource",getPosATL _object,[],0,"CAN_COLLIDE"];
		
		
		
		[[_source,'ObjectDestructionFire1Smallx'],
		{
			_this spawn (JSADYFATwaq25 select 1);
		}] remoteExec ["spawn",0,_source];
		
		[_source,[_x,[0,0,0]]] remoteExec ['attachTo'];
		_smokeGroup2 pushBack _source;
	} foreach VostokEngines;
	

	
	{
		[_x,
		{
			_this spawn (ADHGF5377ftd # 1);
		}] remoteExec ['spawn'];
	} forEach VostokEngines;
	
	sleep 5;
	playSound3D ["A3\sounds_f\arsenal\weapons_vehicles\missiles\VLS_01_Launch_03.wss", _object, false, getPosATL _object, 5, 0.1, 10000];
	playSound3D ["A3\sounds_f\arsenal\weapons_vehicles\missiles\VLS_01_Launch_02.wss", _object, false, getPosATL _object, 5, 0.1, 10000];
	playSound3D ["A3\sounds_f\vehicles\air\cas_01\CAS_01_engine_ext_dist_rear.wss", _object, false, getPosATL _object, 5, 0.1, 10000];
	playSound3D ["A3\Sounds_F\ambient\thunder\thunder_01.wss", _object, false, getPosATL _object, 5, 0.1, 10000];
	playSound3D ["A3\Sounds_F\ambient\thunder\thunder_01.wss", _object, false, getPosATL _object, 5, 0.5, 10000];
	playSound3D ["A3\Sounds_F\ambient\thunder\thunder_01.wss", _object, false, getPosATL _object, 5, 1, 10000];
	playSound3D ["A3\Sounds_F\ambient\battlefield\battlefield_jet3.wss", _object, false, getPosATL _object, 5, 0.1, 10000];
	playSound3D ["A3\Sounds_F\ambient\battlefield\battlefield_jet3.wss", _object, false, getPosATL _object, 5, 0.5, 10000];
	playSound3D ["A3\Sounds_F\ambient\battlefield\battlefield_jet3.wss", _object, false, getPosATL _object, 5, 1, 10000];
	playSound3D ["A3\Sounds_F\ambient\quakes\earthquake4.wss", _object, false, getPosATL _object, 5, 0.1, 10000];
	playSound3D ["A3\Sounds_F\ambient\quakes\earthquake4.wss", _object, false, getPosATL _object, 5, 0.5, 10000];
	playSound3D ["A3\Sounds_F\ambient\quakes\earthquake4.wss", _object, false, getPosATL _object, 5, 1, 10000];
	sleep 10;
	{deleteVehicle _x;} foreach _smokeGroup1;
	sleep 105;
	{deleteVehicle _x;} foreach _smokeGroup2;
};

[JAM_mObj_rocketBase,VostokEngines] spawn VRL_fnc_launchEffects;

_launchRocket = [] spawn  
{
	sleep 6;
	_rocketFlightTime_01 = 3;
	_rocketFlightTime_02 = 3;
	_rocketFlightTime_03 = 3;
	_rocketFlightTime_04 = 3;
	_rocketFlightTime_05 = 3;
	_rocketFlightTime_06 = 3;
	_rocketFlightTime_07 = 3;
	_rocketFlightTime_08 = 50;
	
	rocketBaseRiseSequence_01 = true;
	rocketBaseRiseSequence_02 = false;
	rocketBaseRiseSequence_03 = false;
	rocketBaseRiseSequence_04 = false;
	rocketBaseRiseSequence_05 = false;
	rocketBaseRiseSequence_06 = false;
	rocketBaseRiseSequence_07 = false;
	rocketBaseRiseSequence_08 = false;
	[_rocketFlightTime_01, _rocketFlightTime_02, _rocketFlightTime_03,_rocketFlightTime_08 ] spawn 
	{
		sleep (_this # 0);
		rocketBaseRiseSequence_01 = false;
		rocketBaseRiseSequence_02 = true;
		sleep (_this # 1);
		rocketBaseRiseSequence_02 = false;
		rocketBaseRiseSequence_03 = true;
		sleep (_this # 2);
		rocketBaseRiseSequence_03 = false;
		rocketBaseRiseSequence_04 = true;
		sleep (_this # 2);
		rocketBaseRiseSequence_04 = false;
		rocketBaseRiseSequence_05 = true;
		sleep (_this # 2);
		rocketBaseRiseSequence_05 = false;
		rocketBaseRiseSequence_06 = true;
		sleep (_this # 2);
		rocketBaseRiseSequence_06 = false;
		rocketBaseRiseSequence_07 = true;
		sleep (_this # 2);
		rocketBaseRiseSequence_07 = false;
		rocketBaseRiseSequence_08 = true;
		sleep (_this # 3);
		rocketBaseRiseSequence_08 = false;
	};
	_attachToPosZ = 252;
	_attachToPosZ_B = 5;
	_interval = 0.01; 
	_adjustment = 0.1; 
	while {rocketBaseRiseSequence_01} do  
	{ 		
		_attachToPosZ = _attachToPosZ + _adjustment;
		[JAM_mObj_bigRocket,[JAM_mObj_rocketBase,[0,0,_attachToPosZ]]] remoteExec ['attachTo'];
		
		_attachToPosZ_B = _attachToPosZ_B + _adjustment;
		[RocketEngine1,[JAM_mObj_rocketBase,[0,0,_attachToPosZ_B]]] remoteExec ['attachTo'];
		
		sleep _interval; 
	};
	waitUntil {rocketBaseRiseSequence_02};
	_adjustment = 0.2; 
	while {rocketBaseRiseSequence_02} do  
	{ 		
		_attachToPosZ = _attachToPosZ + _adjustment;
		[JAM_mObj_bigRocket,[JAM_mObj_rocketBase,[0,0,_attachToPosZ]]] remoteExec ['attachTo'];		
		_attachToPosZ_B = _attachToPosZ_B + _adjustment;
		[RocketEngine1,[JAM_mObj_rocketBase,[0,0,_attachToPosZ_B]]] remoteExec ['attachTo'];
		
		sleep _interval; 
	};
	waitUntil {rocketBaseRiseSequence_03};
	_adjustment = 0.4; 
	while {rocketBaseRiseSequence_03} do  
	{ 		
		_attachToPosZ = _attachToPosZ + _adjustment;
		[JAM_mObj_bigRocket,[JAM_mObj_rocketBase,[0,0,_attachToPosZ]]] remoteExec ['attachTo'];		
		_attachToPosZ_B = _attachToPosZ_B + _adjustment;
		[RocketEngine1,[JAM_mObj_rocketBase,[0,0,_attachToPosZ_B]]] remoteExec ['attachTo'];
		
		sleep _interval; 
	};
	waitUntil {rocketBaseRiseSequence_04};
	_adjustment = 0.8; 
	while {rocketBaseRiseSequence_04} do  
	{ 		
		_attachToPosZ = _attachToPosZ + _adjustment;
		[JAM_mObj_bigRocket,[JAM_mObj_rocketBase,[0,0,_attachToPosZ]]] remoteExec ['attachTo'];		
		_attachToPosZ_B = _attachToPosZ_B + _adjustment;
		[RocketEngine1,[JAM_mObj_rocketBase,[0,0,_attachToPosZ_B]]] remoteExec ['attachTo'];
		
		sleep _interval; 
	};
	waitUntil {rocketBaseRiseSequence_05};
	_adjustment = 1.6; 
	while {rocketBaseRiseSequence_05} do  
	{ 		
		_attachToPosZ = _attachToPosZ + _adjustment;
		[JAM_mObj_bigRocket,[JAM_mObj_rocketBase,[0,0,_attachToPosZ]]] remoteExec ['attachTo'];		
		_attachToPosZ_B = _attachToPosZ_B + _adjustment;
		[RocketEngine1,[JAM_mObj_rocketBase,[0,0,_attachToPosZ_B]]] remoteExec ['attachTo'];
		
		sleep _interval; 
	};
	waitUntil {rocketBaseRiseSequence_06};
	_adjustment = 3.2; 
	while {rocketBaseRiseSequence_06} do  
	{ 		
		_attachToPosZ = _attachToPosZ + _adjustment;
		[JAM_mObj_bigRocket,[JAM_mObj_rocketBase,[0,0,_attachToPosZ]]] remoteExec ['attachTo'];		
		_attachToPosZ_B = _attachToPosZ_B + _adjustment;
		[RocketEngine1,[JAM_mObj_rocketBase,[0,0,_attachToPosZ_B]]] remoteExec ['attachTo'];
		
		sleep _interval; 
	};
	waitUntil {rocketBaseRiseSequence_07};
	_adjustment = 6.4; 
	while {rocketBaseRiseSequence_07} do  
	{ 		
		_attachToPosZ = _attachToPosZ + _adjustment;
		[JAM_mObj_bigRocket,[JAM_mObj_rocketBase,[0,0,_attachToPosZ]]] remoteExec ['attachTo'];		
		_attachToPosZ_B = _attachToPosZ_B + _adjustment;
		[RocketEngine1,[JAM_mObj_rocketBase,[0,0,_attachToPosZ_B]]] remoteExec ['attachTo'];
		
		sleep _interval; 
	};
	waitUntil {rocketBaseRiseSequence_08};
	_adjustment = 12.8; 
	while {rocketBaseRiseSequence_08} do  
	{ 		
		_attachToPosZ = _attachToPosZ + _adjustment;
		[JAM_mObj_bigRocket,[JAM_mObj_rocketBase,[0,0,_attachToPosZ]]] remoteExec ['attachTo'];		
		_attachToPosZ_B = _attachToPosZ_B + _adjustment;
		[RocketEngine1,[JAM_mObj_rocketBase,[0,0,_attachToPosZ_B]]] remoteExec ['attachTo'];
		
		sleep _interval; 
	};
}; 
