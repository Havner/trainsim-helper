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
#define SECTIONS_TABLE_SIZE		13
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
bool g_bCountdown;
char g_nCountdownDigits[4];
int g_nSetCountdownProgress;

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
DWORD yellow = D3DCOLOR_ARGB(255,200,200,0);
DWORD grey = D3DCOLOR_ARGB(255,200,200,200);


struct SimData {
	// SIM values
	Value<int>			nClock;
	Value<std::string>	sUnits;
	Value<double>		fSpeed;
	Value<float>		fSpeedLimit;
	Value<int>			nNextSpeedLimitType;
	Value<float>		fNextSpeedLimit;
	Value<float>		fNextSpeedLimitDistance;
	Value<float>		fAcceleration;
	Value<float>		fGradient;

	// Loco's controls
	Value<float>		fTargetSpeed;
	Value<float>		fReverser;
	Value<float>		fGearLever;
	Value<float>		fThrottle;
	Value<float>		fTrainBrake;
	Value<float>		fLocoBrake;
	Value<float>		fDynamicBrake;
	Value<float>		fHandBrake;

	// Loco's indicators
	Value<float>		fBoilerPressure;
	Value<float>		fSteamChestPressure;
	Value<float>		fAmmeter;
	Value<int>			nRPM;
	Value<float>		fVacuumBrakePipePressure;
	Value<float>		fVacuumBrakeChamberPressure;
	Value<std::string>	sBrakeUnits;
	Value<float>		fTrainBrakeCylinderPressure;
	Value<float>		fLocoBrakeCylinderPressure;
	Value<float>		fAirBrakePipePressure;
	Value<float>		fMainReservoirPressure;
	Value<float>		fEqReservoirPressure;

	// Steamers (driver, displayed in separate section)
	Value<float>		fAirPump;
	Value<float>		fSmallEjector;
	Value<float>		fLargeEjector;
	Value<float>		fSteamHeating;
	Value<float>		fMasonsValve;
	Value<float>		fGenerator;
	Value<float>		fLubricator;
	Value<float>		fLubricatorWarming;
	Value<float>		fWaterGaugeTest1;
	Value<float>		fWaterGaugeTest2;
	Value<float>		fAshpanSprinkler;
	Value<float>		fFireholeFlap;
	Value<float>		fCylinderCock;
	Value<float>		fDamper;
	Value<float>		fWaterScoopRaiseLower;

	// Steamers (fireman, displayed on the right side)
	Value<float>		fWaterGauge;
	Value<float>		fExhaustInjectorSteam;
	Value<float>		fExhaustInjectorWater;
	Value<float>		fLiveInjectorSteam;
	Value<float>		fLiveInjectorWater;
	Value<float>		fFireboxMass;
	Value<float>		fFireboxDoor;
	Value<float>		fStoking;
	Value<float>		fBlower;
	Value<float>		fSafetyValve1;
	Value<float>		fSafetyValve2;

	// Warning values
	Value<int>			nSunflower;
	Value<int>			nAWS;
	Value<int>			nVigilAlarm;
	Value<int>			nEmergencyBrake;
	Value<int>			nStartup;

	// Config values
	Value<std::string>  sTextAWS;
	Value<std::string>  sTextVigilAlarm;
	Value<std::string>  sTextEmergency;
	Value<std::string>  sTextStartup;
	Value<int>			nGradientUK;

	// Misc
	Value<double>		fSimulationTime;
};

void ToggleDisplaySection(int s)
{
	if (s >= 0 && s < SECTIONS_TABLE_SIZE)
		g_bHideSection[s] = !g_bHideSection[s];
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

int DrawString(bool valid, int x, int y, DWORD color, LPD3DXFONT pFont, const char *fmt, ...)
{
	if (!valid)
		return y;

	if (pFont == pSmallFont)
		y -= 17;
	else if (pFont == pMediumFont)
		y -= 21;
	else if (pFont == pBigFont)
		y -= 50;

	RECT FontPos = { x, y, x + 1, y + 1 };
	char buf[STRING_SIZE] = {'\0'};
	va_list va_alist;

	va_start(va_alist, fmt);
	vsprintf_s(buf, fmt, va_alist);
	va_end(va_alist);
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
		else if (!strcmp("Units:", param))						data->sUnits = value;
		else if (!strcmp("Speed:", param))						data->fSpeed = value;
		else if (!strcmp("SpeedLimit:", param))					data->fSpeedLimit = value;
		else if (!strcmp("NextSpeedLimitType:", param))			data->nNextSpeedLimitType = value;
		else if (!strcmp("NextSpeedLimit:", param))				data->fNextSpeedLimit = value;
		else if (!strcmp("NextSpeedLimitDistance:", param))		data->fNextSpeedLimitDistance = value;
		else if (!strcmp("Acceleration:", param))				data->fAcceleration = value;
		else if (!strcmp("Gradient:", param))					data->fGradient = value;

		// Loco's controls
		else if (!strcmp("TargetSpeed:", param))				data->fTargetSpeed = value;
		else if (!strcmp("Reverser:", param))					data->fReverser = value;
		else if (!strcmp("GearLever:", param))					data->fGearLever = value;
		else if (!strcmp("Throttle:", param))					data->fThrottle = value;
		else if (!strcmp("TrainBrake:", param))					data->fTrainBrake = value;
		else if (!strcmp("LocoBrake:", param))					data->fLocoBrake = value;
		else if (!strcmp("DynamicBrake:", param))				data->fDynamicBrake = value;
		else if (!strcmp("HandBrake:", param))					data->fHandBrake = value;

		// Loco's indicators
		else if (!strcmp("BoilerPressure:", param))				data->fBoilerPressure = value;
		else if (!strcmp("SteamChestPressure:", param))			data->fSteamChestPressure = value;
		else if (!strcmp("Ammeter:", param))					data->fAmmeter = value;
		else if (!strcmp("RPM:", param))						data->nRPM = value;
		else if (!strcmp("VacuumBrakePipePressure:", param))	data->fVacuumBrakePipePressure = value;
		else if (!strcmp("VacuumBrakeChamberPressure:", param))	data->fVacuumBrakeChamberPressure = value;
		else if (!strcmp("BrakeUnits:", param))					data->sBrakeUnits = value;
		else if (!strcmp("TrainBrakeCylinderPressure:", param))	data->fTrainBrakeCylinderPressure = value;
		else if (!strcmp("LocoBrakeCylinderPressure:", param))	data->fLocoBrakeCylinderPressure = value;
		else if (!strcmp("AirBrakePipePressure:", param))		data->fAirBrakePipePressure = value;
		else if (!strcmp("MainReservoirPressure:", param))		data->fMainReservoirPressure = value;
		else if (!strcmp("EqReservoirPressure:", param))		data->fEqReservoirPressure = value;

		// Steamers (driver, displayed with the above 3 groups)
		else if (!strcmp("AirPump:", param))					data->fAirPump = value;
		else if (!strcmp("SmallEjector:", param))				data->fSmallEjector = value;
		else if (!strcmp("LargeEjector:", param))				data->fLargeEjector = value;
		else if (!strcmp("SteamHeating:", param))				data->fSteamHeating = value;
		else if (!strcmp("MasonsValve:", param))				data->fMasonsValve = value;
		else if (!strcmp("Generator:", param))					data->fGenerator = value;
		else if (!strcmp("Lubricator:", param))					data->fLubricator = value;
		else if (!strcmp("LubricatorWarming:", param))			data->fLubricatorWarming = value;
		else if (!strcmp("WaterGaugeTest1:", param))			data->fWaterGaugeTest1 = value;
		else if (!strcmp("WaterGaugeTest2:", param))			data->fWaterGaugeTest2 = value;
		else if (!strcmp("AshpanSprinkler:", param))			data->fAshpanSprinkler = value;
		else if (!strcmp("FireholeFlap:", param))				data->fFireholeFlap = value;
		else if (!strcmp("CylinderCock:", param))				data->fCylinderCock = value;
		else if (!strcmp("Damper:", param))						data->fDamper = value;
		else if (!strcmp("WaterScoopRaiseLower:", param))		data->fWaterScoopRaiseLower = value;

		// Steamers (fireman, displayed on the right side)
		else if (!strcmp("WaterGauge:", param))					data->fWaterGauge = value;
		else if (!strcmp("ExhaustInjectorSteam:", param))		data->fExhaustInjectorSteam = value;
		else if (!strcmp("ExhaustInjectorWater:", param))		data->fExhaustInjectorWater = value;
		else if (!strcmp("LiveInjectorSteam:", param))			data->fLiveInjectorSteam = value;
		else if (!strcmp("LiveInjectorWater:", param))			data->fLiveInjectorWater = value;
		else if (!strcmp("FireboxMass:", param))				data->fFireboxMass = value;
		else if (!strcmp("FireboxDoor:", param))				data->fFireboxDoor = value;
		else if (!strcmp("Stoking:", param))					data->fStoking = value;
		else if (!strcmp("Blower:", param))						data->fBlower = value;
		else if (!strcmp("SafetyValve1:", param))				data->fSafetyValve1 = value;
		else if (!strcmp("SafetyValve2:", param))				data->fSafetyValve2 = value;

		// Warning values
		else if (!strcmp("Sunflower:", param))					data->nSunflower = value;
		else if (!strcmp("AWS:", param))						data->nAWS = value;
		else if (!strcmp("VigilAlarm:", param))					data->nVigilAlarm = value;
		else if (!strcmp("EmergencyBrake:", param))				data->nEmergencyBrake = value;
		else if (!strcmp("Startup:", param))					data->nStartup = value;

		// Config values
		else if (!strcmp("TextAWS:", param))					data->sTextAWS = value;
		else if (!strcmp("TextVigilAlarm:", param))				data->sTextVigilAlarm = value;
		else if (!strcmp("TextEmergency:", param))				data->sTextEmergency = value;
		else if (!strcmp("TextStartup:", param))				data->sTextStartup = value;
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
		DrawString(true, 10, g_nHeight-5, white, pSmallFont, "TrainSim Helper %s active", VERSION);
		d3ddev->EndScene();    // ends the 3D scene
		d3ddev->Present(NULL, NULL, NULL, NULL);
		return;
	}

	// Check whether all the values got filled properly
	if (!data.fSimulationTime)
		return;

	// Distance calculations, all in seconds, meters and meters per second
	if (g_fPrevSimulationTime == 0.0)
		g_fPrevSimulationTime = data.fSimulationTime();

	if (data.fSimulationTime() < g_fPrevSimulationTime)
	{
		g_fPrevSimulationTime = 0.0;
		g_fDistance = 0.0;
		g_bCountdown = false;
	}
	else
	{
		double fDeltaTime = data.fSimulationTime() - g_fPrevSimulationTime;
		g_fPrevSimulationTime = data.fSimulationTime();
		double fDeltaDistance = data.fSpeed() * fDeltaTime;
		if (g_bCountdown)
			fDeltaDistance *= -1.0;
		g_fDistance += fDeltaDistance;
	}

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

	if (g_bHideSection[0]) // -0, -12, CTRL+SHIFT+F12
	{
		d3ddev->Clear(0, NULL, D3DCLEAR_TARGET, D3DCOLOR_ARGB(0,0, 0, 0), 1.0f, 0);
		d3ddev->Present(NULL, NULL, NULL, NULL);
		return;
	}

	float fSpeed = (float)data.fSpeed() * fModifierSpeed;
	float fAcceleration = data.fAcceleration() * fModifierAcceleration;
	int nSpeedLimit = (int)(data.fSpeedLimit() * fModifierSpeed);
	int nNextSpeedLimit = (int)(data.fNextSpeedLimit() * fModifierSpeed);
	float fNextSpeedLimitDistance = data.fNextSpeedLimitDistance() * fModifierDistance;
	float fDistance = (float)g_fDistance * fModifierDistance;

	// AWS color (yellow - sunflower, red - push)
	DWORD awscolor = transparent;
	if (data.nAWS() > 0)
		awscolor = red;
	else if (data.nSunflower() > 0)
		awscolor = yellow;

	// VigilAlarm color (red - push)
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

	// speed color (white - OK, yellow - back, red - overspeed)
	DWORD speedcolor = white;
	if (fSpeed < -0.1f)
		speedcolor = yellow;
	if (abs(fSpeed) - nSpeedLimit > 0.9f)
		speedcolor = red;

	// countdown color
	DWORD countdowncolor = white;
	if (g_fDistance * fModifierDistance <= 1.0)
		countdowncolor = yellow;
	if (g_fDistance * fModifierDistance < 0.0)
		countdowncolor = red;

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
		DrawString(true, g_nWidth / 2 - 100, g_nHeight / 2, whitegreen, pBigFixedFont, sCountdown);
	}

	if (!g_bHideSection[11])
		DrawString(data.nClock, 350, 57, white, pBigFont, "%d:%02d:%02d",
					GETHOURS(data.nClock()), GETMINUTES(data.nClock()), GETSECONDS(data.nClock()));

	int yD = 5;
	int x = 15;
	int y = g_nHeight - yD;
	int yP = y;

	if (!g_bHideSection[8])
		y = DrawString(data.fGradient,						x+60,	y, whitegreen, pSmallFont, "Gradient: %s", gradient);

	y = NextSection(y, &yP, yD);

	if (!g_bHideSection[7])
	{
		y = DrawString(data.fEqReservoirPressure,			x+36,	y, whitered, pSmallFont, "Eq Reservoir: %.1f %s", data.fEqReservoirPressure(), data.sBrakeUnits());
		y = DrawString(data.fMainReservoirPressure,			x+24,	y, whitered, pSmallFont, "Main Reservoir: %.1f %s", data.fMainReservoirPressure(), data.sBrakeUnits());
		y = DrawString(data.fAirBrakePipePressure,			x+45,	y, whitered, pSmallFont, "Brake Pipe: %.1f %s", data.fAirBrakePipePressure(), data.sBrakeUnits());
		y = DrawString(data.fLocoBrakeCylinderPressure,		x+43,	y, whitered, pSmallFont, "Loco Brake: %.1f %s", data.fLocoBrakeCylinderPressure(), data.sBrakeUnits());
		y = DrawString(data.fTrainBrakeCylinderPressure,	x+43,	y, whitered, pSmallFont, "Train Brake: %.1f %s", data.fTrainBrakeCylinderPressure(), data.sBrakeUnits());
		//y = DrawString(data.fVacuumBrakeChamberPressure,	x+6,	y, whitered, pSmallFont, "Vacuum Chamber: %.1f Inches Hg", data.fVacuumBrakeChamberPressure());
		y = DrawString(data.fVacuumBrakePipePressure,		x+32,	y, whitered, pSmallFont, "Vacuum Pipe: %.1f Inches Hg", data.fVacuumBrakePipePressure());
		y = DrawString(data.fAmmeter,						x+56,	y, whitered, pSmallFont, "Ammeter: %.1f Amps", normalizeSign(data.fAmmeter()));
		y = DrawString(data.nRPM,							x+80,	y, whitered, pSmallFont, "RPM: %d RPM", (int)data.nRPM());
		y = DrawString(data.fSteamChestPressure,			x+33,	y, whitered, pSmallFont, "Steam Chest: %.1f PSI", data.fSteamChestPressure());
	}

	y = NextSection(y, &yP, yD);

	if (!g_bHideSection[6])
	{
		y = DrawString(data.fHandBrake,						x+41,	y, whiteblue, pSmallFont, "Hand Brake: %d %%", (int)(data.fHandBrake()*100));
		y = DrawString(data.fDynamicBrake,					x+20,	y, whiteblue, pSmallFont, "Dynamic Brake: %d %%", (int)(data.fDynamicBrake()*100));
		y = DrawString(data.fLocoBrake,						x+43,	y, whiteblue, pSmallFont, "Loco Brake: %d %%", (int)(data.fLocoBrake()*100));
		y = DrawString(data.fTrainBrake,					x+43,	y, whiteblue, pSmallFont, "Train Brake: %d %%", (int)(data.fTrainBrake()*100));
		y = DrawString(data.fThrottle,						x+66,	y, whiteblue, pSmallFont, "Throttle: %d %%", (int)(data.fThrottle()*100));
		y = DrawString(data.fGearLever,						x+81,	y, whiteblue, pSmallFont, "Gear: %d", (int)data.fGearLever());
		y = DrawString(data.fReverser,						x+59,	y, whiteblue, pSmallFont, "Reverser: %d %%", (int)(data.fReverser()*100));
		y = DrawString(data.fTargetSpeed,					x+34,	y, whiteblue, pSmallFont, "Target Speed: %.1f %s", data.fTargetSpeed(), sUnitsSpeed);
	}

	y = NextSection(y, &yP, yD);

	if (!g_bHideSection[5])
		y = DrawString(data.fAcceleration,					x+37,	y, white, pSmallFont, "Acceleration: %d %s", (int)getAverage(g_fAccelTable, ACCEL_TABLE_SIZE, &g_nAccelIndex, fAcceleration), sUnitsAcceleration);
	if (!g_bHideSection[4])
		y = DrawString(data.nNextSpeedLimitType,			x+50,	y, white, pSmallFont, "Next Limit: %s", nextlimit);

	y = NextSection(y, &yP, yD);

	if (!g_bHideSection[3])
	{
		if (g_bCountdown)
			y = DrawString(ISVALID(fDistance),				x+28,	y, countdowncolor, pMediumFont, "Countdown: %.2f %s", fDistance, sUnitsDistance);
		else
			y = DrawString(ISVALID(fDistance),				x+45,	y, white, pMediumFont, "Distance: %.2f %s", fDistance, sUnitsDistance);
	}

	if (!g_bHideSection[2])
		y = DrawString(data.fBoilerPressure,				x+67,	y, boilercolor, pMediumFont, "Boiler: %.1f PSI", data.fBoilerPressure());
	if (!g_bHideSection[1])
		y = DrawString(true,								x+62,	y, speedcolor, pMediumFont, "Speed: %.1f / %d %s", normalizeSign(fSpeed), nSpeedLimit, sUnitsSpeed);

	y = NextSection(y, &yP, yD);

	if (!g_bHideSection[12])
	{
		y = DrawString(data.sTextStartup,					x,		y, startupcolor, pBigFont, data.sTextStartup());
		y = DrawString(data.sTextEmergency,					x,		y, emergencycolor, pBigFont, data.sTextEmergency());
		y = DrawString(data.sTextVigilAlarm,				x,		y, vigilalarmcolor, pBigFont, data.sTextVigilAlarm());
		y = DrawString(data.sTextAWS,						x,		y, awscolor, pBigFont, data.sTextAWS());
	}

	// Steamer driver support
	x = 250;
	y = g_nHeight - yD;
	yP = y;

	if (!g_bHideSection[9] && data.fFireboxMass)
	{
		y = DrawString(data.fWaterScoopRaiseLower,			x+40,	y, white, pSmallFont, "Water Scoop: %d %%", (int)(data.fWaterScoopRaiseLower()*100));
		y = DrawString(data.fDamper,						x+71,	y, white, pSmallFont, "Damper: %d %%", (int)(data.fDamper()*100));
		y = DrawString(data.fCylinderCock,					x+28,	y, white, pSmallFont, "Cylinder Cocks: %d %%", (int)(data.fCylinderCock()*100));
		y = DrawString(data.fFireholeFlap,					x+41,	y, white, pSmallFont, "Firehole Flap: %d %%", (int)(data.fFireholeFlap()*100));
		y = DrawString(data.fAshpanSprinkler,				x+17,	y, white, pSmallFont, "Ashpan Sprinkler: %d %%", (int)(data.fAshpanSprinkler()*100));
		//y = DrawString(data.fWaterGaugeTest2,				x+0,	y, white, pSmallFont, "Water Gauge Test 2: %d %%", (int)(data.fWaterGaugeTest2()*100));
		//y = DrawString(data.fWaterGaugeTest1,				x+0,	y, white, pSmallFont, "Water Gauge Test 1: %d %%", (int)(data.fWaterGaugeTest1()*100));
		y = DrawString(data.fLubricatorWarming,				x+3,	y, white, pSmallFont, "Lubricator Warming: %d %%", (int)(data.fLubricatorWarming()*100));
		y = DrawString(data.fLubricator,					x+59,	y, white, pSmallFont, "Lubricator: %d %%", (int)(data.fLubricator()*100));
		y = DrawString(data.fGenerator,						x+59,	y, white, pSmallFont, "Generator: %d %%", (int)(data.fGenerator()*100));
		y = DrawString(data.fMasonsValve,					x+36,	y, white, pSmallFont, "Masons Valve: %d %%", (int)(data.fMasonsValve()*100));
		y = DrawString(data.fSteamHeating,					x+30,	y, white, pSmallFont, "Steam Heating: %d %%", (int)(data.fSteamHeating()*100));
		y = DrawString(data.fLargeEjector,					x+39,	y, white, pSmallFont, "Large Ejector: %d %%", (int)(data.fLargeEjector()*100));
		y = DrawString(data.fSmallEjector,					x+38,	y, white, pSmallFont, "Small Ejector: %d %%", (int)(data.fSmallEjector()*100));
		y = DrawString(data.fAirPump,						x+62,	y, white, pSmallFont, "Air Pump: %d %%", (int)(data.fAirPump()*100));
	}

	// Steamer fire-man support
	x = g_nWidth - 250;
	y = g_nHeight - yD;
	yP = y;

	if (!g_bHideSection[10] && data.fFireboxMass)
	{
		y = DrawString(data.fSafetyValve2,					x+72,	y, white, pSmallFont, "Safety Valve 2: %d %%", (int)(data.fSafetyValve2()*100));
		y = DrawString(data.fSafetyValve1,					x+72,	y, white, pSmallFont, "Safety Valve 1: %d %%", (int)(data.fSafetyValve1()*100));
		y = DrawString(data.fBlower,						x+94,	y, white, pSmallFont, "Blower (N): %d %%", (int)(data.fBlower()*100));
		y = NextSection(y, &yP, yD);
		y = DrawString(data.fStoking,						x+89,	y, whitered, pSmallFont, "Stoking (R): %d %%", (int)(data.fStoking()*100));
		y = DrawString(data.fFireboxDoor,					x+60,	y, whitered, pSmallFont, "Firebox Door (F): %d %%", (int)(data.fFireboxDoor()*100));
		y = DrawString(data.fFireboxMass,					x+99,	y, whitered, pMediumFont, "Firebox: %.1f %%", data.fFireboxMass()*100);
		y = NextSection(y, &yP, yD);
		y = DrawString(data.fLiveInjectorWater,				x+28,	y, whiteblue, pSmallFont, "Live Injector Water (L): %d %%", (int)(data.fLiveInjectorWater()*100));
		y = DrawString(data.fLiveInjectorSteam,				x+22,	y, whiteblue, pSmallFont, "Live Injector Steam (O): %d %%", (int)(data.fLiveInjectorSteam()*100));
		y = DrawString(data.fExhaustInjectorWater,			x+0,	y, whiteblue, pSmallFont, "Exhaust Injector Water (K): %d %%", (int)(data.fExhaustInjectorWater()*100));
		y = DrawString(data.fExhaustInjectorSteam,			x+3,	y, whiteblue, pSmallFont, "Exhaust Injector Steam (I): %d %%", (int)(data.fExhaustInjectorSteam()*100));
		y = DrawString(data.fWaterGauge,					x+109,	y, whiteblue, pMediumFont, "Water: %.1f %%", data.fWaterGauge()*100);
	}

	d3ddev->EndScene();    // ends the 3D scene
	d3ddev->Present(NULL, NULL, NULL, NULL);   // displays the created frame on the screen
}
