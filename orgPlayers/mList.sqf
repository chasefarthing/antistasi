if !(isServer) exitWith {};

private ["_mList"];

_mList = [
	"76561197960604947",
	"76561197962099476",
	"76561197971206352",
	"76561197972995501",
	"76561197977395374",
	"76561197979729653",
	"76561197981549243",
	"76561197983004373",
	"76561197983686485",
	"76561197985005719",
	"76561197988778391",
	"76561197992975040",
	"76561198005296652",
	"76561198011043004",
	"76561198013878464",
	"76561198015557763",
	"76561198016063072",
	"76561198016630176",
	"76561198018659169",
	"76561198030263984",
	"76561198034977762",
	"76561198036417817",
	"76561198038487624",
	"76561198039888227",
	"76561198044772595",
	"76561198050045926",
	"76561198052336764",
	"76561198068948124",
	"76561198087534605",
	"76561198093241035",
	"76561198104698955",
	"76561198138138288",
	"76561198187982333",
	"76561198209790760"
];

{
	miembros pushBackUnique _x;
} forEach _mList;
publicVariable "miembros";