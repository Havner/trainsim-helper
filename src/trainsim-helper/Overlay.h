#pragma once

#include "stdafx.h"

enum eOverlayPart {
	eAlways = -1,
	eOverlay,					// 0
	eMainSpeed,					// 1
	eMainDistance,				// 2
	eMainNextSpeed,				// 3
	eMainAcceleration,			// 4
	eMainControls,				// 5
	eMainIndicators,			// 6
	eMainIndicatorsBrakes,		// 7
	eMainGradient,				// 8
	eMainReserved9,				// 9
	eMainReserved10,			// 10
	eMainWarnings,				// 11
	eMainClock,					// 12
	eSteamBoiler,				// 1 (steamers)
	eSteamIndicators,			// 2
	eSteamDriverPrimary,		// 3
	eSteamDriverSecondary,		// 4
	eSteamReserved5,			// 5
	eSteamFiremanPrimary,		// 6
	eSteamFiremanSecondary,		// 7
	eSteamSafety,				// 8
	eSteamFirePrimary,			// 9
	eSteamFireSecondary,		// 10
	eSteamWaterPrimary,			// 11
	eSteamWaterSecondary,		// 12

	eOverlaySize
};

void InitD3D(HWND hWnd, int nWidth, int nHeight);
void ResetDistance();
void SetCountdown(char n);
void ToggleDisplaySection(int s);
void ToggleInvert();
void ToggleFontOutline();
void RenderOverlay();
