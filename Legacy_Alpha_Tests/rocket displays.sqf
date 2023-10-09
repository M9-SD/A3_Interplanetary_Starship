 
 
 
 
deleteVehicle rocket1; 
deleteVehicle table1; 
 
posAGL = screenToWorld [0.5, 0.5]; 
posASL = AGLToASL posAGL; 
posASL set [2, (posASL # 2) + 3.5]; 
 
rocket1 = createSimpleObject ["ammo_Missile_mim145", posASL]; 
rocket1 setPosASL posASL; 
 
posASL set [2, (posASL # 2) - 3.5]; 
 
table1 = createSimpleObject ["Land_BriefingRoomDesk_01_F", posASL]; 
table1 setPosASL posASL; 
 
 
 
rocket1 setVectorDirAndUp  
(  
 [[vectorDirVisual rocket1, vectorUpVisual rocket1], 0, -90, 0] call BIS_fnc_transformVectorDirAndUp  
); 
 
 
 
 
 
 
 
 
 
 
 
deleteVehicle rocket2; 
deleteVehicle table2; 
 
posAGL = screenToWorld [0.5, 0.5]; 
posASL = AGLToASL posAGL; 
posASL set [2, (posASL # 2) + 3.5]; 
 
rocket2 = createSimpleObject ["ammo_Missile_HARM", posASL]; 
rocket2 setPosASL posASL; 
 
posASL set [2, (posASL # 2) - 3.5]; 
 
table2 = createSimpleObject ["Land_BriefingRoomDesk_01_F", posASL]; 
table2 setPosASL posASL; 
 
 
 
rocket2 setVectorDirAndUp  
(  
 [[vectorDirVisual rocket2, vectorUpVisual rocket2], 0, -90, 0] call BIS_fnc_transformVectorDirAndUp  
); 






 
deleteVehicle rocket3; 
deleteVehicle table3; 
 
posAGL = screenToWorld [0.5, 0.5]; 
posASL = AGLToASL posAGL; 
posASL set [2, (posASL # 2) + 3.5]; 
 
rocket3 = createSimpleObject ["BombCluster_01_Ammo_F", posASL]; 
rocket3 setPosASL posASL; 
 
posASL set [2, (posASL # 2) - 3.5]; 
 
table3 = createSimpleObject ["Land_BriefingRoomDesk_01_F", posASL]; 
table3 setPosASL posASL; 
 
 
 
rocket3 setVectorDirAndUp  
(  
 [[vectorDirVisual rocket3, vectorUpVisual rocket3], 0, -90, 0] call BIS_fnc_transformVectorDirAndUp  
); 



deleteVehicle rocket4; 
deleteVehicle table4; 
 
posAGL = screenToWorld [0.5, 0.5]; 
posASL = AGLToASL posAGL; 
posASL set [2, (posASL # 2) + 3.5]; 
 
rocket4 = createSimpleObject ["Bomb_03_F", posASL]; 
rocket4 setPosASL posASL; 
 
posASL set [2, (posASL # 2) - 3.5]; 
 
table4 = createSimpleObject ["Land_BriefingRoomDesk_01_F", posASL]; 
table4 setPosASL posASL; 
 
 
 
rocket4 setVectorDirAndUp  
(  
 [[vectorDirVisual rocket4, vectorUpVisual rocket4], 0, -90, 0] call BIS_fnc_transformVectorDirAndUp  
); 







Bomb_03_F
BombCluster_01_Ammo_F
BombCluster_02_Ammo_F
BombCluster_03_Ammo_F
BombCluster_02_cap_Ammo_F
ammo_Missile_KH58





 
posAGL = screenToWorld [0.5, 0.5]; 
posASL = AGLToASL posAGL; 
posASL set [2, (posASL # 2) + 3.5]; 
 
_rocket = createSimpleObject ["ammo_Missile_KH58", posASL]; 
_rocket setPosASL posASL; 
 
posASL set [2, (posASL # 2) - 3.5]; 
 
_table = createSimpleObject ["Land_BriefingRoomDesk_01_F", posASL]; 
_table setPosASL posASL; 
 
 
 
_rocket setVectorDirAndUp  
(  
 [[vectorDirVisual _rocket, vectorUpVisual _rocket], 0, -90, 0] call BIS_fnc_transformVectorDirAndUp  
); 














