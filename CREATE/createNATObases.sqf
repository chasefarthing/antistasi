if (!isServer and hasInterface) exitWith {};

params ["_marker"];
private ["_allVehicles","_allGroups","_allSoldiers","_guerSoldiers","_guerVehicles","_markerPos","_guerGroups","_size","_support","_buildings","_statics","_pos1","_pos2","_direction","_group","_spawnPos","_vehicleType","_vehicle","_static","_observer","_counter","_unit","_flag","_maxVehicles","_groupType","_gunnerGroup","_building","_buildingType"];

_allVehicles = [];
_allGroups = [];
_allSoldiers = [];

_guerSoldiers = [];
_guerGroups = [];
_guerVehicles = [];

_markerPos = getMarkerPos (_marker);
_size = [_marker] call sizeMarker;

_support = (server getVariable "prestigeNATO")/100;
_statics = staticsToSave select {_x distance _markerPos < (_size max 50)};


_buildings = nearestObjects [_markerPos, listMilBld, _size*1.5];
_group = createGroup side_blue;
_allGroups pushBack _group;
for "_i" from 0 to (count _buildings) - 1 do {
	_building = _buildings select _i;
	_buildingType = typeOf _building;

	call {
		if ((_buildingType == "Land_Cargo_HQ_V1_F") OR (_buildingType == "Land_Cargo_HQ_V2_F") OR (_buildingType == "Land_Cargo_HQ_V3_F")) exitWith {
			_vehicle = createVehicle [selectRandom bluStatAA, (_building buildingPos 8), [],0, "CAN_COLLIDE"];
			_vehicle setPosATL [(getPos _building select 0),(getPos _building select 1),(getPosATL _vehicle select 2)];
			_vehicle setDir (getDir _building);
			_unit = ([_markerPos, 0, bluGunner, _group] call bis_fnc_spawnvehicle) select 0;
			_unit moveInGunner _vehicle;
			_allVehicles pushBack _vehicle;
			sleep 1;
		};

		if ((_buildingType == "Land_Cargo_Patrol_V1_F") OR (_buildingType == "Land_Cargo_Patrol_V2_F") OR (_buildingType == "Land_Cargo_Patrol_V3_F")) then {
			_vehicle = createVehicle [selectRandom bluStatHMG, (_building buildingPos 1), [], 0, "CAN_COLLIDE"];
			_direction = (getDir _building) - 180;
			_spawnPos = [getPosATL _vehicle, 2.5, _direction] call BIS_Fnc_relPos;
			_vehicle setPosATL _spawnPos;
			_vehicle setDir (getDir _building) - 180;
			_unit = ([_markerPos, 0, bluGunner, _group] call bis_fnc_spawnvehicle) select 0;
			_unit moveInGunner _vehicle;
			_allVehicles pushBack _vehicle;
			sleep 1;
		};

		if (_buildingType in listbld) then {
			_vehicle = createVehicle [selectRandom bluStatHMG, (_building buildingPos 11), [], 0, "CAN_COLLIDE"];
			_unit = ([_markerPos, 0, bluGunner, _group] call bis_fnc_spawnvehicle) select 0;
			_unit moveInGunner _vehicle;
			_allVehicles pushBack _vehicle;
			sleep 1;

			_vehicle = createVehicle [selectRandom bluStatHMG, (_building buildingPos 13), [], 0, "CAN_COLLIDE"];
			_unit = ([_markerPos, 0, bluGunner, _group] call bis_fnc_spawnvehicle) select 0;
			_unit moveInGunner _vehicle;
			_allVehicles pushBack _vehicle;
			sleep 1;
		};
	};
};

_spawnPos = [_markerPos, 3,0] call BIS_fnc_relPos;
_flag = createVehicle [bluFlag, _spawnPos, [],0, "CAN_COLLIDE"];
_flag allowDamage false;
_allVehicles pushBack _flag;
[_flag,"unit"] remoteExec ["AS_fnc_addActionMP"];
[_flag,"vehicle"] remoteExec ["AS_fnc_addActionMP"];
[_flag,"garage"] remoteExec ["AS_fnc_addActionMP"];

_maxVehicles = 4 min (round ((_size / 30)*_support));
if ( _maxVehicles > 0 ) then {
	_spawnPos = [_markerPos, random (_size / 2),random 360] call BIS_fnc_relPos;
	_counter = 0;
	while {(spawner getVariable _marker) AND (_counter < _maxVehicles)} do {
		_spawnPos = [_markerPos] call mortarPos;
		_vehicle = selectRandom bluStatMortar createVehicle _spawnPos;
		[_vehicle] execVM "scripts\UPSMON\MON_artillery_add.sqf";
		_unit = ([_markerPos, 0, bluGunner, _group] call bis_fnc_spawnvehicle) select 0;
		_unit moveInGunner _vehicle;
		_allVehicles pushBack _vehicle;
		sleep 1;
		_counter = _counter + 1;
	};
};

{[_x] spawn NATOinit} forEach _allSoldiers;
{[_x] spawn NATOVEHinit} forEach _allVehicles;

_maxVehicles = 1 max (round ((_size/30)*_support));
_spawnPos = _markerPos;
_counter = 0;
while {(spawner getVariable _marker) AND (_counter < _maxVehicles)} do {
	if (diag_fps > minimoFPS) then {
		_vehicleType = vehNATO call BIS_fnc_selectRandom;
		if (_size > 40) then {_spawnPos = [_markerPos, 10, _size/2, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos} else {_spawnPos = _spawnPos findEmptyPosition [10,60,_vehicleType]};
		_vehicle = createVehicle [_vehicleType, _spawnPos, [], 0, "NONE"];
		_vehicle setDir random 360;
		_vehicle lock 3;
		_allVehicles pushBack _vehicle;
		sleep 1;
	};

	_counter = _counter + 1;
};

_groupType = [bluSquad, side_blue] call AS_fnc_pickGroup;
_group = [_markerPos, side_blue, _groupType] call BIS_Fnc_spawnGroup;
sleep 1;
[leader _group, _marker, "SAFE", "RANDOMUP","SPAWNED", "NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
_allGroups pushBack _group;

_counter = 0;
while {(spawner getVariable _marker) AND (_counter < _maxVehicles)} do {
	if (diag_fps > minimoFPS) then {
		while {true} do {
			_spawnPos = [_markerPos, random _size,random 360] call BIS_fnc_relPos;
			if (!surfaceIsWater _spawnPos) exitWith {};
		};

		_groupType = [bluSquad, side_blue] call AS_fnc_pickGroup;
		_group = [_spawnPos,side_blue, _groupType] call BIS_Fnc_spawnGroup;
		sleep 1;
		if (_counter == 0) then {
			[leader _group, _marker, "SAFE","SPAWNED","FORTIFY","NOVEH","NOFOLLOW"] execVM "scripts\UPSMON.sqf";
		}
		else {
			[leader _group, _marker, "SAFE","SPAWNED", "RANDOM","NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
		};
		_allGroups pushBack _group;
	};

	_counter = _counter + 1;
};

_gunnerGroup = createGroup side_blue;
_guerGroups pushBack _gunnerGroup;
_group = createGroup side_blue;
_guerGroups pushBack _group;
_garrison = garrison getVariable [_marker,[]];
_strength = count _garrison;
_counter = 0;
while {(spawner getVariable _marker) AND (_counter < _strength)} do {
	_unitType = _garrison select _counter;

	call {
		if (_unitType == guer_sol_UN) exitWith {
			_unit = _gunnerGroup createUnit [_unitType, _markerPos, [], 0, "NONE"];
			_spawnPos = [_markerPos] call mortarPos;
			_vehicle = guer_stat_mortar createVehicle _spawnPos;
			_guerVehicles pushBack _vehicle;
			[_vehicle] execVM "scripts\UPSMON\MON_artillery_add.sqf";
			_unit assignAsGunner _vehicle;
			_unit moveInGunner _vehicle;
		};

		if ((_unitType == guer_sol_RFL) AND (count _statics > 0)) exitWith {
			_static = _statics select 0;
			if (typeOf _static == guer_stat_mortar) then {
				_unit = _gunnerGroup createUnit [_unitType, _markerPos, [], 0, "NONE"];
				_unit moveInGunner _static;
				[_static] execVM "scripts\UPSMON\MON_artillery_add.sqf";
			} else {
				_unit = _gunnerGroup createUnit [_unitType, _markerPos, [], 0, "NONE"];
				_unit moveInGunner _static;
			};
			_statics = _statics - [_static];
		};

		_unit = _group createUnit [_unitType, _markerPos, [], 0, "NONE"];
		if (_unitType == guer_sol_SL) then {_group selectLeader _unit};
	};

	_counter = _counter + 1;
	sleep 0.5;
	if (count units _group == 8) then {
		_group = createGroup side_blue;
		_guerGroups pushBack _group;
		while {true} do {
			_spawnPos = [_markerPos, random _size,random 360] call BIS_fnc_relPos;
			if (!surfaceIsWater _spawnPos) exitWith {};
		};
	};
};

for "_i" from 0 to (count _guerGroups) - 1 do {
	_group = _guerGroups select _i;
	[leader _group, _marker, "SAFE","SPAWNED","RANDOM","NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";
};

{
	[_x] spawn VEHinit;
} forEach _guerVehicles;

{
	_group = _x;
	{
		[_x] spawn AS_fnc_initialiseFIAGarrisonUnit;
		_allSoldiers pushBack _x;
	} forEach units _group;
} forEach _guerSoldiers;

{
	_group = _x;
	{
	[_x] spawn NATOinit; _allSoldiers pushBack _x;
	} forEach units _group;
} forEach _allGroups;

{
	[_x] spawn NATOVEHinit;
} forEach _allVehicles;

_observer = objNull;
if ((random 100 < (((server getVariable "prestigeNATO") + (server getVariable "prestigeCSAT"))/10)) AND (spawner getVariable _marker)) then {
	_spawnPos = [];
	_group = createGroup civilian;
	while {true} do {
		_spawnPos = [_markerPos, round (random _size), random 360] call BIS_Fnc_relPos;
		if !(surfaceIsWater _spawnPos) exitWith {};
	};
	_observer = _group createUnit [selectRandom CIV_journalists, _spawnPos, [],0, "NONE"];
	[_observer] spawn CIVinit;
	_allGroups pushBack _group;
	[_observer, _marker, "SAFE", "SPAWNED","NOFOLLOW", "NOVEH2","NOSHARE","DoRelax"] execVM "scripts\UPSMON.sqf";
};

waitUntil {sleep 1; !(spawner getVariable _marker) OR (({!(vehicle _x isKindOf "Air")} count ([_size,0,_markerPos,"OPFORSpawn"] call distanceUnits)) > 2*(({alive _x} count _allSoldiers) + count ([_size,0,_markerPos,"BLUFORSpawn"] call distanceUnits)))};


if (spawner getVariable _marker) then {
	if (_marker != "FIA_HQ") then {[_marker] remoteExec ["mrkLOOSE",2]};
};

if (count ([distanciaSPWN,0,_markerPos,"BLUFORSpawn"] call distanceUnits) < 1) then {
	spawner setVariable [_marker,false,true];
};

waitUntil {sleep 1; !(spawner getVariable _marker)};

{if ((!alive _x) AND !(_x in destroyedBuildings)) then {destroyedBuildings = destroyedBuildings + [position _x]; publicVariableServer "destroyedBuildings"}} forEach _buildings;

[_allGroups + _guerGroups, _allSoldiers + _guerSoldiers, _allVehicles + _guerVehicles] spawn AS_fnc_despawnUnits;
if !(isNull _observer) then {deleteVehicle _observer};