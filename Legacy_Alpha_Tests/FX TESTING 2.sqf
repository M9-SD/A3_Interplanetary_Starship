createVehicle ["HelicopterExploBig", screenToWorld [0.5,0.5], [], 0, "CAN_COLLIDE"];

if (!isNil 'explosionFX') then {deleteVehicle explosionFX}; 
explosionFX = createVehicle ["#particlesource", screenToWorld [0.5,0.5], [], 0, "CAN_COLLIDE"]; 
explosionFX setParticleClass "FX_WingTrail_FighterJet";

if (!isNil 'explosionFX') then {deleteVehicle explosionFX};
explosionFX = createVehicle ["#particlesource", screenToWorld [0.5,0.5], [], 0, "CAN_COLLIDE"];
explosionFX setParticleClass "HelicopterExploBig";

// laser origin
if (!isNil 'explosionFX') then {deleteVehicle explosionFX}; 
explosionFX = createVehicle ["#particlesource", screenToWorld [0.5,0.5], [], 0, "CAN_COLLIDE"]; 
explosionFX setParticleClass "ImpactSparksSabot2";

// laser end point
if (!isNil 'explosionFX') then {deleteVehicle explosionFX}; 
explosionFX = createVehicle ["#particlesource", screenToWorld [0.5,0.5], [], 0, "CAN_COLLIDE"]; 
explosionFX setParticleClass "MineExplosionParticles";

if (!isNil 'explosionFX') then {deleteVehicle explosionFX}; 
explosionFX = createVehicle ["#particlesource", screenToWorld [0.5,0.5], [], 0, "CAN_COLLIDE"]; 
explosionFX setParticleClass "IncinerateFire";

if (!isNil 'explosionFX') then {deleteVehicle explosionFX}; 
explosionFX = createVehicle ["#particlesource", screenToWorld [0.5,0.5], [], 0, "CAN_COLLIDE"]; 
explosionFX setParticleClass "ExpSparks1";

if (!isNil 'explosionFX') then {deleteVehicle explosionFX}; 
explosionFX = createVehicle ["#particlesource", screenToWorld [0.5,0.5], [], 0, "CAN_COLLIDE"]; 
explosionFX setParticleClass "FireSparks";

if (!isNil 'explosionFX') then {deleteVehicle explosionFX}; 
explosionFX = createVehicle ["#particlesource", screenToWorld [0.5,0.5], [], 0, "CAN_COLLIDE"]; 
explosionFX setParticleClass "ExploRocksdark";

if (!isNil 'explosionFX') then {deleteVehicle explosionFX}; 
explosionFX = createVehicle ["#particlesource", screenToWorld [0.5,0.5], [], 0, "CAN_COLLIDE"]; 
explosionFX setParticleClass "ExploRocks";

if (!isNil 'explosionFX') then {deleteVehicle explosionFX}; 
explosionFX = createVehicle ["#particlesource", screenToWorld [0.5,0.5], [], 0, "CAN_COLLIDE"]; 
explosionFX setParticleClass "ClusterExplosion";


ClusterExpFire

if (!isNil 'explosionFX') then {deleteVehicle explosionFX}; 
explosionFX = createVehicle ["#particlesource", screenToWorld [0.5,0.5], [], 0, "CAN_COLLIDE"]; 
explosionFX setParticleClass "ClusterExpFire";



if (!isNil 'explosionFX') then {deleteVehicle explosionFX}; 
explosionFX = createVehicle ["#particlesource", screenToWorld [0.5,0.5], [], 0, "CAN_COLLIDE"]; 
explosionFX setParticleClass "BombSmk2";
explosionFX setParticleCircle [3, [0,0,0]];






if (!isNil 'explosionFX') then {deleteVehicle explosionFX}; 
explosionFX = createVehicle ["#particlesource", screenToWorld [0.5,0.5], [], 0, "CAN_COLLIDE"]; 
explosionFX setParticleClass "IEDMineFireStones";



if (!isNil 'explosionFX') then {deleteVehicle explosionFX}; 
explosionFX = createVehicle ["#particlesource", screenToWorld [0.5,0.5], [], 0, "CAN_COLLIDE"]; 
explosionFX setParticleClass "IEDMineStonesBig";







