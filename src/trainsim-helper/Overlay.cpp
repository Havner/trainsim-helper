#include "stdafx.h"

#include <stdio.h>
#include <errno.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string>
#include "Config.h"
#include "Overlay.h"

#define INVALID					(-99999)
#define ISVALID(n)				((n) > INVALID)
#define INVALID_STRING			"STRING_MISSING"
#define GETHOURS(nClock)		((nClock) / 3600)
#define GETMINUTES(nClock)		(((nClock) % 3600) / 60)
#define GETSECONDS(nClock)		((nClock) % 60)
#define ACCEL_TABLE_SIZE		30
#define SECTIONS_TABLE_SIZE		12
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

template<typename T>
T aton(const char*)
{
	return INVALID;
}
template<>
float aton(const char* s)
{
	return (float)atof(s);
}
template<>
double aton(const char* s)
{
	return atof(s);
}
template<>
int aton(const char* s)
{
	return atoi(s);
}

template<typename T>
struct Value
{
	T v;
	Value() : v(INVALID) {}
	Value& operator=(const T& o) {
		v = o;
		return *this;
	}
	Value& operator=(const char* o) {
		v = aton<T>(o);
		return *this;
	}
	operator bool() const {
		return ISVALID(v);
	}
	T operator()() {
		return v;
	}
};

template<>
struct Value<std::string>
{
	std::string v;
	Value() : v(INVALID_STRING) {}
	Value& operator=(const char *o) {
		v = std::string(o);
		return *this;
	}
	operator bool() const {
		return v.compare(INVALID_STRING) != 0;
	}
	const char *operator()() {
		return v.c_str();
	}
};

struct SimData {
	Value<int>			nClock;
	Value<std::string>	sUnits;
	Value<double>		fSpeed;
	Value<float>		fSpeedLimit;
	Value<int>			nNextSpeedLimitType;
	Value<float>		fNextSpeedLimit;
	Value<float>		fNextSpeedLimitDistance;
	Value<float>		fAcceleration;
	Value<float>		fGradient;

	Value<float>		fTargetSpeed;
	Value<float>		fReverser;
	Value<float>		fGearLever;
	Value<float>		fThrottle;
	Value<float>		fTrainBrake;
	Value<float>		fLocoBrake;
	Value<float>		fDynamicBrake;
	Value<float>		fAmmeter;
	Value<int>			nRPM;
	Value<float>		fVacuumBrakePipePressure;
	Value<std::string>	sBrakeUnits;
	Value<float>		fTrainBrakeCylinderPressure;
	Value<float>		fAirBrakePipePressure;
	Value<float>		fMainReservoirPressure;
	Value<float>		fEqReservoirPressure;
	Value<int>			nSunflower;
	Value<int>			nAWS;
	Value<int>			nVigilAlarm;
	Value<int>			nEmergencyBrake;
	Value<int>			nStartup;

	Value<std::string>  sTextAWS;
	Value<std::string>  sTextVigilAlarm;
	Value<std::string>  sTextEmergency;
	Value<std::string>  sTextStartup;
	Value<int>			nGradientUK;

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

		// Loco's values
		else if (!strcmp("TargetSpeed:", param))				data->fTargetSpeed = value;
		else if (!strcmp("Reverser:", param))					data->fReverser = value;
		else if (!strcmp("GearLever:", param))					data->fGearLever = value;
		else if (!strcmp("Throttle:", param))					data->fThrottle = value;
		else if (!strcmp("TrainBrake:", param))					data->fTrainBrake = value;
		else if (!strcmp("LocoBrake:", param))					data->fLocoBrake = value;
		else if (!strcmp("DynamicBrake:", param))				data->fDynamicBrake = value;
		else if (!strcmp("Ammeter:", param))					data->fAmmeter = value;
		else if (!strcmp("RPM:", param))						data->nRPM = value;
		else if (!strcmp("VacuumBrakePipePressure:", param))	data->fVacuumBrakePipePressure = value;
		else if (!strcmp("BrakeUnits:", param))					data->sBrakeUnits = value;
		else if (!strcmp("TrainBrakeCylinderPressure:", param))	data->fTrainBrakeCylinderPressure = value;
		else if (!strcmp("AirBrakePipePressure:", param))		data->fAirBrakePipePressure = value;
		else if (!strcmp("MainReservoirPressure:", param))		data->fMainReservoirPressure = value;
		else if (!strcmp("EqReservoirPressure:", param))		data->fEqReservoirPressure = value;
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

inline float getAvgAccel(float a)
{
	float fAvgAccel = 0;
	g_fAccelTable[g_nAccelIndex] = a;
	for (int i = 0; i < ACCEL_TABLE_SIZE; i++)
		fAvgAccel += g_fAccelTable[i];
	fAvgAccel /= ACCEL_TABLE_SIZE;
	g_nAccelIndex = (g_nAccelIndex + 1) % ACCEL_TABLE_SIZE;
	return fAvgAccel;
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
	else /*if (data.sUnits()[0] == 'M')*/ /* also handle no speedometer case */
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
		y = DrawString(data.fGradient,						x+40,	y, whitegreen, pSmallFont, "Gradient: %s", gradient);

	y = NextSection(y, &yP, yD);

	if (!g_bHideSection[7])
	{
		y = DrawString(data.fEqReservoirPressure,			x+16,	y, whitered, pSmallFont, "Eq Reservoir: %.1f %s", data.fEqReservoirPressure(), data.sBrakeUnits());
		y = DrawString(data.fMainReservoirPressure,			x+4,	y, whitered, pSmallFont, "Main Reservoir: %.1f %s", data.fMainReservoirPressure(), data.sBrakeUnits());
		y = DrawString(data.fAirBrakePipePressure,			x+25,	y, whitered, pSmallFont, "Brake Pipe: %.1f %s", data.fAirBrakePipePressure(), data.sBrakeUnits());
		y = DrawString(data.fTrainBrakeCylinderPressure,	x+4,	y, whitered, pSmallFont, "Brake Cylinder: %.1f %s", data.fTrainBrakeCylinderPressure(), data.sBrakeUnits());
		y = DrawString(data.fVacuumBrakePipePressure,		x+12,	y, whitered, pSmallFont, "Vacuum Pipe: %.1f Inches Hg", data.fVacuumBrakePipePressure());
	}
	if (!g_bHideSection[6])
	{
		y = DrawString(data.fAmmeter,						x+36,	y, whitered, pSmallFont, "Ammeter: %.1f Amps", normalizeSign(data.fAmmeter()));
		y = DrawString(data.nRPM,							x+60,	y, whitered, pSmallFont, "RPM: %d RPM", (int)data.nRPM());
	}

	y = NextSection(y, &yP, yD);

	if (!g_bHideSection[5])
	{
		y = DrawString(data.fDynamicBrake,					x+0,	y, whiteblue, pSmallFont, "Dynamic Brake: %d %%", (int)(data.fDynamicBrake()*100));
		y = DrawString(data.fLocoBrake,						x+23,	y, whiteblue, pSmallFont, "Loco Brake: %d %%", (int)(data.fLocoBrake()*100));
		y = DrawString(data.fTrainBrake,					x+23,	y, whiteblue, pSmallFont, "Train Brake: %d %%", (int)(data.fTrainBrake()*100));
		y = DrawString(data.fThrottle,						x+46,	y, whiteblue, pSmallFont, "Throttle: %d %%", (int)(data.fThrottle()*100));
		y = DrawString(data.fGearLever,						x+61,	y, whiteblue, pSmallFont, "Gear: %d", (int)data.fGearLever());
		y = DrawString(data.fReverser,						x+39,	y, whiteblue, pSmallFont, "Reverser: %d %%", (int)(data.fReverser()*100));
		y = DrawString(data.fTargetSpeed,					x+14,	y, whiteblue, pSmallFont, "Target Speed: %.1f %s", data.fTargetSpeed(), sUnitsSpeed);
	}

	y = NextSection(y, &yP, yD);

	if (!g_bHideSection[4])
		y = DrawString(data.fAcceleration,					x+18,	y, white, pSmallFont, "Acceleration: %d %s", (int)getAvgAccel(fAcceleration), sUnitsAcceleration);
	if (!g_bHideSection[3])
		y = DrawString(data.nNextSpeedLimitType,			x+31,	y, white, pSmallFont, "Next Limit: %s", nextlimit);

	y = NextSection(y, &yP, yD);

	if (!g_bHideSection[2])
	{
		if (g_bCountdown)
			y = DrawString(ISVALID(fDistance),				x+9,	y, countdowncolor, pMediumFont, "Countdown: %.2f %s", fDistance, sUnitsDistance);
		else
			y = DrawString(ISVALID(fDistance),				x+26,	y, white, pMediumFont, "Distance: %.2f %s", fDistance, sUnitsDistance);
	}

	if (!g_bHideSection[1])
		y = DrawString(true,								x+43,	y, speedcolor, pMediumFont, "Speed: %.1f / %d %s", normalizeSign(fSpeed), nSpeedLimit, sUnitsSpeed);

	y = NextSection(y, &yP, yD);

	if (!g_bHideSection[9])
	{
		y = DrawString(data.sTextStartup,					x,		y, startupcolor, pBigFont, data.sTextStartup());
		y = DrawString(data.sTextEmergency,					x,		y, emergencycolor, pBigFont, data.sTextEmergency());
		y = DrawString(data.sTextVigilAlarm,				x,		y, vigilalarmcolor, pBigFont, data.sTextVigilAlarm());
		y = DrawString(data.sTextAWS,						x,		y, awscolor, pBigFont, data.sTextAWS());
	}

	d3ddev->EndScene();    // ends the 3D scene
	d3ddev->Present(NULL, NULL, NULL, NULL);   // displays the created frame on the screen
}
