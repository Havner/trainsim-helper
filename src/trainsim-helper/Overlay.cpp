#include "stdafx.h"

#include <stdio.h>
#include <errno.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string>

#include "Config.h"
#include "Overlay.h"
#include "Value.h"


#define GETHOURS(nClock)		((nClock) / 3600)
#define GETMINUTES(nClock)		(((nClock) % 3600) / 60)
#define GETSECONDS(nClock)		((nClock) % 60)
#define ACCEL_TABLE_SIZE		30
#define BOILER_TABLE_SIZE		5
#define SECTIONS_TABLE_SIZE		eOverlaySize
#define STRING_SIZE				512

#define MPS_TO_MPH				2.23694f
#define METRES_TO_MILES			0.000621371f
#define MPS_TO_KPH				3.6f
#define METRES_TO_KILOMETRES	0.001f

int g_nWidth;
int g_nHeight;
bool g_bHideSection[SECTIONS_TABLE_SIZE];
int g_nAccelIndex;
float g_fAccelTable[ACCEL_TABLE_SIZE];
int g_nBoilerIndex;
float g_fBoilerTable[BOILER_TABLE_SIZE];
double g_fDistance;
double g_fPrevSimulationTime;
double g_fPrevSimulationTime2;
double g_fAcceleration; // TODO: doesn't have to be global
double g_fPrevSpeed;
bool g_bCountdown;
char g_nCountdownDigits[4];
int g_nSetCountdownProgress;
bool g_bInvert;
bool g_bFontOutline = true;
bool g_bSpeedLimitOnly;

LPDIRECT3D9 d3d;    // the pointer to our Direct3D interface
LPDIRECT3DDEVICE9 d3ddev;

LPD3DXFONT pSmallFont;
LPD3DXFONT pMediumFont;
LPD3DXFONT pBigFont;
LPD3DXFONT pBigFixedFont;

DWORD transparent = D3DCOLOR_ARGB(0,0,0,0);
DWORD white = D3DCOLOR_ARGB(255,255,255,255);
DWORD whitered = D3DCOLOR_ARGB(255,255,200,200);
DWORD whitegreen = D3DCOLOR_ARGB(255,200,255,200);
DWORD whiteblue = D3DCOLOR_ARGB(255,200,200,255);
DWORD red = D3DCOLOR_ARGB(255,200,0,0);
DWORD green = D3DCOLOR_ARGB(255,0,200,0);
DWORD blue = D3DCOLOR_ARGB(255,0,0,200);
DWORD yellow = D3DCOLOR_ARGB(255,200,200,0);
DWORD grey = D3DCOLOR_ARGB(255,200,200,200);


struct SimData {
	// SIM values
	Value<int>			nClock;
	Value<double>		fSpeed;
	Value<float>		fSpeedLimit;
	Value<int>			nNextSpeedLimitType;
	Value<float>		fNextSpeedLimit;
	Value<float>		fNextSpeedLimitDistance;
	Value<int>			nNextSpeedLimitBackType;
	Value<float>		fNextSpeedLimitBack;
	Value<float>		fNextSpeedLimitBackDistance;
	Value<float>		fAcceleration; // unused, calculated from speed/time
	Value<float>		fGradient;

	// Units
	Value<std::string>	sUnits;
	Value<std::string>	sVacuumBrakePipeUnits;
	Value<std::string>	sVacuumBrakeChamberUnits;
	Value<std::string>	sTrainBrakeCylinderUnits;
	Value<std::string>	sLocoBrakeCylinderUnits;
	Value<std::string>	sAirBrakePipeUnits;
	Value<std::string>	sMainReservoirUnits;
	Value<std::string>	sEqReservoirUnits;

	// Loco's controls
	Value<float>		fTargetSpeed;
	Value<float>		fReverser;
	Value<float>		fGearLever;
	Value<float>		fPower;
	Value<float>		fCombinedThrottle;
	Value<float>		fThrottle;
	Value<float>		fTrainBrake;
	Value<float>		fLocoBrake;
	Value<float>		fDynamicBrake;
	Value<float>		fHandBrake;

	// Loco's indicators
	Value<float>		fBoilerPressure;
	Value<float>		fBackPressure;
	Value<float>		fSteamChestPressure;
	Value<float>		fSteamHeatingPressure;
	Value<float>		fSandbox;
	Value<float>		fSandboxRear;
	Value<float>		fVoltage;
	Value<int>			nRPM;
	Value<float>		fAmmeter;

	// Brake's indicators
	Value<float>		fVacuumBrakePipePressure;
	Value<float>		fVacuumBrakeChamberPressure;
	Value<float>		fTrainBrakeCylinderPressure;
	Value<float>		fLocoBrakeCylinderPressure;
	Value<float>		fAirBrakePipePressure;
	Value<float>		fMainReservoirPressure;
	Value<float>		fEqReservoirPressure;

	// Steamers (driver, displayed in separate section)
	Value<float>		fBlowOffCockShutOffRight;
	Value<float>		fDynamo;
	Value<float>		fAirPump;
	Value<float>		fSteamHeatingShutOff;
	Value<float>		fSteamHeating;
	Value<float>		fMasonsValve;
	Value<float>		fSteamManifold;
	Value<float>		fLubricatorSteam;
	Value<float>		fLubricator;
	Value<float>		fLubricatorWarming;
	Value<float>		fSmallEjector;
	Value<float>		fLargeEjector;
	Value<float>		fBrakeHook;
	Value<float>		fSanderSteam;
	Value<float>		fSander;
	Value<float>		fSanderRear;
	Value<float>		fSanderCaps;
	Value<float>		fSanderFill;
	Value<float>		fAshpanSprinkler;
	Value<float>		fCylinderCock;
	Value<float>		fCylinderCockMaster;
	Value<float>		fWaterScoop;

	// Steamers (fireman, displayed on the right side)
	Value<float>		fBlowOffCockShutOffLeft;
	Value<float>		fFeedWaterPumpShutOff;
	Value<float>		fControlValve;
	Value<float>		fExhaustInjectorShutOff;
	Value<float>		fLiveInjectorShutOff;
	Value<float>		fTenderWaterShutOff;

	Value<float>		fFireboxMass;
	Value<float>		fAtomizerPressure;
	Value<float>		fTankTemperature;
	Value<float>		fFireboxDoor;
	Value<float>		fStoking;
	Value<float>		fOilRegulator;
	Value<float>		fAtomizer;
	Value<float>		fTankHeater;
	Value<float>		fBlower;
	Value<float>		fDamper;
	Value<float>		fDamperLeft;
	Value<float>		fDamperRight;
	Value<float>		fDamperFront;
	Value<float>		fDamperRear;

	Value<float>		fWaterGauge;
	Value<float>		fFeedWaterPressure;
	Value<float>		fFeedWaterPump;
	Value<float>		fExhaustInjectorSteam;
	Value<float>		fExhaustInjectorWater;
	Value<float>		fLiveInjectorSteam;
	Value<float>		fLiveInjectorWater;

	Value<float>		fSafetyValve1;
	Value<float>		fSafetyValve2;
	Value<float>		fSafetyValve3;

	// Warning values
	Value<int>			nSunflower;
	Value<int>			nAlarm;
	Value<int>			nVigilAlarm;
	Value<int>			nEmergencyBrake;
	Value<int>			nStartup;
	Value<int>			nDoors;

	// Config values
	Value<std::string>  sTextAlarm;
	Value<std::string>  sTextVigilAlarm;
	Value<std::string>  sTextEmergency;
	Value<std::string>  sTextStartup;
	Value<std::string>  sTextDoors;
	Value<int>			nGradientUK;

	// Misc
	Value<double>		fSimulationTime;
};

void ToggleDisplaySection(int s)
{
	if (s >= 0 && s < SECTIONS_TABLE_SIZE)
		g_bHideSection[s] = !g_bHideSection[s];
}

void ToggleInvert()
{
	g_bInvert = !g_bInvert;
}

void ToggleFontOutline()
{
	g_bFontOutline = !g_bFontOutline;
}

void ToggleSpeedLimitOnly()
{
	g_bSpeedLimitOnly = !g_bSpeedLimitOnly;
}

void ResetDistance()
{
	g_fDistance = 0.0;
	g_bCountdown = false;
	g_nSetCountdownProgress = 0;
}

void SetCountdown(char n)
{
	if (n >= 0 && n <= 9 && g_nSetCountdownProgress < 4)
	{
		g_nCountdownDigits[g_nSetCountdownProgress] = n;
		g_nSetCountdownProgress++;
		g_fPrevSimulationTime2 = g_fPrevSimulationTime;
	}
}

void InitD3D(HWND hWnd, int nWidth, int nHeight)
{
	d3d = Direct3DCreate9(D3D_SDK_VERSION);    // create the Direct3D interface

	D3DPRESENT_PARAMETERS d3dpp;    // create a struct to hold various device information

	ZeroMemory(&d3dpp, sizeof(d3dpp));    // clear out the struct for use
	d3dpp.Windowed = TRUE;    // program windowed, not fullscreen
	d3dpp.SwapEffect = D3DSWAPEFFECT_DISCARD;    // discard old frames
	d3dpp.hDeviceWindow = hWnd;    // set the window to be used by Direct3D
	d3dpp.BackBufferFormat = D3DFMT_A8R8G8B8;     // set the back buffer format to 32-bit
	d3dpp.BackBufferWidth = nWidth;    // set the width of the buffer
	d3dpp.BackBufferHeight = nHeight;    // set the height of the buffer

	d3dpp.EnableAutoDepthStencil = TRUE;
	d3dpp.AutoDepthStencilFormat = D3DFMT_D16;

	// create a device class using this information and the info from the d3dpp stuct
	d3d->CreateDevice(D3DADAPTER_DEFAULT,
		D3DDEVTYPE_HAL,
		hWnd,
		D3DCREATE_SOFTWARE_VERTEXPROCESSING,
		&d3dpp,
		&d3ddev);

	D3DXCreateFont(d3ddev, 16, 0, FW_NORMAL, 1, 0, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLEARTYPE_QUALITY, DEFAULT_PITCH | FF_DONTCARE, "Arial", &pSmallFont);
	D3DXCreateFont(d3ddev, 20, 0, FW_NORMAL, 1, 0, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLEARTYPE_QUALITY, DEFAULT_PITCH | FF_DONTCARE, "Arial", &pMediumFont);
	D3DXCreateFont(d3ddev, 40, 0, FW_NORMAL, 1, 0, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLEARTYPE_QUALITY, DEFAULT_PITCH | FF_DONTCARE, "Arial", &pBigFont);
	D3DXCreateFont(d3ddev, 80, 0, FW_BOLD, 1, 0, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLEARTYPE_QUALITY, DEFAULT_PITCH | FF_DONTCARE, "Courier New", &pBigFixedFont);

	g_nWidth = nWidth;
	g_nHeight = nHeight;
}

int NextSection(int y, int *yPrev, const int yDist)
{
	if (y == *yPrev)
		return y;

	y = y - yDist;
	*yPrev = y;

	return y;
}

int DrawString(eOverlayPart nPart, bool valid, int x, int y, DWORD color, LPD3DXFONT pFont, const char *fmt, ...)
{
	if (nPart != eAlways && g_bHideSection[nPart])
		return y;

	if (!valid)
		return y;

	if (pFont == pSmallFont)
		y -= 17;
	else if (pFont == pMediumFont)
		y -= 21;
	else if (pFont == pBigFont)
		y -= 50;

	DWORD black = D3DCOLOR_ARGB(color>>24,0,0,0);
	RECT FontPos =        { x,     y,     x + 10, y + 10 };
	RECT FontPosShadow1 = { x - 1, y - 1, x + 10, y + 10 };
	RECT FontPosShadow2 = { x + 1, y - 1, x + 10, y + 10 };
	RECT FontPosShadow3 = { x - 1, y + 1, x + 10, y + 10 };
	RECT FontPosShadow4 = { x + 1, y + 1, x + 10, y + 10 };

	char buf[STRING_SIZE] = {'\0'};
	va_list va_alist;
	va_start(va_alist, fmt);
	vsprintf_s(buf, fmt, va_alist);
	va_end(va_alist);

	if (g_bFontOutline)
	{
		pFont->DrawText(NULL, buf, -1, &FontPosShadow1, DT_NOCLIP, black);
		pFont->DrawText(NULL, buf, -1, &FontPosShadow2, DT_NOCLIP, black);
		pFont->DrawText(NULL, buf, -1, &FontPosShadow3, DT_NOCLIP, black);
		pFont->DrawText(NULL, buf, -1, &FontPosShadow4, DT_NOCLIP, black);
	}
	pFont->DrawText(NULL, buf, -1, &FontPos, DT_NOCLIP, color);

	return y;
}

int FillData(SimData* data)
{
	char param[256];
	char value[256];
	struct _stat stats;
	time_t systemtime;

	_stat(GETDATATXT, &stats);
	systemtime = time(NULL);
	if (systemtime - stats.st_mtime > 1)
		return -1;

	FILE *f = fopen(GETDATATXT, "r");
	if (f == NULL)
		return -1;

	for(;;) {
		int ret = fscanf(f, "%s %s\n", param, value);
		if (ret == 0 || ret == EOF)
			break;

		// SIM values
		if      (!strcmp("Clock:", param))						data->nClock = value;
		else if (!strcmp("Speed:", param))						data->fSpeed = value;
		else if (!strcmp("SpeedLimit:", param))					data->fSpeedLimit = value;
		else if (!strcmp("NextSpeedLimitType:", param))			data->nNextSpeedLimitType = value;
		else if (!strcmp("NextSpeedLimit:", param))				data->fNextSpeedLimit = value;
		else if (!strcmp("NextSpeedLimitDistance:", param))		data->fNextSpeedLimitDistance = value;
		else if (!strcmp("NextSpeedLimitBackType:", param))		data->nNextSpeedLimitBackType = value;
		else if (!strcmp("NextSpeedLimitBack:", param))			data->fNextSpeedLimitBack = value;
		else if (!strcmp("NextSpeedLimitBackDistance:", param))	data->fNextSpeedLimitBackDistance = value;
		else if (!strcmp("Acceleration:", param))				data->fAcceleration = value;
		else if (!strcmp("Gradient:", param))					data->fGradient = value;

		// Units
		else if (!strcmp("Units:", param))						data->sUnits = value;
		else if (!strcmp("VacuumBrakePipeUnits:", param))		data->sVacuumBrakePipeUnits = value;
		else if (!strcmp("VacuumBrakeChamberUnits:", param))	data->sVacuumBrakeChamberUnits = value;
		else if (!strcmp("TrainBrakeCylinderUnits:", param))	data->sTrainBrakeCylinderUnits = value;
		else if (!strcmp("LocoBrakeCylinderUnits:", param))		data->sLocoBrakeCylinderUnits = value;
		else if (!strcmp("AirBrakePipeUnits:", param))			data->sAirBrakePipeUnits = value;
		else if (!strcmp("MainReservoirUnits:", param))			data->sMainReservoirUnits = value;
		else if (!strcmp("EqReservoirUnits:", param))			data->sEqReservoirUnits = value;

		// Loco's controls
		else if (!strcmp("TargetSpeed:", param))				data->fTargetSpeed = value;
		else if (!strcmp("Reverser:", param))					data->fReverser = value;
		else if (!strcmp("GearLever:", param))					data->fGearLever = value;
		else if (!strcmp("Power:", param))						data->fPower = value;
		else if (!strcmp("CombinedThrottle:", param))			data->fCombinedThrottle = value;
		else if (!strcmp("Throttle:", param))					data->fThrottle = value;
		else if (!strcmp("TrainBrake:", param))					data->fTrainBrake = value;
		else if (!strcmp("LocoBrake:", param))					data->fLocoBrake = value;
		else if (!strcmp("DynamicBrake:", param))				data->fDynamicBrake = value;
		else if (!strcmp("HandBrake:", param))					data->fHandBrake = value;

		// Loco's indicators
		else if (!strcmp("BoilerPressure:", param))				data->fBoilerPressure = value;
		else if (!strcmp("BackPressure:", param))				data->fBackPressure = value;
		else if (!strcmp("SteamChestPressure:", param))			data->fSteamChestPressure = value;
		else if (!strcmp("SteamHeatingPressure:", param))		data->fSteamHeatingPressure = value;
		else if (!strcmp("Sandbox:", param))					data->fSandbox = value;
		else if (!strcmp("SandboxRear:", param))				data->fSandboxRear = value;
		else if (!strcmp("Voltage:", param))					data->fVoltage = value;
		else if (!strcmp("RPM:", param))						data->nRPM = value;
		else if (!strcmp("Ammeter:", param))					data->fAmmeter = value;

		// Brake's indicators
		else if (!strcmp("VacuumBrakePipePressure:", param))	data->fVacuumBrakePipePressure = value;
		else if (!strcmp("VacuumBrakeChamberPressure:", param))	data->fVacuumBrakeChamberPressure = value;
		else if (!strcmp("TrainBrakeCylinderPressure:", param))	data->fTrainBrakeCylinderPressure = value;
		else if (!strcmp("LocoBrakeCylinderPressure:", param))	data->fLocoBrakeCylinderPressure = value;
		else if (!strcmp("AirBrakePipePressure:", param))		data->fAirBrakePipePressure = value;
		else if (!strcmp("MainReservoirPressure:", param))		data->fMainReservoirPressure = value;
		else if (!strcmp("EqReservoirPressure:", param))		data->fEqReservoirPressure = value;

		// Steamers (driver, displayed with the above 3 groups)
		else if (!strcmp("BlowOffCockShutOffRight:", param))	data->fBlowOffCockShutOffRight = value;
		else if (!strcmp("Dynamo:", param))						data->fDynamo = value;
		else if (!strcmp("AirPump:", param))					data->fAirPump = value;
		else if (!strcmp("SteamHeatingShutOff:", param))		data->fSteamHeatingShutOff = value;
		else if (!strcmp("SteamHeating:", param))				data->fSteamHeating = value;
		else if (!strcmp("MasonsValve:", param))				data->fMasonsValve = value;
		else if (!strcmp("SteamManifold:", param))				data->fSteamManifold = value;
		else if (!strcmp("LubricatorSteam:", param))			data->fLubricatorSteam = value;
		else if (!strcmp("Lubricator:", param))					data->fLubricator = value;
		else if (!strcmp("LubricatorWarming:", param))			data->fLubricatorWarming = value;
		else if (!strcmp("SmallEjector:", param))				data->fSmallEjector = value;
		else if (!strcmp("LargeEjector:", param))				data->fLargeEjector = value;
		else if (!strcmp("BrakeHook:", param))					data->fBrakeHook = value;
		else if (!strcmp("SanderSteam:", param))				data->fSanderSteam = value;
		else if (!strcmp("Sander:", param))						data->fSander = value;
		else if (!strcmp("SanderRear:", param))					data->fSanderRear = value;
		else if (!strcmp("SanderCaps:", param))					data->fSanderCaps = value;
		else if (!strcmp("SanderFill:", param))					data->fSanderFill = value;
		else if (!strcmp("AshpanSprinkler:", param))			data->fAshpanSprinkler = value;
		else if (!strcmp("CylinderCock:", param))				data->fCylinderCock = value;
		else if (!strcmp("CylinderCockMaster:", param))			data->fCylinderCockMaster = value;
		else if (!strcmp("WaterScoop:", param))					data->fWaterScoop = value;

		// Steamers (fireman, displayed on the right side)
		else if (!strcmp("BlowOffCockShutOffLeft:", param))		data->fBlowOffCockShutOffLeft = value;
		else if (!strcmp("FeedWaterPumpShutOff:", param))		data->fFeedWaterPumpShutOff = value;
		else if (!strcmp("ControlValve:", param))				data->fControlValve = value;
		else if (!strcmp("ExhaustInjectorShutOff:", param))		data->fExhaustInjectorShutOff = value;
		else if (!strcmp("LiveInjectorShutOff:", param))		data->fLiveInjectorShutOff = value;
		else if (!strcmp("TenderWaterShutOff:", param))			data->fTenderWaterShutOff = value;

		else if (!strcmp("FireboxMass:", param))				data->fFireboxMass = value;
		else if (!strcmp("AtomizerPressure:", param))			data->fAtomizerPressure = value;
		else if (!strcmp("TankTemperature:", param))			data->fTankTemperature = value;
		else if (!strcmp("FireboxDoor:", param))				data->fFireboxDoor = value;
		else if (!strcmp("Stoking:", param))					data->fStoking = value;
		else if (!strcmp("OilRegulator:", param))				data->fOilRegulator = value;
		else if (!strcmp("Atomizer:", param))					data->fAtomizer = value;
		else if (!strcmp("TankHeater:", param))					data->fTankHeater = value;
		else if (!strcmp("Blower:", param))						data->fBlower = value;
		else if (!strcmp("Damper:", param))						data->fDamper = value;
		else if (!strcmp("DamperLeft:", param))					data->fDamperLeft = value;
		else if (!strcmp("DamperRight:", param))				data->fDamperRight = value;
		else if (!strcmp("DamperFront:", param))				data->fDamperFront = value;
		else if (!strcmp("DamperRear:", param))					data->fDamperRear = value;

		else if (!strcmp("WaterGauge:", param))					data->fWaterGauge = value;
		else if (!strcmp("FeedWaterPressure:", param))			data->fFeedWaterPressure = value;
		else if (!strcmp("FeedWaterPump:", param))				data->fFeedWaterPump = value;
		else if (!strcmp("ExhaustInjectorSteam:", param))		data->fExhaustInjectorSteam = value;
		else if (!strcmp("ExhaustInjectorWater:", param))		data->fExhaustInjectorWater = value;
		else if (!strcmp("LiveInjectorSteam:", param))			data->fLiveInjectorSteam = value;
		else if (!strcmp("LiveInjectorWater:", param))			data->fLiveInjectorWater = value;

		else if (!strcmp("SafetyValve1:", param))				data->fSafetyValve1 = value;
		else if (!strcmp("SafetyValve2:", param))				data->fSafetyValve2 = value;
		else if (!strcmp("SafetyValve3:", param))				data->fSafetyValve3 = value;

		// Warning values
		else if (!strcmp("Sunflower:", param))					data->nSunflower = value;
		else if (!strcmp("Alarm:", param))						data->nAlarm = value;
		else if (!strcmp("VigilAlarm:", param))					data->nVigilAlarm = value;
		else if (!strcmp("EmergencyBrake:", param))				data->nEmergencyBrake = value;
		else if (!strcmp("Startup:", param))					data->nStartup = value;
		else if (!strcmp("Doors:", param))						data->nDoors = value;

		// Config values
		else if (!strcmp("TextAlarm:", param))					data->sTextAlarm = value;
		else if (!strcmp("TextVigilAlarm:", param))				data->sTextVigilAlarm = value;
		else if (!strcmp("TextEmergency:", param))				data->sTextEmergency = value;
		else if (!strcmp("TextStartup:", param))				data->sTextStartup = value;
		else if (!strcmp("TextDoors:", param))					data->sTextDoors = value;
		else if (!strcmp("GradientUK:", param))					data->nGradientUK = value;

		// Misc
		else if (!strcmp("SimulationTime:", param))				data->fSimulationTime = value;
	}

	fclose(f);

	return 0;
}

inline float getAverage(float *table, int size, int *index, float value)
{
	float fAverage = 0;
	table[*index] = value;
	for (int i = 0; i < size; i++)
		fAverage += table[i];
	fAverage /= size;
	*index = (*index + 1) % size;
	return fAverage;
}

inline float normalizeSign(float f)
{
	if (f >= -0.03f && f <= 0.03f)
		return 0.00001f;
	return f;
}

void RenderOverlay()
{
	SimData data;
	int ret = FillData(&data);

	if (ret < 0)
	{
		d3ddev->Clear(0, NULL, D3DCLEAR_TARGET, D3DCOLOR_ARGB(0,0, 0, 0), 1.0f, 0);
		d3ddev->BeginScene();
		DrawString(eAlways, true, 10, g_nHeight-5, white, pSmallFont, "TrainSim Helper %s active", VERSION);
		d3ddev->EndScene();    // ends the 3D scene
		d3ddev->Present(NULL, NULL, NULL, NULL);
		return;
	}

	// Check whether all the values got filled properly
	if (!data.fSimulationTime)
		return;

	// Distance and Acceleration calculations, all in seconds, meters and meters per second
	if (g_fPrevSimulationTime == 0.0)
		g_fPrevSimulationTime = data.fSimulationTime();

	if (data.fSimulationTime() < g_fPrevSimulationTime)
	{
		// New loco loaded, reset everything
		g_fPrevSimulationTime = 0.0;
		g_fDistance = 0.0;
		g_bCountdown = false;
		g_fPrevSpeed = 0.0;
		g_fAcceleration = 0.0;
	}
	else
	{
		double fDeltaTime = data.fSimulationTime() - g_fPrevSimulationTime;
		g_fPrevSimulationTime = data.fSimulationTime();
		double fDeltaSpeed = data.fSpeed() - g_fPrevSpeed;
		g_fPrevSpeed = data.fSpeed();
		double fDeltaDistance = data.fSpeed() * fDeltaTime;

		if (g_bCountdown)
			fDeltaDistance *= -1.0;
		if (g_bInvert)
			fDeltaDistance *= -1.0;
		g_fDistance += fDeltaDistance;
		if (fDeltaTime != 0)
			g_fAcceleration = fDeltaSpeed / fDeltaTime;
	}

	// Units conversions
	char *sUnitsSpeed;
	char *sUnitsDistance;
	char *sUnitsAcceleration;
	float fModifierSpeed;
	float fModifierDistance;
	float fModifierAcceleration;
	if (data.sUnits()[0] == 'K')
	{
		sUnitsSpeed = "Kph";
		sUnitsDistance = "Km";
		sUnitsAcceleration = "Kph/m";
		fModifierSpeed = MPS_TO_KPH;
		fModifierDistance = METRES_TO_KILOMETRES;
		fModifierAcceleration = MPS_TO_KPH * 60;
	}
	else /*if (data.sUnits()[0] == 'M')*/ /* also handle no speedometer case like 7F steamer */
	{
		sUnitsSpeed = "Mph";
		sUnitsDistance = "Mi";
		sUnitsAcceleration = "Mph/m";
		fModifierSpeed = MPS_TO_MPH;
		fModifierDistance = METRES_TO_MILES;
		fModifierAcceleration = MPS_TO_MPH * 60;
	}

	// If all the digits has been entered set countdown
	if (g_nSetCountdownProgress == 4)
	{
		double fDistance = g_nCountdownDigits[0] * 10.0 + g_nCountdownDigits[1] * 1.0 + g_nCountdownDigits[2] * 0.1 + g_nCountdownDigits[3] * 0.01;
		g_fDistance = fDistance / fModifierDistance;
		g_bCountdown = true;
	}
	// Block the setting and display the text for one more second
	if (g_nSetCountdownProgress == 4 && data.fSimulationTime() - g_fPrevSimulationTime2 > 1.0)
	{
		g_nSetCountdownProgress = 0;
	}
	// If we did not put anything for 5 seconds since last digit, cancel
	if (g_nSetCountdownProgress && data.fSimulationTime() - g_fPrevSimulationTime2 > 5.0)
	{
		g_nSetCountdownProgress = 0;
	}

	if (g_bHideSection[0]) // -v, CTRL+SHIFT+v
	{
		d3ddev->Clear(0, NULL, D3DCLEAR_TARGET, D3DCOLOR_ARGB(0,0, 0, 0), 1.0f, 0);
		d3ddev->Present(NULL, NULL, NULL, NULL);
		return;
	}

	float fSpeed = (float)data.fSpeed() * fModifierSpeed;
	float fAcceleration = (float)g_fAcceleration * fModifierAcceleration;
	float fDistance = (float)g_fDistance * fModifierDistance;
	int nSpeedLimit = (int)(data.fSpeedLimit() * fModifierSpeed);
	int nNextSpeedLimit;
	int nNextSpeedLimitType;
	float fNextSpeedLimitDistance;

	if (g_bInvert)
	{
		fSpeed *= -1.0;
		fAcceleration *= -1.0;
		nNextSpeedLimit = (int)(data.fNextSpeedLimitBack() * fModifierSpeed);
		nNextSpeedLimitType = (int)(data.nNextSpeedLimitBackType);
		fNextSpeedLimitDistance = data.fNextSpeedLimitBackDistance() * fModifierDistance;
	}
	else
	{
		nNextSpeedLimit = (int)(data.fNextSpeedLimit() * fModifierSpeed);
		nNextSpeedLimitType = (int)(data.nNextSpeedLimitType);
		fNextSpeedLimitDistance = data.fNextSpeedLimitDistance() * fModifierDistance;
	}

	// Alarm color
	DWORD alarmcolor = transparent;
	if (data.nAlarm() > 0)
		alarmcolor = red;

	// VigilAlarm color
	DWORD vigilalarmcolor = transparent;
	if (data.nVigilAlarm() > 0)
		vigilalarmcolor = red;

	// Emergency color
	DWORD emergencycolor = transparent;
	if (data.nEmergencyBrake() > 0)
		emergencycolor = red;

	// Startup color
	DWORD startupcolor = transparent;
	if (data.nStartup() == -1)
		startupcolor = red;

	// Doors color
	DWORD doorscolor = transparent;
	if (data.nDoors() > 0)
		doorscolor = green;

	// speed color (white - OK, yellow - back, red - overspeed)
	DWORD speedcolor = white;
	if (fSpeed < -0.1f)
		speedcolor = yellow;
	if (nSpeedLimit - abs(fSpeed) < -0.9f)
		speedcolor = red;
	else if (nSpeedLimit - fSpeed >= -0.9f && nSpeedLimit - fSpeed <= 5.f)
		speedcolor = whitegreen;

	// countdown color
	DWORD countdowncolor = white;
	if (g_fDistance * fModifierDistance < 0.0)
		countdowncolor = red;
	else if (g_fDistance * fModifierDistance <= 1.0)
		countdowncolor = yellow;

	// boiler color
	DWORD boilercolor = grey;
	float fBoilerAverage = getAverage(g_fBoilerTable, BOILER_TABLE_SIZE, &g_nBoilerIndex, data.fBoilerPressure());
	if (data.fBoilerPressure() > fBoilerAverage)
		boilercolor = whitegreen;
	else if (data.fBoilerPressure() < fBoilerAverage)
		boilercolor = whitered;

	// next limit string
	char nextlimit[STRING_SIZE] = {'\0'};
	if (data.nNextSpeedLimitType() < 0)
		_snprintf(nextlimit, STRING_SIZE, "---");
	else if (nNextSpeedLimit < 0 || nNextSpeedLimit > 1000)
		_snprintf(nextlimit, STRING_SIZE, "?? @ %.2f %s", fNextSpeedLimitDistance, sUnitsDistance);
	else if (data.nNextSpeedLimitType() == 0)
		_snprintf(nextlimit, STRING_SIZE, "End @ %.2f %s", fNextSpeedLimitDistance, sUnitsDistance);
	else if (data.nNextSpeedLimitType() > 0)
		_snprintf(nextlimit, STRING_SIZE, "%d %s @ %.2f %s", nNextSpeedLimit, sUnitsSpeed, fNextSpeedLimitDistance, sUnitsDistance);

	// gradient
	char gradient[STRING_SIZE] = {'\0'};
	if (data.nGradientUK() > 0)
	{
		if (data.fGradient() == 0.0f)
			_snprintf(gradient, STRING_SIZE, "0:0");
		else
			_snprintf(gradient, STRING_SIZE, "%s1:%d", data.fGradient() > 0 ? "": "-", (int)(100.f / fabs(data.fGradient())));
	}
	else
		_snprintf(gradient, STRING_SIZE, "%.2f %%", data.fGradient());

	// clear the window alpha
	d3ddev->Clear(0, NULL, D3DCLEAR_TARGET, D3DCOLOR_ARGB(0,0, 0, 0), 1.0f, 0);
	d3ddev->BeginScene();	// begins the 3D scene

	// Display the Countdown setting if in progress
	if (g_nSetCountdownProgress)
	{
		char cDigits[4] = { '_', '_', '_', '_' };
		for (int i = 0; i < g_nSetCountdownProgress; ++i)
			cDigits[i] = g_nCountdownDigits[i] + 0x30;
		char sCountdown[STRING_SIZE];
		_snprintf(sCountdown, STRING_SIZE, "%c%c.%c%c", cDigits[0], cDigits[1], cDigits[2], cDigits[3]);
		DrawString(eOverlay, true, g_nWidth / 2 - 100, g_nHeight / 2, whitegreen, pBigFixedFont, sCountdown);
	}

	DrawString(eMainClock, data.nClock, 350, 57, white, pBigFont, "%d:%02d:%02d",
				GETHOURS(data.nClock()), GETMINUTES(data.nClock()), GETSECONDS(data.nClock()));

	int yD = 5;

	// Main
	int x = 15;
	int y = g_nHeight - yD;
	int yP = y;

	y = DrawString(eMainGradient, data.fGradient,								x+60,	y, grey, pSmallFont, "Gradient: %s", gradient);

	y = NextSection(y, &yP, yD);

	y = DrawString(eMainBrakes,				data.fEqReservoirPressure,			x+36,	y, whitered, pSmallFont, "Eq Reservoir: %.1f %s", data.fEqReservoirPressure(), data.sEqReservoirUnits());
	y = DrawString(eMainBrakes,				data.fMainReservoirPressure,		x+24,	y, whitered, pSmallFont, "Main Reservoir: %.1f %s", data.fMainReservoirPressure(), data.sMainReservoirUnits());
	y = DrawString(eMainBrakes,				data.fAirBrakePipePressure,			x+45,	y, whitered, pSmallFont, "Brake Pipe: %.1f %s", data.fAirBrakePipePressure(), data.sAirBrakePipeUnits());
	y = DrawString(eMainBrakes,				data.fLocoBrakeCylinderPressure,	x+43,	y, whitered, pSmallFont, "Loco Brake: %.1f %s", data.fLocoBrakeCylinderPressure(), data.sLocoBrakeCylinderUnits());
	y = DrawString(eMainBrakes,				data.fTrainBrakeCylinderPressure,	x+43,	y, whitered, pSmallFont, "Train Brake: %.1f %s", data.fTrainBrakeCylinderPressure(), data.sTrainBrakeCylinderUnits());
	y = DrawString(eMainBrakes,				data.fVacuumBrakeChamberPressure,	x+6,	y, whitered, pSmallFont, "Vacuum Chamber: %.1f %s", data.fVacuumBrakeChamberPressure(), data.sVacuumBrakeChamberUnits());
	y = DrawString(eMainBrakes,				data.fVacuumBrakePipePressure,		x+32,	y, whitered, pSmallFont, "Vacuum Pipe: %.1f %s", data.fVacuumBrakePipePressure(), data.sVacuumBrakePipeUnits());

	y = NextSection(y, &yP, yD);

	y = DrawString(eMainIndicators,			data.fAmmeter,						x+56,	y, whitegreen, pSmallFont, "Ammeter: %.1f Amps", normalizeSign(data.fAmmeter()));
	y = DrawString(eMainIndicators,			data.nRPM,							x+80,	y, whitegreen, pSmallFont, "RPM: %d RPM", data.nRPM());
	y = DrawString(eMainIndicators,			data.fVoltage,						x+66,	y, whitegreen, pSmallFont, "Voltage: %.1f V", data.fVoltage());
	y = DrawString(eMainIndicators,			data.fSandboxRear,					x+27,	y, whitegreen, pSmallFont, "Rear Sandbox: %d %%", (int)(data.fSandboxRear()*100));
	y = DrawString(eMainIndicators,			data.fSandbox,						x+58,	y, whitegreen, pSmallFont, "Sandbox: %d %%", (int)(data.fSandbox()*100));
	y = DrawString(eMainIndicators,			data.fSteamHeatingPressure,			x+23,	y, whitegreen, pSmallFont, "Steam Heating: %.1f PSI", data.fSteamHeatingPressure());
	y = DrawString(eMainIndicators,			data.fSteamChestPressure,			x+33,	y, whitegreen, pSmallFont, "Steam Chest: %.1f PSI", data.fSteamChestPressure());
	y = DrawString(eMainIndicators,			data.fBackPressure,					x+23,	y, whitegreen, pSmallFont, "Back Pressure: %.1f PSI", data.fBackPressure());

	y = NextSection(y, &yP, yD);

	y = DrawString(eMainControls,			data.fHandBrake,					x+41,	y, whiteblue, pSmallFont, "Hand Brake: %d %%", (int)(data.fHandBrake()*100));
	y = DrawString(eMainControls,			data.fDynamicBrake,					x+20,	y, whiteblue, pSmallFont, "Dynamic Brake: %d %%", (int)(data.fDynamicBrake()*100));
	y = DrawString(eMainControls,			data.fLocoBrake,					x+43,	y, whiteblue, pSmallFont, "Loco Brake: %d %%", (int)(data.fLocoBrake()*100));
	y = DrawString(eMainControls,			data.fTrainBrake,					x+43,	y, whiteblue, pSmallFont, "Train Brake: %d %%", (int)(data.fTrainBrake()*100));
	y = DrawString(eMainControls,			data.fThrottle,						x+66,	y, whiteblue, pSmallFont, "Throttle: %d %%", (int)(data.fThrottle()*100));
	y = DrawString(eMainControls,			data.fCombinedThrottle,				x+51,	y, whiteblue, pSmallFont, "Combined: %d %%", (int)(data.fCombinedThrottle()*100));
	y = DrawString(eMainControls,			data.fPower,						x+73,	y, whiteblue, pSmallFont, "Power: %d %%", (int)(data.fPower()*100));
	y = DrawString(eMainControls,			data.fGearLever,					x+81,	y, whiteblue, pSmallFont, "Gear: %d", (int)data.fGearLever());
	y = DrawString(eMainControls,			data.fReverser,						x+59,	y, whiteblue, pSmallFont, "Reverser: %d %%", (int)(data.fReverser()*100));
	y = DrawString(eMainControls,			data.fTargetSpeed,					x+34,	y, whiteblue, pSmallFont, "Target Speed: %.1f %s", data.fTargetSpeed(), sUnitsSpeed);

	y = NextSection(y, &yP, yD);

	y = DrawString(eMainAcceleration,		data.fAcceleration,					x+37,	y, white, pSmallFont, "Acceleration: %d %s", (int)getAverage(g_fAccelTable, ACCEL_TABLE_SIZE, &g_nAccelIndex, fAcceleration), sUnitsAcceleration);
	y = DrawString(eMainNextSpeed,			data.nNextSpeedLimitType,			x+50,	y, white, pSmallFont, "Next Limit: %s", nextlimit);

	y = NextSection(y, &yP, yD);

	if (g_bCountdown)
		y = DrawString(eMainDistance,		ISVALID(fDistance),					x+28,	y, countdowncolor, pMediumFont, "Countdown: %.2f %s", fDistance, sUnitsDistance);
	else
		y = DrawString(eMainDistance,		ISVALID(fDistance),					x+45,	y, white, pMediumFont, "Distance: %.2f %s", fDistance, sUnitsDistance);

	y = DrawString(eMainBoiler,				data.fBoilerPressure,				x+67,	y, boilercolor, pMediumFont, "Boiler: %.1f PSI", data.fBoilerPressure());
	if (g_bSpeedLimitOnly)
		y = DrawString(eMainSpeed,			data.fSpeed,						x+75,	y, white, pMediumFont, "Limit: %d %s", nSpeedLimit, sUnitsSpeed);
	else
		y = DrawString(eMainSpeed,			data.fSpeed,						x+62,	y, speedcolor, pMediumFont, "Speed: %.1f / %d %s", normalizeSign(fSpeed), nSpeedLimit, sUnitsSpeed);

	y = NextSection(y, &yP, yD);

	y = DrawString(eMainWarnings,			data.sTextDoors,					x,		y, doorscolor, pBigFont, data.sTextDoors());
	y = DrawString(eMainWarnings,			data.sTextStartup,					x,		y, startupcolor, pBigFont, data.sTextStartup());
	y = DrawString(eMainWarnings,			data.sTextEmergency,				x,		y, emergencycolor, pBigFont, data.sTextEmergency());
	y = DrawString(eMainWarnings,			data.sTextVigilAlarm,				x,		y, vigilalarmcolor, pBigFont, data.sTextVigilAlarm());
	y = DrawString(eMainWarnings,			data.sTextAlarm,					x,		y, alarmcolor, pBigFont, data.sTextAlarm());

	if (data.fFireboxMass)
	{

	// Steamer driver
	x = 250;
	y = g_nHeight - yD;
	yP = y;

	y = DrawString(eSteamDriverPrimary,		data.fWaterScoop,					x+61,	y, white, pSmallFont, "Water Scoop: %d %%", (int)(data.fWaterScoop()*100));
	y = DrawString(eSteamDriverPrimary,		data.fCylinderCockMaster,			x+5,	y, white, pSmallFont, "Master Cylinder Cocks: %d %%", (int)(data.fCylinderCockMaster()*100));
	y = DrawString(eSteamDriverPrimary,		data.fCylinderCock,					x+49,	y, white, pSmallFont, "Cylinder Cocks: %d %%", (int)(data.fCylinderCock()*100));
	y = DrawString(eSteamDriverSecondary,	data.fAshpanSprinkler,				x+38,	y, white, pSmallFont, "Ashpan Sprinkler: %d %%", (int)(data.fAshpanSprinkler()*100));
	y = DrawString(eSteamDriverSecondary,	data.fSanderFill,					x+75,	y, white, pSmallFont, "Fill Sander: %d %%", (int)(data.fSanderFill()*100));
	y = DrawString(eSteamDriverSecondary,	data.fSanderCaps,					x+62,	y, white, pSmallFont, "Caps Sander: %d %%", (int)(data.fSanderCaps()*100));
	y = DrawString(eSteamDriverPrimary,		data.fSanderRear,					x+65,	y, white, pSmallFont, "Rear Sander: %d %%", (int)(data.fSanderRear()*100));
	y = DrawString(eSteamDriverPrimary,		data.fSander,						x+96,	y, white, pSmallFont, "Sander: %d %%", (int)(data.fSander()*100));
	y = DrawString(eSteamDriverSecondary,	data.fSanderSteam,					x+54,	y, white, pSmallFont, "Steam Sander: %d %%", (int)(data.fSanderSteam()*100));
	y = DrawString(eSteamDriverPrimary,		data.fBrakeHook,					x+69,	y, white, pSmallFont, "Brake Hook: %d %%", (int)(data.fBrakeHook()*100));
	y = DrawString(eSteamDriverPrimary,		data.fLargeEjector,					x+60,	y, white, pSmallFont, "Large Ejector: %d %%", (int)(data.fLargeEjector()*100));
	y = DrawString(eSteamDriverPrimary,		data.fSmallEjector,					x+59,	y, white, pSmallFont, "Small Ejector: %d %%", (int)(data.fSmallEjector()*100));
	y = DrawString(eSteamDriverSecondary,	data.fLubricatorWarming,			x+24,	y, white, pSmallFont, "Warming Lubricator: %d %%", (int)(data.fLubricatorWarming()*100));
	y = DrawString(eSteamDriverSecondary,	data.fLubricator,					x+80,	y, white, pSmallFont, "Lubricator: %d %%", (int)(data.fLubricator()*100));
	y = DrawString(eSteamDriverSecondary,	data.fLubricatorSteam,				x+38,	y, white, pSmallFont, "Steam Lubricator: %d %%", (int)(data.fLubricatorSteam()*100));
	y = DrawString(eSteamDriverSecondary,	data.fSteamManifold,				x+47,	y, white, pSmallFont, "Steam Manifold: %d %%", (int)(data.fSteamManifold()*100));
	y = DrawString(eSteamDriverSecondary,	data.fMasonsValve,					x+57,	y, white, pSmallFont, "Masons Valve: %d %%", (int)(data.fMasonsValve()*100));
	y = DrawString(eSteamDriverSecondary,	data.fSteamHeating,					x+51,	y, white, pSmallFont, "Steam Heating: %d %%", (int)(data.fSteamHeating()*100));
	y = DrawString(eSteamDriverSecondary,	data.fSteamHeatingShutOff,			x+0,	y, white, pSmallFont, "Shut Off Steam Heating: %d %%", (int)(data.fSteamHeatingShutOff()*100));
	y = DrawString(eSteamDriverSecondary,	data.fAirPump,						x+83,	y, white, pSmallFont, "Air Pump: %d %%", (int)(data.fAirPump()*100));
	y = DrawString(eSteamDriverSecondary,	data.fDynamo,						x+89,	y, white, pSmallFont, "Dynamo: %d %%", (int)(data.fDynamo()*100));
	y = DrawString(eSteamDriverSecondary,	data.fBlowOffCockShutOffRight,		x+4,	y, white, pSmallFont, "Blow Off Cock Shut Off: %d %%", (int)(data.fBlowOffCockShutOffRight()*100));

	// Steamer fireman
	x = g_nWidth - 460;
	y = g_nHeight - yD;
	yP = y;

	y = DrawString(eSteamFiremanSecondary,	data.fTenderWaterShutOff,			x+21,	y, white, pSmallFont, "Tender Water Shut Off: %d %%", (int)(data.fTenderWaterShutOff()*100));
	y = DrawString(eSteamFiremanSecondary,	data.fLiveInjectorShutOff,			x+30,	y, white, pSmallFont, "Live Injector Shut Off: %d %%", (int)(data.fLiveInjectorShutOff()*100));
	y = DrawString(eSteamFiremanSecondary,	data.fExhaustInjectorShutOff,		x+4,	y, white, pSmallFont, "Exhaust Injector Shut Off: %d %%", (int)(data.fExhaustInjectorShutOff()*100));
	y = DrawString(eSteamFiremanSecondary,	data.fControlValve,					x+74,	y, white, pSmallFont, "Control Valve: %d %%", (int)(data.fControlValve()*100));
	y = DrawString(eSteamFiremanSecondary,	data.fFeedWaterPumpShutOff,			x+0,	y, white, pSmallFont, "Feedwater Pump Shut Off: %d %%", (int)(data.fFeedWaterPumpShutOff()*100));
	y = DrawString(eSteamFiremanSecondary,	data.fBlowOffCockShutOffLeft,		x+16,	y, white, pSmallFont, "Blow Off Cock Shut Off: %d %%", (int)(data.fBlowOffCockShutOffLeft()*100));

	x = g_nWidth - 260;
	y = g_nHeight - yD;
	yP = y;

	y = DrawString(eSteamSafety,			data.fSafetyValve3,					x+76,	y, white, pSmallFont, "Safety Valve 3: %d %%", (int)(data.fSafetyValve3()*100));
	y = DrawString(eSteamSafety,			data.fSafetyValve2,					x+76,	y, white, pSmallFont, "Safety Valve 2: %d %%", (int)(data.fSafetyValve2()*100));
	y = DrawString(eSteamSafety,			data.fSafetyValve1,					x+76,	y, white, pSmallFont, "Safety Valve 1: %d %%", (int)(data.fSafetyValve1()*100));
	y = NextSection(y, &yP, yD);
	y = DrawString(eSteamWaterControls,		data.fLiveInjectorWater,			x+51,	y, whiteblue, pSmallFont, "Water Live Injector: %d %%", (int)(data.fLiveInjectorWater()*100));
	y = DrawString(eSteamWaterControls,		data.fLiveInjectorSteam,			x+48,	y, whiteblue, pSmallFont, "Steam Live Injector: %d %%", (int)(data.fLiveInjectorSteam()*100));
	y = DrawString(eSteamWaterControls,		data.fExhaustInjectorWater,			x+25,	y, whiteblue, pSmallFont, "Water Exhaust Injector: %d %%", (int)(data.fExhaustInjectorWater()*100));
	y = DrawString(eSteamWaterControls,		data.fExhaustInjectorSteam,			x+22,	y, whiteblue, pSmallFont, "Steam Exhaust Injector: %d %%", (int)(data.fExhaustInjectorSteam()*100));
	y = DrawString(eSteamWaterControls,		data.fFeedWaterPump,				x+60,	y, whiteblue, pSmallFont, "Feedwater Pump: %d %%", (int)(data.fFeedWaterPump()*100));
	y = DrawString(eSteamWaterIndicators,	data.fFeedWaterPressure,			x+81,	y, whiteblue, pMediumFont, "Feedwater: %.1f PSI", data.fFeedWaterPressure());
	y = DrawString(eSteamWater,				data.fWaterGauge,					x+113,	y, whiteblue, pMediumFont, "Water: %.1f %%", data.fWaterGauge()*100);
	y = NextSection(y, &yP, yD);
	y = DrawString(eSteamFireControls,		data.fDamperRear,					x+82,	y, whitered, pSmallFont, "Rear Damper: %d %%", (int)(data.fDamperRear()*100));
	y = DrawString(eSteamFireControls,		data.fDamperFront,					x+79,	y, whitered, pSmallFont, "Front Damper: %d %%", (int)(data.fDamperFront()*100));
	y = DrawString(eSteamFireControls,		data.fDamperRight,					x+79,	y, whitered, pSmallFont, "Right Damper: %d %%", (int)(data.fDamperRight()*100));
	y = DrawString(eSteamFireControls,		data.fDamperLeft,					x+88,	y, whitered, pSmallFont, "Left Damper: %d %%", (int)(data.fDamperLeft()*100));
	y = DrawString(eSteamFireControls,		data.fDamper,						x+113,	y, whitered, pSmallFont, "Damper: %d %%", (int)(data.fDamper()*100));
	y = DrawString(eSteamFireControls,		data.fBlower,						x+119,	y, whitered, pSmallFont, "Blower: %d %%", (int)(data.fBlower()*100));
	y = DrawString(eSteamFireControls,		data.fTankHeater,					x+89,	y, whitered, pSmallFont, "Tank Heater: %d %%", (int)(data.fTankHeater()*100));
	y = DrawString(eSteamFireControls,		data.fAtomizer,						x+106,	y, whitered, pSmallFont, "Atomizer: %d %%", (int)(data.fAtomizer()*100));
	y = DrawString(eSteamFireControls,		data.fOilRegulator,					x+83,	y, whitered, pSmallFont, "Oil Regulator: %d %%", (int)(data.fOilRegulator()*100));
	y = DrawString(eSteamFireControls,		data.fStoking,						x+114,	y, whitered, pSmallFont, "Stoking: %d %%", (int)(data.fStoking()*100));
	y = DrawString(eSteamFireControls,		data.fFireboxDoor,					x+84,	y, whitered, pSmallFont, "Firebox Door: %d %%", (int)(data.fFireboxDoor()*100));
	y = DrawString(eSteamFireIndicators,	data.fTankTemperature,				x+124,	y, whitered, pMediumFont, "Tank: %.1f °F",data.fTankTemperature());
	y = DrawString(eSteamFireIndicators,	data.fAtomizerPressure,				x+93,	y, whitered, pMediumFont, "Atomizer: %.1f PSI", data.fAtomizerPressure());
	y = DrawString(eSteamFire,				data.fFireboxMass,					x+103,	y, whitered, pMediumFont, "Firebox: %.1f %%", data.fFireboxMass()*100);

	} // Steamers

	d3ddev->EndScene();    // ends the 3D scene
	d3ddev->Present(NULL, NULL, NULL, NULL);   // displays the created frame on the screen
}
