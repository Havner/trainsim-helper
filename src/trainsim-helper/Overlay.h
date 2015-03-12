#pragma once

#include "stdafx.h"

enum eOverlayPart {
	eAlways = -1,
	eOverlay,					// 0
	eMainSpeed,					// 1
	eMainBoiler,				// 2
	eMainDistance,				// 3
	eMainNextSpeed,				// 4
	eMainAcceleration,			// 5
	eMainControls,				// 6
	eMainIndicators,			// 7
	eMainBrakes,				// 8
	eMainGradient,				// 9
	eMainReserved10,			// 10
	eMainWarnings,				// 11
	eMainClock,					// 12
	eSteamDriverPrimary,		// 1
	eSteamDriverSecondary,		// 2
	eSteamFiremanPrimary,		// 3
	eSteamFiremanSecondary,		// 4
	eSteamFire,					// 5
	eSteamFireIndicators,		// 6
	eSteamFireControls,			// 7
	eSteamReserved8,			// 8
	eSteamWater,				// 9
	eSteamWaterIndicators,		// 10
	eSteamWaterControls,		// 11
	eSteamSafety,				// 12

	eOverlaySize
};

void InitD3D(HWND hWnd, int nWidth, int nHeight);
void ResetDistance();
void SetCountdown(char n);
void ToggleDisplaySection(int s);
void ToggleInvert();
void ToggleFontOutline();
void ToggleSpeedLimitOnly();
void RenderOverlay();
