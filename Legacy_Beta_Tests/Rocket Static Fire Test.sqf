


comment "
Run all effects for 40 seconds
";




[] spawn {
	_pos = screenToWorld [0.5,0.5];
	_pos set [2, (_pos # 2) + 50];

	_dummyEngine =  "Land_HelipadEmpty_F" createVehicle _pos;



















};






















