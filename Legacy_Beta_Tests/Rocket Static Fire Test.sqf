


comment "
Run all effects for 40 seconds
";


comment "control size/scale of particle effects";

rocketPFXSize = 0.5;

[] spawn {
	_pos = screenToWorld [0.5,0.5];
	_pos set [2, (_pos # 2) + 50];
	_rocket =  "Land_HelipadEmpty_F" createVehicle _pos;
	playSound3D ["A3\Sounds_F\ambient\battlefield\battlefield_jet3.wss", _rocket, false, getPosATL _rocket, 4, 2, 6400];
	uiSleep 3;
	_rocket call {
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
				while {alive _this && false} do {
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
};






















