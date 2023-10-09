

playSound3D ["A3\sounds_f\sfx\special_sfx\sparkles_wreck_3.wss", tachanka, false, getPosASL tachanka, 5, 1, 1600, 0, false];

playSound3D ["A3\sounds_f\air\sfx\SL_rope_break.wss", tachanka, false, getPosASL tachanka, 5, 1, 1600, 0, false];


// spread out flames

_flama = "#particlesource" createVehicleLocal (screenToWorld [0.5,0.5]);
_flama setParticleCircle [10,[0,0,0]];
_flama setParticleRandom [1,[10,10,0],[0,0,0],0,0.1,[0,0,0,0],1,0];
_flama setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,10,32,1],"","Billboard",1,5,[0,0,0],[0,0,0],0,10.07,7.9,0,[1,5,1],[[1,1,1,1],[1,1,1,1],[1,1,1,0]],[0.8],0, 0, "", "", _flama,0,true];
_flama setDropInterval 0.02;



// spread out fog

_alias_local_fog = "#particlesource" createVehicleLocal (screenToWorld [0.5,0.5]); 
_alias_local_fog setParticleCircle [50,[0,0,0]];
_alias_local_fog setParticleRandom [1,[50,50,0],[0,0,0],1,0.1,[0,0,0,0.1],0,0];
_alias_local_fog setParticleParams [["\A3\data_f\cl_basic",1,0,1],"","Billboard",1,10,[0,0,1],[0,0,0],3,10.1,7.9,0.01,[1,10,20],[[0.1,0.09,0.09,0],[0.1,0.09,0.09,0.5],[0.1,0.09,0.09,0]],[1],1,0,"","",_alias_local_fog];
_alias_local_fog setDropInterval 0.01;



// thick black smoke

_picior_sec = "#particlesource" createVehicleLocal (screenToWorld [0.5,0.5]);
_picior_sec setParticleCircle [1,[0,0,0]];
_picior_sec setParticleRandom [0.5,[0.3,0.3,0.3],[0,0,0],0,0.1,[0,0,0,0.1],0,0];
_picior_sec setParticleParams [["\a3\Data_f\ParticleEffects\Universal\Universal",16,7,48,1],"","Billboard",1,1.5,[0,0,0],[0,0,3.5],0,10,7.9,0,[3,3,2,2,2,1],[[0,0,0,1],[0,0,0,1],[0,0,0,1],[0,0,0,1],[0,0,0,0.5],[0,0,0,0]],[0.2],0,0,"","",_picior_sec,90];
_picior_sec setDropInterval 0.02;


// BIG FIRE

_picior = "#particlesource" createVehicleLocal (screenToWorld [0.5,0.5]);
_picior setParticleCircle [0.5,[0,0,0]];
_picior setParticleRandom [0.5,[0,0,0.3],[0,0,0],0,0.1,[0,0,0,0.1],0,0];
_picior setParticleParams [["\A3\data_f\cl_exp",1,0,1],"","Billboard",1,1.5,[0,0,0],[0,0,3.5],3,10,7.9,0,[4,0.5],[[1,1,1,1],[1,1,1,0]],[1],0,0,"","",_picior,90];
_picior setDropInterval 0.05;




// laggy mess of explosions

_palarie = "#particlesource" createVehicleLocal (screenToWorld [0.5,0.5]);
_palarie setParticleCircle [2,[-0.5,-0.5,0]];
_palarie setParticleRandom [0.5,[1,1,0.3],[0.3,0.3,0],0,0.1,[0,0,0,0.1],1,0];
_palarie setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,3,112,0],"","Billboard",1,3,[0,0,0],[0,0,6],0,15,7.9,0,[2,5],[[1,1,1,1],[0,0,0,0]],[0.1],1,0,"","",_palarie,45];
_palarie setDropInterval 0.001;

// black smoke wave

_wave = "#particlesource" createVehicleLocal (screenToWorld [0.5,0.5]);
_wave setParticleCircle [3,[20,20,0]];
_wave setParticleRandom [0.1,[3,3,0],[-10,-10,0],0,0.1,[0,0,0,0.1],0,0];
_wave setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1],"","Billboard",1,2,[0,0,0],[0,0,0],0,17,13,0,[10,30],[[0,0,0,0.5],[0,0,0,0]],[1],0,0,"","",_wave];
_wave setDropInterval 0.005;

// white smoke/vapor expands very quickly and then dissapates quickly

_vapori_bmb = "#particlesource" createVehicleLocal (screenToWorld [0.5,0.5]);
_vapori_bmb setParticleCircle [0,[0,0,0]];
_vapori_bmb setParticleRandom [0,[0,0,0],[0,0,0],0,0,[0,0,0,0],0,0];
_vapori_bmb setParticleParams [["\A3\data_f\cl_basic",1,0,1],"","Billboard",1,0.5,[0,0,0],[0,0,3],0,10,7.9,0,[1,100],[[1,1,1,0.5],[1,1,1,0]],[1],0,0,"","",_vapori_bmb];
_vapori_bmb setDropInterval 500;


// explosion 


_part_hit = "#particlesource" createVehicleLocal (screenToWorld [0.5,0.5]);
_part_hit setParticleCircle [0,[0,0,0]];
_part_hit setParticleRandom [0,[0,0,0],[0,0,0],0,0,[0,0,0,0],0,0];
_part_hit setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,0,32,0],"","Billboard",1,1,[0,0,0],[0,0,0],5,10,7.9,0,[5,15],[[1,1,1,1],[1,1,1,1]],[2],0,0,"","",_part_hit];
_part_hit setDropInterval 5;

// lots of sparks

_scantei = "#particlesource" createVehicleLocal (screenToWorld [0.5,0.5]);
_scantei setParticleCircle [2,[40,40,50]];
_scantei setParticleRandom [1,[0.5,0.5,0.5],[30,30,20],0,0.1,[0,0,0,0.1],1,0];
_scantei setParticleParams [["\A3\data_f\cl_exp",1,0,1],"","Billboard",1,3,[0,0,1],[0,0,0],0,300,10,15,[0.3,0.1],[[1,1,1,1],[1,1,1,1]],[1],1,0,"","",_scantei,0,false,-1,[[1,0.1,0,1]]];
_scantei setDropInterval 0.01;	


// slipspace rupture border


_center = (screenToWorld [0.5,0.5]);
_border = "#particlesource" createVehicleLocal _center;
_border setParticleParams [
["A3\Data_F\ParticleEffects\Universal\smoke.p3d", 1, 0, 1], "",
"Billboard",
1,
1.25,
[0, 0, 0],
[0, 0, 0],
0, 1.5, 1, 0,
[40, 60, 30],
[[0.1, 0.5, 1, 0], [0.05, 0.05, 0.05, 5], [0.05, 0.05, 0.05, 10], [0.025, 0.025, 0.025, 0]],
[1,0.5],
0.1,
1,
"",
"",
_center];
_border setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0, 360];
_border setDropInterval 0.0002;
_border setParticleCircle [100, [300, 300, 5]];


// slipspace rupture origin

_center = (screenToWorld [0.5,0.5]);
_origin = "#particlesource" createVehicleLocal _center;
_origin setParticleParams [
["A3\Data_F\ParticleEffects\Universal\smoke.p3d", 1, 0, 1], "",
"Billboard",
1,
1.45,
[0, 0, 0],
[0, 0, 0],
0, 1.5, 1, 0,
[20, 45],
[[0.1, 0.5, 1, -15], [0.1, 0.5, 1, -10], [0.05, 0.25, 1, -5], [0.05, 0.25, 1, 0]],
[1,0.5],
0.1,
1,
"",
"",
_center];
_origin setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0, 360];
_origin setParticleCircle [2, [250, 250, 2.5]];
_origin setDropInterval 0.0002;


// slipspace rupture fire


_center = (screenToWorld [0.5,0.5]);

_fire = "#particlesource" createVehicleLocal _center;
_fire setVectorUp [0,1,0];
_fire setParticleParams [
["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 48, 0], "",
"Billboard",
1,
1.75,
[0, 0, 0],
[0, 0, 0],
4, 1.5, 1, 0,
[70,90,120,30],
[[0, 0.25, 1, -10],[0, 0.25, 1, -7],[0, 0.25, 1, -5],[0, 0.25, 1, -2],[0, 0.25, 1, -1]],
[0.05],
1,
1,
"",
"",
_center];
_fire setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_fire setDropInterval 0.002;
_fire setParticleCircle [25, [200, 200, 2.5]];

// slipsace rupture wave

_center = (screenToWorld [0.5,0.5]);

_wave = "#particlesource" createVehicleLocal _center;
_wave setParticleParams [
["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "",
"Billboard",
1,
25,
[0, 0, 0],
[0, 0, 0],
0, 1.5, 1, 0,
[100, 100, 80, 70, 60, 30, 20, 5],
[[0.1, 0.1, 0.1, 0.5], [0.5, 0.5, 0.5, 0.5], [1, 1, 1, 0.3], [1, 1, 1, 0]],
[1,0.5],
0.1,
1,
"",
"",
_center];
_wave setParticleRandom [2, [20, 20, 20], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
_wave setParticleCircle [50, [-120, -120, 2.5]];
_wave setDropInterval 0.0002;

// altered wave

_center = (screenToWorld [0.5,0.5]);
_wave = "#particlesource" createVehicleLocal _center;
_wave setParticleParams [
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
_center];
_wave setDropInterval 0.004;

_wave setParticleRandom [2, [20, 20, 20], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
_wave setParticleCircle [60, [-60, 60, 2.5]];

