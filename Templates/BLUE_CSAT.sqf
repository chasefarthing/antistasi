bluHeliTrans = 		["O_Heli_Light_02_unarmed_F","O_Heli_Light_02_F","O_Heli_Transport_04_covered_F"];
bluHeliTS = 		["O_Heli_Light_02_unarmed_F"];
bluHeliDis = 		["O_Heli_Light_02_F"];
bluHeliRope = 		["O_Heli_Transport_04_covered_F"];
bluHeliArmed = 		["O_Heli_Light_02_F"];
bluHeliGunship = 	["O_Heli_Attack_02_F"];
bluCASFW = 			["O_Plane_CAS_02_F"];

bluAS = 			["O_Plane_CAS_02_F"];
bluC130 = 			["O_Plane_CAS_02_F"];

bluUAV = 			["I_UAV_02_CAS_F"];

planesNATO = bluHeliTrans + bluHeliArmed + bluHeliGunship + bluCASFW;
planesNATOTrans = bluHeliTrans;


bluMBT = 		["O_MBT_02_cannon_F","O_MBT_02_cannon_F"];
bluAPC = 		["O_APC_Wheeled_02_rcws_F"];
bluIFV = 		["O_APC_Tracked_02_cannon_F"];
bluIFVAA = 		["O_APC_Tracked_02_AA_F"];
bluArty = 		["O_MBT_02_arty_F"]; bluArtyAmmoHE = "32Rnd_155mm_Mo_shells"; bluArtyAmmoLaser = "2Rnd_155mm_Mo_LG"; bluArtyAmmoSmoke = "2Rnd_155mm_Mo_LG";
bluMLRS = 		["O_MBT_02_arty_F"];
bluMRAP =		["O_MRAP_02_F"];
bluMRAPHMG =	["O_MRAP_02_hmg_F"];
bluTruckTP = 	["O_Truck_03_covered_F"];
bluTruckMed = 	["O_Truck_03_medical_F"];
bluTruckFuel = 	["O_Truck_03_fuel_F"];

vehNATO = bluMBT + bluAPC + bluIFV + bluIFVAA + bluArty + bluMLRS + bluMRAP + bluMRAPHMG + bluTruckTP + bluTruckMed + bluTruckFuel;


bluStatAA = 	["O_static_AA_F"];
bluStatAT = 	["O_static_AT_F"];
bluStatHMG = 	["O_HMG_01_high_F"];
bluStatMortar = ["O_Mortar_01_F"];


bluPilot = 	"O_Pilot_F";
bluCrew = 	"O_crew_F";
bluGunner = "O_support_MG_F";

bluMRAPHMGgroup = 	["O_recon_LAT_F","O_Sharpshooter_F"];
bluMRAPgroup = 		["O_medic_F","O_recon_F","O_recon_JTAC_F"];

bluAirCav = 	["O_recon_TL_F","O_recon_LAT_F","O_recon_M_F","O_recon_medic_F","O_recon_F","O_recon_JTAC_F"];


bluSquad = 			["OIA_InfSquad"];
bluSquadWeapons = 	["OIA_InfSquad_Weapons"];
bluTeam = 			["OIA_InfTeam"];
bluATTeam = 		["OIA_InfTeam_AT"];

bluIR = 	"acc_pointer_IR";

bluFlag = 	"Flag_CSAT_F";

bluCfgInf = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry");


bluRifle = [
	"arifle_MX_F",
	"arifle_MX_SW_F"
];

bluGL = [
	"arifle_MX_GL_F"
];

bluSNPR = [
	"srifle_LRR_F",
	"srifle_DMR_02_F",
	"srifle_EBR_F",
	"srifle_DMR_03_F"
];

bluLMG = [
	"MMG_02_sand_F",
	"arifle_MX_SW_F"
];

bluSmallWpn = [
	"SMG_01_F",
	"hgun_ACPC2_F"
];

bluRifleAmmo = [
	"30Rnd_65x39_Caseless_mag",
	"30Rnd_65x39_caseless_mag_Tracer"
];

bluSNPRAmmo = [
	"7Rnd_408_Mag",
	"10Rnd_338_Mag",
	"20Rnd_762x51_Mag"
];

bluLMGAmmo = [
	"130Rnd_338_Mag",
	"100Rnd_65x39_Caseless_mag",
	"100Rnd_65x39_caseless_mag_Tracer"
];

bluSmallAmmo = [
	"30Rnd_45ACP_Mag_SMG_01",
	"30Rnd_45ACP_Mag_SMG_01_tracer_green",
	"11Rnd_45ACP_Mag"
];

bluAmmo = [
	"30Rnd_65x39_Caseless_mag",
	"30Rnd_65x39_caseless_mag_Tracer",
	"100Rnd_65x39_Caseless_mag",
	"100Rnd_65x39_caseless_mag_Tracer",
	"20Rnd_762x51_Mag",
	"7Rnd_408_Mag",
	"30Rnd_45ACP_Mag_SMG_01",
	"30Rnd_45ACP_Mag_SMG_01_tracer_green",
	"11Rnd_45ACP_Mag",
	"20Rnd_762x51_Mag",
	"10Rnd_338_Mag",
	"130Rnd_338_Mag"
];

blu40mm = [
	"1Rnd_HE_Grenade_shell",
	"1Rnd_Smoke_Grenade_shell"
];

bluGrenade = [
	"HandGrenade"
];

bluAT = [
	"launch_B_Titan_short_F",
	"launch_NLAW_F"
];

bluAA = [
	"launch_B_Titan_F"
];

bluVest = [
	"V_PlateCarrierSpec_mtp"
];

bluScopes = [
	"optic_Nightstalker",
	"optic_Holosight",
	"optic_Hamr",
	"optic_ERCO_snd_F"
];

bluAttachments = [
	"muzzle_snds_338_sand",
	"bipod_01_F_snd",
	"muzzle_snds_H_khk_F",
	"muzzle_snds_B_snd_F"
];

bluATMissile = [
	"NLAW_F",
	"Titan_AT",
	"Titan_AP"
];

bluAAMissile = [
	"Titan_AA"
];

bluItems = bluVest + bluScopes + bluAttachments;

genGL = genGL + bluGL;
//genATLaunchers = genATLaunchers + bluAT; // using vanilla launchers right now
//genAALaunchers = genAALaunchers + bluAA;

// Colour of this faction's markers
BLUFOR_marker_colour = "ColorEAST";

// Type of this faction's markers
BLUFOR_marker_type = "flag_CSAT";

// Name of the faction
A3_Str_BLUE = localize "STR_GENIDENT_VMF";
