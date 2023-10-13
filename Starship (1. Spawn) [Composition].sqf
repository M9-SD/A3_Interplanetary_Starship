
comment "
A3_Interplanetary_Starship

Arma 3 Steam Workshop
https://steamcommunity.com/sharedfiles/filedetails/?id=3050062499

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

comment "Spawn rocket init code";

	comment "Set script parameters";

	M9SD_rocketSpawnComp_version = '1.0.0 Beta';
	M9SD_debug = true;
	if (isnil 'M9SD_rocketDebugMode') then {M9SD_rocketDebugMode = 0;};

	comment "Place the rocket down at the given module location.";

	M9SD_fnc_sysChat = {
		if  (missionNamespace getVariable ['M9SD_debug', false]) then {
			if !(shownChat) then {
				showChat true;
			};
			systemChat _this;
		};
	};

	M9SD_fnc_addObjectToGameMaster = {
		private _obj = _this;
		comment "
			On official Zeus servers the game mod's player has a 
			variable name of 'bis_curatorUnit_1'. Likewise, the 
			game mod's curator logic is equal to 'bis_curator_1'.
			
			Commands used to obtain var names:
			vehiclevarname player >>> 'bis_curatorUnit_1'
			vehiclevarname (getAssignedCuratorLogic player) >>> 'bis_curator_1'
		";

		comment "Exclude game moderator from objects being added to interface.";
		
		{
		
			if ((vehicleVarName _x == 'bis_curator_1') or (vehicleVarName (getAssignedCuratorUnit _x) == 'bis_curatorUnit_1')) then {
				comment "Exclude";
			} else {
				comment "Include";
				[_x, [[_obj], true]] remoteExec ['addCuratorEditableObjects', owner _x];
			};
		} forEach allCurators; comment "Iterate through live array of zeus logics.";
	};

	M9SD_fnc_cleanupRockets = {
		private _rocketComps = missionNamespace getVariable ['M9SD_rocketComps', []];
		private _newRocketCompArray = _rocketComps;
		private _rocketCompCount = count _rocketComps;
		private _deleteCount_comps = 0;
		private _deleteCount_baseObj = 0;
		private _deleteCount_fuselage = 0;
		private _deleteCount_jipScripts = 0;
		comment "
		if (_rocketCompCount < 1) exitWith {
			(format ['ROCKET SCRIPT: Error on rocket cleanup: M9SD_rocketComps array is empty.']) call M9SD_fnc_sysChat;
		};
		";
		{
			private _rocketComp = _x;
			private _rocketBaseObj = _rocketComp # 0;
			private _rocketFuselage = _rocketComp # 1;
			private _jipIDs = _rocketComp # 2;
			private _isRocketBaseNull = (isNull _rocketBaseObj) or (!alive _rocketBaseObj);
			private _isRocketFuselageNull = (isNull _rocketFuselage) or (!alive _rocketFuselage);
			if ((_isRocketBaseNull) or (_isRocketFuselageNull)) then {
				_deleteCount_comps = _deleteCount_comps + 1;
				if (_isRocketBaseNull) then {
					_deleteCount_baseObj = _deleteCount_baseObj + 1;
				};
				if (_isRocketFuselageNull) then {
					_deleteCount_fuselage = _deleteCount_fuselage + 1;
				};
				_deleteCount_jipScripts = _deleteCount_jipScripts + (count _jipIDs);
				deleteVehicle _rocketBaseObj;
				deleteVehicle _rocketFuselage;
				{
					remoteExec ['', _x];
				} forEach _jipIDs;
				_newRocketCompArray deleteAt _forEachIndex;
			};
		} forEach _rocketComps;
		if (_deleteCount_comps > 0) then {
			missionNamespace setVariable ['M9SD_rocketComps', _newRocketCompArray, true];
			(format ["ROCKET SCRIPT: Auto-cleanup deleted %1 comp(s): [%2 baseObjs, %3 fuselages, %4 jipScripts].", _deleteCount_comps, _deleteCount_baseObj, _deleteCount_fuselage, _deleteCount_jipScripts]) call M9SD_fnc_sysChat;
		} else {
			comment "(format ['ROCKET SCRIPT: Found no rocket comps to delete.']) call M9SD_fnc_sysChat;";
		};
	};

	
	M9SD_fnc_countRockets = {
		comment "Figure out how many rockets are alive.";
		if (isNil 'M9SD_rocketComps') exitWith {0};
		private _counter = 0;
		{
			private _rocketObj = _x select 0;
			if ((!isNull _rocketObj) && (alive _rocketObj)) then {
				_counter = _counter + 1;
			};
		} forEach M9SD_rocketComps;
		_counter;
	};


	M9SD_fnc_rocketAssembly = {

		if ((call M9SD_fnc_countRockets > 2) && (M9SD_rocketDebugMode != 1)) exitWith {
			systemChat "ROCKET SCRIPT: Cannot spawn more than 3 rockets at a time!";
			playSound 'AddItemFailed';
		};
		(format ['ROCKET SCRIPT: Spawning rocket...']) call M9SD_fnc_sysChat;
		private _pos = _this;

		private _rocketBaseObj = "Land_Pod_Heli_Transport_04_bench_F" createVehicle _pos;
		rocketBaseObj = _rocketBaseObj;
		for '_i' from -1 to 16 do {[_rocketBaseObj,[_i,'']] remoteExec ['setObjectTextureGlobal', 2] ;};
		_rocketBaseObj call M9SD_fnc_addObjectToGameMaster;
		private _rocketFuselage = createSimpleObject ["ammo_Missile_KH58", _pos];
		rocketFuselage = _rocketFuselage;
		private _jipIDs = [];
		
		private _jipid_attachTo = format ["M9SD_JIP_rocket_attachTo_%1", str(_rocketFuselage)];
		_jipIDs pushback _jipid_attachTo;
		
		comment "Ensure the rocket initializes consistently accross all clients";
		
		[_rocketFuselage,[_rocketBaseObj,[4.20,4.20,59.07]]] remoteExec ['attachTo', 0, _jipid_attachTo];
		
		
		private _jipid_setVectorDirAndUp = format ["M9SD_JIP_rocket_setVectorDirAndUp_%1", str(_rocketFuselage)];
		_jipIDs pushback _jipid_setVectorDirAndUp;
		
		private _y = 0;
		private _p = -90;
		private _r = 90;
		[
			_rocketFuselage,
			[   
				[  
					sin _y * cos _p,   
					cos _y * cos _p,   
					sin _p  
				],                       
				[  
					[  
						sin _r,   
						-sin _p,   
						cos _r * cos _p  
					],   
					-_y  
				] call BIS_fnc_rotateVector2D   
			]
		] remoteExec ['setVectorDirAndUp', 0, _jipid_setVectorDirAndUp];
		
		private _jipid_setObjectScale = format ["M9SD_JIP_rocket_setObjectScale_%1", str(_rocketFuselage)];
		_jipIDs pushback _jipid_setObjectScale;
		
		[_rocketFuselage, 29] remoteExec ['setObjectScale', 0, _jipid_setObjectScale];
		if (isNil 'M9SD_rocketComps') then {
			M9SD_rocketComps = [];
			publicVariable 'M9SD_rocketComps';
		};
		private _rocketComp = [_rocketBaseObj, _rocketFuselage, _jipIDs];
		M9SD_rocketComps pushback _rocketComp;
		publicVariable 'M9SD_rocketComps';
		private _initRocketCleanup = [] spawn {
			if (!isNil 'M9SD_rocketCleanupRunning') exitWith {};
			(format ['ROCKET SCRIPT: Starting cleanup loop...']) call M9SD_fnc_sysChat;
			M9SD_rocketCleanupRunning = true;
			while {M9SD_rocketCleanupRunning} do {
				call M9SD_fnc_cleanupRockets;
				sleep 0.5;
			};
		};
		comment "(format ['ROCKET SCRIPT: Rocket spawned! | %1', str _rocketComp]) call M9SD_fnc_sysChat;";
		(format ['ROCKET SCRIPT: Rocket [%1] spawned!', M9SD_rocketComps find _rocketComp]) call M9SD_fnc_sysChat;
		_rocketComp;
	};

	comment "
	call M9SD_fnc_cleanupRockets;
	";

	comment "
	(screenToWorld [0.5,0.5]) spawn M9SD_fnc_rocketAssembly;
	";

	comment "
	(getpos this) spawn M9SD_fnc_rocketAssembly;
	deleteVehicle this;
	";







	comment "
		[rocketFuselage,[rocketBaseObj,[4.20,4.20,59.07]]] remoteExec ['attachTo'];   
		private _y = 0;  
		private _p = -90;  
		private _r = 90;  
		[  
		rocketFuselage,  
		[     
		[    
			sin _y * cos _p,     
			cos _y * cos _p,     
			sin _p    
		],                         
		[    
			[    
			sin _r,     
			-sin _p,     
			cos _r * cos _p    
			],     
			-_y    
		] call BIS_fnc_rotateVector2D     
		]  
		] remoteExec ['setVectorDirAndUp']; 
		[rocketFuselage, 29] remoteExec ['setObjectScale'];
	";
	"
	(screenToWorld [0.5,0.5]) spawn M9SD_fnc_rocketAssembly;
	(getpos this) spawn M9SD_fnc_rocketAssembly;
	";
	comment "deleteVehicle this;";
	(screenToWorld getMousePosition) spawn M9SD_fnc_rocketAssembly;


comment "------- ------- ------- ------- ------- ------- -------  -------  ------- ";

comment "
A3_Interplanetary_Starship

Arma 3 Steam Workshop
https://steamcommunity.com/sharedfiles/filedetails/?id=3050062499

MIT License
Copyright (c) 2023 M9-SD
https://github.com/M9-SD/A3_Interplanetary_Starship/blob/main/LICENSE
";
