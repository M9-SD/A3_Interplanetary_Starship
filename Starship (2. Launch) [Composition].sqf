
comment "
A3_Interplanetary_Starship

Arma 3 Steam Workshop
https://steamcommunity.com/sharedfiles/filedetails/?id=3050062657

MIT License
Copyright (c) 2023 M9-SD
https://github.com/M9-SD/A3_Interplanetary_Starship/blob/main/LICENSE
";
comment "------- ------- ------- ------- ------- ------- -------  -------  ------- ";


comment "Delete composition helipad";

	if ((!isNull (findDisplay 312)) && (!isNil 'this')) then {
		if (!isNull this) then {
			if (typeOf this == 'Land_HelipadEmpty_F') then {
				deleteVehicle this;
			};
		};
	};

comment "Launch rocket init code";

	comment "deleteVehicle this;";
	0 = [] spawn {
		private _initREpack = [] spawn {
			if (!isNil 'M9SD_fnc_RE2_V3') exitWith {};
			comment "Initialize Remote-Execution Package";
			M9SD_fnc_initRE2_V3 = {
				M9SD_fnc_initRE2Functions_V3 = {
					comment "Prep RE2 functions.";
					M9SD_fnc_REinit2_V3 = {
						private _functionNameRE2 = '';
						if (isNil {_this}) exitWith {false};
						if !(_this isEqualType []) exitWith {false};
						if (count _this == 0) exitWith {false};
						private _functionNames = _this;
						private _aString = "";
						private _namespaces = [missionNamespace, uiNamespace];
						{
							if !(_x isEqualType _aString) then {continue};
							private _functionName = _x;
							_functionNameRE2 = format ["RE2_%1", _functionName];
							{
								private _namespace = _x;
								with _namespace do {
									if (!isNil _functionName) then {
										private _fnc = _namespace getVariable [_functionName, {}];
										private _fncStr = str _fnc;
										private _fncStr2 = "{" + 
											"removeMissionEventHandler ['EachFrame', _thisEventHandler];" + 
											"_thisArgs call " + _fncStr + 
										"}";
										private _fncStrArr = _fncStr2 splitString '';
										_fncStrArr deleteAt (count _fncStrArr - 1);
										_fncStrArr deleteAt 0;
										_namespace setVariable [_functionNameRE2, _fncStrArr, true];
									};
								};
							} forEach _namespaces;
						} forEach _functionNames;
						true;_functionNameRE2;
					};
					M9SD_fnc_RE2_V3 = {
						params [["_REarguments", []], ["_REfncName2", ""], ["_REtarget", player], ["_JIPparam", false]];
						if (!((missionnamespace getVariable [_REfncName2, []]) isEqualType []) && !((uiNamespace getVariable [_REfncName2, []]) isEqualType [])) exitWith {
							systemChat "::Error:: remoteExec failed (invalid _REfncName2 - not an array).";
						};
						if ((count (missionnamespace getVariable [_REfncName2, []]) == 0) && (count (uiNamespace getVariable [_REfncName2, []]) == 0)) exitWith {
							systemChat "::Error:: remoteExec failed (invalid _REfncName2 - empty array).";
							systemChat str _REfncName2;
						};
						[[_REfncName2, _REarguments],{ 
							addMissionEventHandler ["EachFrame", (missionNamespace getVariable [_this # 0, ['']]) joinString '', _this # 1]; 
						}] remoteExec ['call', _REtarget, _JIPparam];
					};
					comment "systemChat '[ RE2 Package ] : RE2 functions initialized.';";
				};
				M9SD_fnc_initRE2FunctionsGlobal_V2 = {
					comment "Prep RE2 functions on all clients+jip.";
					private _fncStr = format ["{
						removeMissionEventHandler ['EachFrame', _thisEventHandler];
						_thisArgs call %1
					}", M9SD_fnc_initRE2Functions_V3];
					_fncStr = _fncStr splitString '';
					_fncStr deleteAt (count _fncStr - 1);
					_fncStr deleteAt 0;
					missionNamespace setVariable ["RE2_M9SD_fnc_initRE2Functions_V2", _fncStr, true];
					[["RE2_M9SD_fnc_initRE2Functions_V2", []],{ 
						addMissionEventHandler ["EachFrame", (missionNamespace getVariable ["RE2_M9SD_fnc_initRE2Functions_V2", ['']]) joinString '', _this # 1]; 
					}] remoteExec ['call', 0, 'RE2_M9SD_JIP_initRE2Functions_V2'];
					comment "Delete from jip queue: remoteExec ['', 'RE2_M9SD_JIP_initRE2Functions_V2'];";
				};
				call M9SD_fnc_initRE2FunctionsGlobal_V2;
			};
			call M9SD_fnc_initRE2_V3;
			waitUntil {!isNil 'M9SD_fnc_RE2_V3'};
			if (true) exitWith {true};
		};
		waitUntil {scriptDone _initREpack};
		waitUntil {!isNil 'M9SD_fnc_REinit2_V3'};
		M9_tmpREfnc_svmspc = {
			(_this # 0) setVelocityModelSpace (_this # 1);
		};
		['M9_tmpREfnc_svmspc'] call M9SD_fnc_REinit2_V3;
		waitUntil {!isNil 'RE2_M9_tmpREfnc_svmspc'};

		if (isnil 'M9SD_rocketDebugMode') then {M9SD_rocketDebugMode = 0;};

		comment "set the view distance (required or else script will bug out)";

		7000 remoteExec ['setViewDistance'];
		7000 remoteExec ['setObjectViewDistance'];

		comment "control size/scale of particle effects";

		rocketPFXSize = 0.5;

		comment "Free up resources and regain lost framerate by deleting rocket once it reaches max altitude.";

		M9SD_fnc_rocketCleanup = {
			waitUntil {sleep 0.1;
				((isNull _this) or (!alive _this)) or 
				(((getPosWorldVisual _this) # 2) > (getobjectviewdistance # 0))
			};
			{
				deleteVehicle _x;
			} foreach (attachedObjects _this);
			deleteVehicle _this;
			comment "remote executions ? JIP ? ";
			comment "camera shake ?? ";
			comment " leftover objects ? ";
			comment " event handlers ? ";
			comment "Reset the view distance settings once there are no rockets left ?";
		};


		comment "cool lightning effect during rocket ascent";

		M9_SD_fnc_moduleSafeLightningBolt = 
		{
			params [["_object", objNull]];
			_object spawn 
			{
				params [["_object", objNull]];
				"_pos = screenToWorld getMousePosition;";
				_pos = getPosASL _object;
				playSound3D [selectRandom ['A3\Sounds_F\ambient\thunder\thunder_02.wss', 'A3\Sounds_F\ambient\thunder\thunder_06.wss'], _object, false, _pos, 1, 1, 3200];
				_class = ["lightning1_F","lightning2_F"] call bis_Fnc_selectrandom;
				_lightning = createVehicle [_class, _pos, [], 0, "CAN_COLLIDE"];
				_dir = random 360;
				_lightning setdir _dir;
				_lightning setposasl _pos;
				_dir = random 360;
				_light = createVehicle ['#lightpoint', _pos, [], 0, "CAN_COLLIDE"];
				_light setposatl [_pos select 0,_pos select 1,(_pos select 2) + 10];
				[_light, true] remoteExec ['setLightDayLight'];
				[_light, 300] remoteExec ['setLightBrightness'];
				[_light, [0.05, 0.05, 0.1]] remoteExec ['setLightAmbient'];
				[_light, [1, 1, 2]] remoteExec ['setlightcolor'];
				if !(isNull _object) then 
				{
					comment "attach it to the bugga";
					_objPos = getPos _object;
					_lightning setPos _objPos;
					comment "_lightning attachTo [_object, [100,100,100]];";
					_light attachTo [_object, [0,0,10]];
					[_light,7] remoteExec ['setObjectScale'];
					if (_object isKindOf 'Man') then 
					{
						[_object, 1] remoteExec ['setDamage'];
						moveOut _object;
					} else 
					{
						if ((_object isKindOf 'Air') or (_object isKindOf 'Ship') or (_object isKindOf 'Tank') or (_object isKindOf 'Car')) then 
						{
							_dmgAllowed = isDamageAllowed _object;
							if (_dmgAllowed) then 
							{
								_object allowDamage false;
							};
							_crew = crew _object;
							{
								[_x, 1] remoteExec ['setDamage'];
								moveOut _x;
							} forEach _crew;
							if (_dmgAllowed) then 
							{
								_object allowDamage true;
							};
						};
					};
				};
				sleep 0.1;
				[_light, 0] remoteExec ['setLightBrightness'];
				sleep (random 0.1);
				_cursorTarget = _object;
				_duration = if (isnull _cursorTarget) then {(3 + random 1)} else {1};
				for "_i" from 0 to _duration do 
				{	
					[_light, (100 + random 100)] remoteExec ['setLightBrightness'];
					_timeT = time + 0.1;
					waituntil {time > _timeT};
				};
				deletevehicle _lightning;
				deletevehicle _light;
			};
						
		};
		"M9_SD_fnc_moduleSafeLightningBolt = {};";

		comment "Initiate engine/ignition VFX/SFX.";

		M9SD_fnc_rocketIgnition = {

			
			private _camShake = {
				private _rocketPos = getPos _this;

				comment "Make the camera shake for nearby players.";

				private _shakeDistanceFactor = 1.5;

				_maxDistance_lvl_01 = 400 * _shakeDistanceFactor;
				_maxDistance_lvl_02 = 800 * _shakeDistanceFactor;
				_maxDistance_lvl_03 = 1600 * _shakeDistanceFactor;

				{
					private _distanceFromRocket = (vehicle _x) distance _rocketPos;
					if (_distanceFromRocket <= _maxDistance_lvl_03) then {
						
						true remoteExec ['enableCamShake', _x];
						[[1, 60, 100]] remoteExec ['addCamShake', _x];
						if (_distanceFromRocket <= _maxDistance_lvl_02) then {
							[[5, 20, 50]] remoteExec ['addCamShake', _x];
							if (_distanceFromRocket <= _maxDistance_lvl_01) then {
								[[10, 10, 10]] remoteExec ['addCamShake', _x];
							};
						};
					};
				} forEach allPlayers;

				comment "
					ALTERNATIVE (for cutscenes),
					Make the camera shake for everyone:

					true remoteExec ['enableCamShake'];
					[1, 60, 100] remoteExec ['addCamShake'];
					[5, 20, 50] remoteExec ['addCamShake'];
					[10, 10, 10] remoteExec ['addCamShake'];
				";

			};
			
			private _soundFX = {
				private _object = _this;
				_object spawn {
					private _pos = getPosATL _this;
					while {alive _this} do {
						playSound3D ["A3\Missions_F_EPA\data\sounds\burning_car_loop1.wss", _this, false, getPosATL _this, 3.5, 1, 12800];
						uiSleep 4.1;
					};
				};
				_object spawn {
					private _object = _this;
					playSound3D ['A3\Sounds_F_Jets\vehicles\air\Shared\FX_Plane_Jet_sonicboom.wss', _object, selectRandom [true,false], getPosASL _object, 5, 0.35, 12800];
					playSound3D ['A3\Sounds_F_Jets\vehicles\air\Shared\FX_Plane_Jet_wind_ext.wss', _object, selectRandom [true,false], getPosASL _object, 5, 0.5, 12800];
					playSound3D ["A3\sounds_f\weapons\explosion\expl_big_1.wss", _object, false, getPosATL _object, 5, 0.1, 12800]; 
					playSound3D ["A3\sounds_f\weapons\heliweap\missiles_AAA.wss", _object, false, getPosATL _object, 5, 0.1, 12800];
					playSound3D ["A3\sounds_f\weapons\explosion\explosion_missile_5.wss", _object, false, getPosATL _object, 5, 0.1, 12800];
					playSound3D ["A3\sounds_f\weapons\explosion\expl_shell_6.wss", _object, false, getPosATL _object, 5, 0.1, 12800];
					playSound3D ["A3\sounds_f\arsenal\weapons_vehicles\missiles\VLS_01_Launch_03.wss", _object, false, getPosATL _object, 5, 0.1, 12800];
					playSound3D ["A3\sounds_f\arsenal\weapons_vehicles\missiles\VLS_01_Launch_02.wss", _object, false, getPosATL _object, 5, 0.1, 12800];
					uiSleep 5;
					playSound3D ["A3\sounds_f\arsenal\weapons_vehicles\missiles\VLS_01_Launch_03.wss", _object, false, getPosATL _object, 5, 0.1, 12800];
					playSound3D ["A3\sounds_f\arsenal\weapons_vehicles\missiles\VLS_01_Launch_02.wss", _object, false, getPosATL _object, 5, 0.1, 12800];
				};
				playSound3D ["A3\Sounds_F\ambient\quakes\earthquake4.wss", _object, false, getPosATL _object, 5, 0.1, 12800];
				playSound3D ["A3\Sounds_F\ambient\quakes\earthquake4.wss", _object, false, getPosATL _object, 5, 0.5, 12800];
				playSound3D ["A3\Sounds_F\ambient\quakes\earthquake4.wss", _object, false, getPosATL _object, 5, 1, 12800];
				playSound3D ["A3\Sounds_F\ambient\battlefield\battlefield_jet3.wss", _object, false, getPosATL _object, 5, 2, 12800];
				uiSleep 5;
				playSound3D ["A3\sounds_f\weapons\explosion\expl_big_1.wss", _object, false, getPosATL _object, 5, 0.1, 12800]; 
				playSound3D ["A3\sounds_f\weapons\heliweap\missiles_AAA.wss", _object, false, getPosATL _object, 5, 0.1, 12800];
				playSound3D ["A3\sounds_f\weapons\explosion\explosion_missile_5.wss", _object, false, getPosATL _object, 5, 0.1, 12800];
				playSound3D ["A3\sounds_f\weapons\explosion\expl_shell_6.wss", _object, false, getPosATL _object, 5, 0.1, 12800];
				
				playSound3D ["A3\sounds_f\vehicles\air\cas_01\CAS_01_engine_ext_dist_rear.wss", _object, false, getPosATL _object, 5, 0.1, 12800];
				playSound3D ["A3\Sounds_F\ambient\thunder\thunder_01.wss", _object, false, getPosATL _object, 5, 0.1, 12800];
				playSound3D ["A3\Sounds_F\ambient\thunder\thunder_01.wss", _object, false, getPosATL _object, 5, 0.5, 12800];
				playSound3D ["A3\Sounds_F\ambient\thunder\thunder_01.wss", _object, false, getPosATL _object, 5, 1, 12800];
				playSound3D ["A3\Sounds_F\ambient\battlefield\battlefield_jet3.wss", _object, false, getPosATL _object, 5, 0.1, 12800];
				playSound3D ["A3\Sounds_F\ambient\battlefield\battlefield_jet3.wss", _object, false, getPosATL _object, 5, 0.5, 12800];
				playSound3D ["A3\Sounds_F\ambient\battlefield\battlefield_jet3.wss", _object, false, getPosATL _object, 5, 1, 12800];
				playSound3D ["A3\Sounds_F\ambient\quakes\earthquake4.wss", _object, false, getPosATL _object, 5, 0.1, 12800];
				playSound3D ["A3\Sounds_F\ambient\quakes\earthquake4.wss", _object, false, getPosATL _object, 5, 0.5, 12800];
				playSound3D ["A3\Sounds_F\ambient\quakes\earthquake4.wss", _object, false, getPosATL _object, 5, 1, 12800];
			};
			
			private _visualFX = 
			{
				private _posASL = getPosASL _this;
				
				
				
				private _light_engine = createVehicle ["#lightpoint",_posASL,[],0,"CAN_COLLIDE"];
				[_light_engine,50] remoteExec ["setLightBrightness"];
				[_light_engine,[0.75, 0.25, 0.1]] remoteExec ["setLightAmbient"];
				[_light_engine,[1, 1, 1]] remoteExec ["setLightColor"];
				[_light_engine,[_this,[0,0,-2]]] remoteExec ['attachTo'];
				

				
				
				private _thrustFX1 = "#particlesource" createVehicle _posASL;
				[_thrustFX1,[0, [0, 0, 0]]] remoteExec ['setParticleCircle'];
				[_thrustFX1,[0, [0, 0, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0]] remoteExec ['setParticleRandom'];
				private _particleLifeTime = 1.4;
				private _particleDropInerval = 0.020;
				[_thrustFX1,[
					[
						"\A3\data_f\cl_exp", 
						1, 
						0, 
						1
					], 
					"", 
					"Billboard", 
					1, 
					_particleLifeTime, 
					[0, 0, 0], 
					[0, 0, -17], 
					0, 
					5, 
					5, 
					0, 
					[24 * rocketPFXSize,20 * rocketPFXSize,16 * rocketPFXSize], 
					[
						[1,1,0.1, 1],
						[1, 0.49, 0.02, 1],
						[1, 0.14, 0.02, 0]
					],
					[0.02], 
					1, 
					0, 
					"", 
					"", 
					_this
				]] remoteExec ['setParticleParams'];
				[_thrustFX1,_particleDropInerval] remoteExec ['setDropInterval'];
				[_thrustFX1,[_this,[0,0,0]]] remoteExec ['attachTo'];
				
				
				_smokeIntervalFactor = 0.07;
				_smokeSizeFactor = 2.5;

				
				_smokeColor_yellow = [[1, 1, 0, 0.7],[1, 1, 0, 0.5], [1, 1, 0, 0.25], [1, 1, 0, 0.8]];
				_smokeColor_green = [[0, 1, 0, 0.7],[0, 1, 0, 0.5], [0, 1, 0, 0.25], [0, 1, 0, 0.8]];
				_smokeColor_blue = [[0, 0, 1, 0.7],[0, 0, 1, 0.5], [0, 0, 1, 0.25], [0, 0, 1, 0.8]];
				_smokeColor_purple = [[1, 0, 1, 0.7],[1, 0, 1, 0.5], [1, 0, 1, 0.25], [1, 0, 1, 0.8]];
				_smokeColor_red = [[1, 0, 0, 0.7],[1, 0, 0, 0.5], [1, 0, 0, 0.25], [1, 0, 0, 0.8]];
				_smokeColor_white = [[1, 1, 1, 0.7],[1, 1, 1, 0.5], [1, 1, 1, 0.25], [1, 1, 1, 1]];
				_smokeColor_black = [[0, 0, 0, 0.7],[0, 0, 0, 0.5], [0, 0, 0, 0.25], [0, 0, 0, 1]];
				
				_smokeSize_small = [0.05, 0.8, 1.2, 1.5];
				_smokeSize_default = [5 * _smokeSizeFactor, 11 * _smokeSizeFactor, 13 * _smokeSizeFactor, 15 * _smokeSizeFactor];
				
				_smokeLifetime_d = 15;
				_smokeLifetime_e = 7.5;
				_smokeLifetime_short = 1;
				
				_smokeWeight_d = 1.277;
				_smokeWeight_heavy = _smokeWeight_d * 1.5;
				_smokeWeight_light = _smokeWeight_d / 1.5;
				
				
				_smokeColor = [[1, 1, 1, 0.825],[1, 1, 1, 0.777], [1, 1, 1, 0.699], [1, 1, 1, 0.575]];
				_smokeWeight = _smokeWeight_d;
						
				
				private _source2 = createVehicle ["#particlesource",_posASL,[],0,"CAN_COLLIDE"];
				
				[_source2,[["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7, 48, 1], "", "Billboard", 1, _smokeLifetime_e, [0, 0, 0],
							[0, 0, 0], 0, _smokeWeight, 1, 0.025, _smokeSize_default, _smokeColor,
							[0.2], 1, 0.04, "", "", _this]] remoteExec ['setParticleParams'];
				[_source2,[2, [0.3, 0.3, 0.3], [1.5, 1.5, 1], 20, 0.2, [0, 0, 0, 0.1], 0, 0, 360]] remoteExec ['setParticleRandom']; ;
				[_source2,(0.2 * _smokeIntervalFactor)] remoteExec ['setDropInterval'] ;
				[_source2,[_this,[0,0,0]]] remoteExec ['attachTo'];

				_source2 spawn {
					uiSleep 7;
					deleteVehicle _this;
				};
				

				private _source3 = createVehicle ["#particlesource",_posASL,[],0,"CAN_COLLIDE"];
				[_source3,[["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 7, 0], "", "Billboard", 1, _smokeLifetime_d, [0, 0, 0],
							[0, 0, 0], 0, _smokeWeight, 1, 0.025, _smokeSize_default, _smokeColor,
							[0.2], 1, 0.04, "", "", _this]] remoteExec ['setParticleParams']; ;
				[_source3,[2, [0.3, 0.3, 0.3], [1.5, 1.5, 1], 20, 0.2, [0, 0, 0, 0.1], 0, 0, 360]] remoteExec ['setParticleRandom']; ;
				[_source3,(0.15 * _smokeIntervalFactor)] remoteExec ['setDropInterval']; ;
				[_source3,[_this,[0,0,0]]] remoteExec ['attachTo'];
				
				_source3 spawn {
					uiSleep 124;
					deleteVehicle _this;
				};
				
				
				
				private _thrustFlamesSizeFactor = 5.5;
				private _thrustFlames = createVehicle ["#particlesource", _posASL, [], 0, "CAN_COLLIDE"];
				_thrustFlames spawn {
					sleep 180;
					deleteVehicle _this;
				};
				
				comment "_thrustFlames setParticleCircle [0.5,[0,0,0]];";
				comment "_thrustFlames setParticleRandom [0.5,[0,0,0.3],[0,0,0],0,0.1 * _thrustFlamesSizeFactor,[0,0,0,0.1],0,0];";
				[_thrustFlames,[
				["\A3\data_f\cl_exp",1,0,1],"",
				"Billboard",
				1,
				1.75,
				[0,0,0],
				[0,0,-10.9894],
				3,
				10,
				7.9,
				0,
				[4 * _thrustFlamesSizeFactor,1 * _thrustFlamesSizeFactor],
				[[1,1,1,1],[1,1,1,0]],[1],0,0,"","",_thrustFlames,90]] remoteExec ['setParticleParams']; ;
				[_thrustFlames,0.015] remoteExec ['setDropInterval']; ;
				[_thrustFlames,[_this,[0,0,-1]]] remoteExec ['attachTo'];
				
				
				private _groundSmoke = createVehicle ["#particlesource", _posASL, [], 0, "CAN_COLLIDE"]; 
				[_groundSmoke,'BombSmk2'] remoteExec ['setParticleClass']; "";
				comment "_groundSmoke setParticleCircle [3, [0,0,0]];";
				[_groundSmoke,[_this,[0,0,-1]]] remoteExec ['attachTo'];
				_groundSmoke spawn {
					uiSleep 14;
					deleteVehicle _this;
				};
				
				
				
				
				
				
				if (false) then {
					private _groundChar = createSimpleObject ["Crater", _posASL, false]; 
					_groundChar setPosASL _posASL;
					_groundChar spawn {
						private _groundChar = _this;
						_startScale = 1;
						_endScale = 24;
						_scale = _startScale;
						if (false) then {
							while {_scale < _endScale} do {
								_scale = _scale + 0.5;
								comment "_groundChar setDir (random 360);";
								[_groundChar, _scale] remoteExec ['setObjectScale'];
								uiSleep 0.07;
							};
							[_groundChar, _endScale] remoteExec ['setObjectScale'];
						} else {
							uisleep 1;
							[_groundChar, _endScale] remoteExec ['setObjectScale'];
						};
						uiSleep 2;
						[_groundChar, _endScale] remoteExec ['setObjectScale'];
						uiSleep 122;
						deleteVehicle _groundChar;
					};
				};
				
				private _groundFlames = createVehicle ["#particlesource", _posASL, [], 0, "CAN_COLLIDE"];
				_groundFlames setPosASL _posASL;
				[_groundFlames,[56,[0,0,0]]] remoteExec ['setParticleCircle'];
				[_groundFlames,[1,[55,55,0],[0,0,0],0,1,[0,0,0,0],1,0]] remoteExec ['setParticleRandom'];
				[_groundFlames,[["\A3\data_f\ParticleEffects\Universal\Universal",16,10,32,1],"","Billboard",1,5,[0,0,0],[0,0,0],0,10.07,7.9,0,[1,5,1],[[1,1,1,1],[1,1,1,1],[1,1,1,0]],[0.8],0, 0, "", "", _groundFlames,0,true]] remoteExec ['setParticleParams'];
				[_groundFlames,0.01] remoteExec ['setDropInterval'];
				_groundFlames spawn {
					uiSleep 45;
					deleteVehicle _this;
				};
				
				private _light_groundFire = createVehicle ["#lightpoint",_posASL,[],0,"CAN_COLLIDE"];
				_light_groundFire setPosASL _posASL;
				[_light_groundFire,10] remoteExec ["setLightBrightness"];
				[_light_groundFire,[0.75, 0.25, 0.1]] remoteExec ["setLightAmbient"];
				[_light_groundFire,[0.5, 1, 1]] remoteExec ["setLightColor"];
				_light_groundFire spawn {
					uiSleep 47;
					deleteVehicle _this;
				};
				
				private _vaporCloudRocket = createVehicle ["#particlesource", _posASL, [], 0, "CAN_COLLIDE"];
				_vaporCloudRocket setPosASL _posASL;
				[_vaporCloudRocket,[0,[0,0,0]]] remoteExec ['setParticleCircle']; ; 
				[_vaporCloudRocket,[0,[0,0,0],[0,0,0],0,0,[0,0,0,0],0,0]] remoteExec ['setParticleRandom']; ; 
				[_vaporCloudRocket,[["\A3\data_f\cl_basic",1,0,1],"","Billboard",1,0.5,[0,0,0],[0,0,3],0,10,7.9,0,[1,100 * rocketPFXSize],[[1,1,1,0.5],[1,1,1,0]],[1],0,0,"","",_vaporCloudRocket]] remoteExec ['setParticleParams']; ; 
				[_vaporCloudRocket,0.03] remoteExec ['setDropInterval'] ;
				[_vaporCloudRocket,[_this,[0,0,-2]]] remoteExec ['attachTo'];
				_vaporCloudRocket spawn {
					sleep 2.5;
					deleteVehicle _this;
				};
				
				
				private _vaporCloudGround = createVehicle ["#particlesource", _posASL, [], 0, "CAN_COLLIDE"];
				_vaporCloudGround setPosASL _posASL;
				[_vaporCloudGround,[0,[0,0,0]]] remoteExec ['setParticleCircle']; ; 
				[_vaporCloudGround, [0,[0,0,0],[0,0,0],0,0,[0,0,0,0],0,0]] remoteExec ['setParticleRandom']; ; 
				[_vaporCloudGround,[["\A3\data_f\cl_basic",1,0,1],"","Billboard",1,0.5,[0,0,0],[0,0,3],0,10,7.9,0,[10 * rocketPFXSize,100 * rocketPFXSize],[[1,1,1,0.5],[1,1,1,0]],[1],0,0,"","",_vaporCloudGround]] remoteExec ['setParticleParams']; ; 
				[_vaporCloudGround,0.03] remoteExec ['setDropInterval']; ;
				_vaporCloudGround spawn {
					sleep 7;
					deleteVehicle _this;
				};
				
				private _alias_local_fog = createVehicle ["#particlesource", _posASL, [], 0, "CAN_COLLIDE"];
				_alias_local_fog setPosASL _posASL;
				[_alias_local_fog,[50,[0,0,0]]] remoteExec ['setParticleCircle']; ; 
				[_alias_local_fog,[1,[50,50,0],[0,0,0],1,0.1,[0,0,0,0.1],0,0]] remoteExec ['setParticleRandom']; ; 
				[_alias_local_fog,[["\A3\data_f\cl_basic",1,0,1],"","Billboard",1,10,[0,0,1],[0,0,0],3,10.1 * 1.10,7.9,0.01,[1,10,20],[[0.1,0.09,0.09,0],[0.1,0.09,0.09,0.5],[0.1,0.09,0.09,0]],[1],1,0,"","",_alias_local_fog]] remoteExec ['setParticleParams']; ; 
				[_alias_local_fog,0.01] remoteExec ['setDropInterval']; ;
				_alias_local_fog spawn {
					uiSleep 45;
					deleteVehicle _this;
				};
				
				
				
				private _lifetime_whiteVaporLow = 10;
				_fog_low = "#particlesource" createVehicle _posASL;
				_fog_low setPosASL _posASL;
				[_fog_low,[60,[10,10,5.25]]] remoteExec ['setParticleCircle']; ;
				[_fog_low,[1,[30,30,-1],[0,0,0],3,1,[0,0,0,0.3],0,0]] remoteExec ['setParticleRandom']; ;
				[_fog_low,[["\A3\data_f\cl_basic",1,0,1],"","Billboard",1,_lifetime_whiteVaporLow,[0,0,-1],[0,0,0],13,10,7.843,0.005,[10,20,30],[[1,1,1,0],[1,1,1,0.3],[1,1,1,0]],[0,0],0,0,"","",_posASL]] remoteExec ['setParticleParams'];;
				[_fog_low,0.03] remoteExec ['setDropInterval']; ;
				_fog_low spawn {
					uiSleep 14;
					deleteVehicle _this;
				};
				
				private _groundSmokeWave = createVehicle ["#particlesource", _posASL, [], 0, "CAN_COLLIDE"];
				_groundSmokeWave setPosASL _posASL;
				[_groundSmokeWave,[
				["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "",
				"Billboard",
				1,
				7,
				[0, 0, 0],
				[0, 0, 0],
				0, 1.5, 1, 0,
				[50, 25],
				[[0.1, 0.1, 0.1, 0.5], [0.5, 0.5, 0.5, 0.5], [1, 1, 1, 0.3], [1, 1, 1, 0]],
				[1,0.5],
				0.1,
				1,
				"",
				"",
				_posASL]] remoteExec ['setParticleParams']; ;
				[_groundSmokeWave,0.01] remoteExec ['setDropInterval'] ;
				[_groundSmokeWave,[2, [20, 20, 20], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0]] remoteExec ['setParticleRandom'] ;
				
				[_groundSmokeWave,[60, [-60, 60, 2.5]]] remoteExec ['setParticleCircle']; ;
				_groundSmokeWave spawn {
				
					uiSleep 5.5;
					deleteVehicle _this;
				};

			};
			
			_this call _camShake;
			
			_this spawn _soundFX;
			
			_this spawn _visualFX;
		};

		comment "Simulate the trajectory and acceleration of the rocket.";


		M9SD_fnc_rocketAscent = {
			comment "Set the velocity of the rocket object to simulate thrust";
			0 = [_this] spawn {
				params [["_rocketObj_stage_01", objNull]];
				if (isNull _rocketObj_stage_01) exitWith {
					systemChat 'Error: Rocket object parameter is null. Pass the variable and try again.';
					playSound 'addItemFailed';
				};
				private _timeTilTurn = 1;
				upVel_start = 5.25;
				private _dir = direction _rocketObj_stage_01;
				rocketObj_stage_01  = _rocketObj_stage_01;
				publicVariable 'rocketObj_stage_01';
				rocketObj_stage_01 setVariable ['enginesFiring', true, true];
				comment "Run the velocity loop while the first stage is firing";
				comment "systemChat 'Starting velocity loop...';";
				private _rocketStartTime = time;
				private _newTime = time - time;
				private _straightUp = [0,0,1];
				private _straightUp_x = 0;
				private _straightUp_y = 0;
				private _straightUp_z = 1;



				
				while {((!(isNull _rocketObj_stage_01)) && 
				(_rocketObj_stage_01 getVariable ['enginesFiring', false]))} do {
					
					comment "Get the dynamic value from memory.";
					private _flightTime = time - _rocketStartTime;
					
					comment "Maintain upright direction.";
					if (_flightTime < _timeTilTurn) then {
						comment "_rocketObj_stage_01 setDir _dir;";
					};
					
					comment "Calculate velocity, given acceleration factor and flight time.";
					private _upVel = upVel_start + 10.9894 * _flightTime;
					private _vel = [0,0,_upVel];
					
					comment "Set the velocity of the central object.";
					comment "_rocketObj_stage_01 setVelocity _vel;";
					comment "_rocketObj_stage_01 setVelocityModelSpace _vel;";

					comment "[_rocketObj_stage_01, _vel] remoteExec ['setVelocityModelSpace'];";
					[[_rocketObj_stage_01, _vel], 'RE2_M9_tmpREfnc_svmspc', 0] call M9SD_fnc_RE2_V3;



					comment "Make the rocket spin around.";
					comment "private _torque_z = 3;";
					if (_flightTime >= _timeTilTurn) then {
						comment "
						_rocketObj_stage_01 addTorque (_rocketObj_stage_01 vectorModelToWorld [0,0,3]);
						";
					};
					
					
					
					comment "
					_vdir = vectordir _rocketObj_stage_01;
					_vdir_radians = _vdir # 0 atan2 _vdir # 1;
					_vup = vectorup _rocketObj_stage_01;
					_vup_radians = _vup # 0 atan2 _vup # 1;
					
					systemChat format ['%1 | %2', _vdir_radians, _vup_radians];
					";
					
					private _upVec = vectorUp _rocketObj_stage_01;
					
					if !(_upVec isEqualTo _straightUp) then {
						private _upVec_x = _upVec # 0;
						private _upVec_y = _upVec # 1;
						private _upVec_z = _upVec # 2;
						private _upVec_x_diff = 0;
						private _upVec_y_diff = 0;
						private _upVec_z_diff = 0;
						private _torque_x = 0;
						private _torque_y = 0;
						private _torque_z = 0;
						
						if (_upVec_x < _straightUp_x) then {
							_upVec_x_diff = _straightUp_x - _upVec_x;
							_torque_x = _torque_x + _upVec_x_diff;
						};
						if (_upVec_x > _straightUp_x) then {
							_upVec_x_diff = _upVec_x - _straightUp_x;
							_torque_x = _torque_x - _upVec_x_diff;
						};
						
						if (_upVec_y < _straightUp_y) then {
							_upVec_y_diff = _straightUp_y - _upVec_y;
							_torque_y = _torque_y + _upVec_y_diff;
						};
						if (_upVec_y > _straightUp_y) then {
							_upVec_y_diff = _upVec_y - _straightUp_y;
							_torque_y = _torque_y - _upVec_y_diff;
						};
						
						
						if (_upVec_z < _straightUp_z) then {
							_upVec_z_diff = _straightUp_z - _upVec_z;
							_torque_z = _torque_z + _upVec_z_diff;
						};
						if (_upVec_z > _straightUp_z) then {
							_upVec_z_diff = _upVec_z - _straightUp_z;
							_torque_z = _torque_z - _upVec_z_diff;
						};
						
						private _torqueFactor = 14;
						
						_torque_x = _torque_x * _torqueFactor;
						_torque_y = _torque_y * _torqueFactor;
						_torque_z = _torque_z * _torqueFactor;
						
						private _newTorque_relative = [_torque_y * 1,_torque_x * -1,3.5];
						private _newTorque = _rocketObj_stage_01 vectorModelToWorld _newTorque_relative;
						comment "systemChat (str(_newTorque_relative) + ' | ' + str(_newTorque));";
						
						private _speed = speed _rocketObj_stage_01;
						private _soundBarrier = 1239;
						private _vertSpeed = (velocityModelSpace _rocketObj_stage_01 # 2) * 3.6;
						comment "systemChat format ['%1 | %2', _speed, _vertSpeed];";
						if ((_speed >= _soundBarrier) or (_vertSpeed >= _soundBarrier)) then {
							if (false) then {systemChat "BARRIER BROKEN!";};
						
						};
						
						_rocketObj_stage_01 addTorque _newTorque;
					};
					
					
					
					
					uiSleep 0.1;
				};
				
				comment "systemChat 'Engines no longer firing.';";
			};
		};

		M9SD_fnc_launchRocket = {
			params [['_rocket', objNull]];
			if (isNull _rocket) exitWith {};
			if (_rocket getVariable ['isLaunching', false]) exitWith {};
			if (_rocket getVariable ['isLanding', false]) exitWith {};
			_rocket setVariable ['isLaunching', true, true];
			playSound3D ["A3\Sounds_F\ambient\battlefield\battlefield_jet3.wss", _rocket, false, getPosATL _rocket, 4, 2, 6400];
			uiSleep 3;
			_rocket call M9SD_fnc_rocketIgnition;
			_rocket call M9SD_fnc_rocketAscent;
			_rocket spawn {
				sleep 7;
				if (floor random (10*2.1) == 7) then {
					_this spawn M9_SD_fnc_moduleSafeLightningBolt;
				};
				sleep 10;
				if (floor random (10*1.4) == 7) then {
					_this spawn M9_SD_fnc_moduleSafeLightningBolt;
				};
			};
			uiSleep 3;
			_rocket spawn M9SD_fnc_rocketCleanup;
		};


		M9SD_fnc_launchAllRockets = {
			private _rocketComps = missionNamespace getVariable ['M9SD_rocketComps', []];
			if (_rocketComps isEqualTo []) exitWith {};
			comment 
			"
			if (missionNamespace getVariable ['M9_rocketsAreLaunching', false]) exitWith {
				playSound ['additemfailed', false];
				systemChat 'ROCKET SCRIPT: Rockets are launching, please wait.';
				playSound ['additemfailed', true];
			};
			M9_rocketsAreLaunching = true;
			publicVariable 'M9_rocketsAreLaunching';";
			with uiNamespace do 
			{
	
				[ 
					[ 
					["INITIATING LAUNCH SEQUENCE...", "align = 'left' shadow = '1' size = '0.7' font='PuristaBold'"] 
					] 
				, 0.256] spawn BIS_fnc_typeText2; 
	
				playsound ['zoomIn',true];
				uiSleep 0.3;
				playsound ["assemble_target", true];
				uiSleep 0.5;
				playsound ["surrender_fall", true];
			};

			{
				private _rocketComp = _x;
				private _rocketComp_baseObj = _rocketComp # 0;
				if (alive _rocketComp_baseObj) then {
					[_rocketComp_baseObj] spawn M9SD_fnc_launchRocket;
				};
				sleep 2.1;
			} forEach _rocketComps;



		};



		0 = [] spawn M9SD_fnc_launchAllRockets;


	};


comment "------- ------- ------- ------- ------- ------- -------  -------  ------- ";
comment "
A3_Interplanetary_Starship

Arma 3 Steam Workshop
https://steamcommunity.com/sharedfiles/filedetails/?id=3050062657

MIT License
Copyright (c) 2023 M9-SD
https://github.com/M9-SD/A3_Interplanetary_Starship/blob/main/LICENSE
";
