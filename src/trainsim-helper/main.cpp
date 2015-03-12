// main.cpp : Defines the entry point for the application.

#include "stdafx.h"
#include "System.h"
#include "Joystick.h"
#include "Overlay.h"

HWND hWnd;
MARGINS margin = {0, 800, 0, 600};

LRESULT CALLBACK WindowProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam);

int WINAPI WinMain(HINSTANCE hInstance,
	HINSTANCE hPrevInstance,
	LPSTR lpCmdLine,
	int nCmdShow)
{
	RECT rc;
	int nWidth;
	int nHeight;

	HWND hWndTS = FindTSWindow();
	if(hWndTS != NULL) {
		GetWindowRect(hWndTS, &rc);
		nWidth = rc.right - rc.left;
		nHeight = rc.bottom - rc.top;
	} else {
		ExitProcess(0);
	}

	bool bUseJoystick = true;
	int nArgCount;
	LPSTR *pArgList;

	pArgList = CommandLineToArgvA(GetCommandLine(), &nArgCount);
	for (int i = 0; i < nArgCount; ++i)
	{
		if (pArgList[i][0] != '-')
			continue;

		if (strcmp(pArgList[i]+1, "j") == 0)
			bUseJoystick = !bUseJoystick;

		if (strcmp(pArgList[i]+1, "v") == 0)
			ToggleDisplaySection(0);

		if (strcmp(pArgList[i]+1, "f") == 0)
			ToggleFontOutline();

		if (strcmp(pArgList[i]+1, "s") == 0)
			ToggleSpeedLimitOnly();

		if (pArgList[i][1] == 'm')
		{
			if (isdigit(pArgList[i][2]))
			{
				int nSection = atoi(pArgList[i]+2);
				if (nSection >= 1 && nSection <= 12)
					ToggleDisplaySection(nSection);
			}
		}

		if (pArgList[i][1] == 's')
		{
			if (isdigit(pArgList[i][2]))
			{
				int nSection = atoi(pArgList[i]+2);
				if (nSection >= 1 && nSection <= 12)
					ToggleDisplaySection(nSection + 12);
			}
		}
	}

	margin.cxRightWidth = nWidth;
	margin.cyBottomHeight = nHeight;

	WNDCLASSEX wc;
	ZeroMemory(&wc, sizeof(WNDCLASSEX));

	wc.cbSize = sizeof(WNDCLASSEX);
	wc.style = CS_HREDRAW | CS_VREDRAW;
	wc.lpfnWndProc = WindowProc;
	wc.hInstance = hInstance;
	wc.hCursor = LoadCursor(NULL, IDC_ARROW);
	wc.hbrBackground = (HBRUSH)RGB(0,0,0);
	wc.lpszClassName = "WindowClass";

	RegisterClassEx(&wc);

	hWnd = CreateWindowEx(0,
		"WindowClass",
		"TrainSim Helper",
		WS_EX_TOPMOST | WS_POPUP,
		rc.left, rc.top,
		nWidth, nHeight,
		NULL,
		NULL,
		hInstance,
		NULL);

	SetWindowLong(hWnd, GWL_EXSTYLE,(int)GetWindowLong(hWnd, GWL_EXSTYLE) | WS_EX_LAYERED |WS_EX_TRANSPARENT);
	SetLayeredWindowAttributes(hWnd, RGB(0,0,0), 255, ULW_COLORKEY | LWA_ALPHA);

	ShowWindow(hWnd, nCmdShow);

	InitD3D(hWnd, nWidth, nHeight);
	MSG msg;
	::SetWindowPos(hWndTS, HWND_NOTOPMOST,0,0,0,0,SWP_NOMOVE|SWP_NOSIZE);

	// V for the whole overlay
	RegisterHotKey(hWnd, 0, MOD_SHIFT | MOD_ALT, 0x56 /* V key */);

	// F1-F12 for the main overlay
	for (int i = 1; i <= 12; ++i)
		RegisterHotKey(hWnd, i, MOD_SHIFT | MOD_ALT, VK_F1 + i - 1);

	// F1-F12 for the steam overlay
	for (int i = 13; i <= 24; ++i)
		RegisterHotKey(hWnd, i, MOD_SHIFT | MOD_CONTROL, VK_F1 + i - 13);

	// 0-9 digits for the countdown
	for (int i = 100; i <= 109; ++i)
		RegisterHotKey(hWnd, i, MOD_SHIFT | MOD_ALT, 0x30 + i - 100);

	// R for the countdown reset
	RegisterHotKey(hWnd, 110, MOD_SHIFT | MOD_ALT, 0x52 /* R key */);

	// D for driving direction
	RegisterHotKey(hWnd, 201, MOD_SHIFT | MOD_ALT, 0x44 /* D key */);

	// F for font outline
	RegisterHotKey(hWnd, 202, MOD_SHIFT | MOD_ALT, 0x46 /* F key */);

	// S for speed limit only
	RegisterHotKey(hWnd, 203, MOD_SHIFT | MOD_ALT, 0x53 /* S key */);

	if (bUseJoystick)
		if (FAILED(InitDirectInput()))
			ExitProcess(0);

	bool fDone = false;

	while(!fDone)
	{
		hWndTS = FindTSWindow();
		if (!hWndTS)
		{
			msg.wParam = 0;
			break;
		}

		RECT rcNew;
		GetWindowRect(hWndTS, &rcNew);
		if (rcNew.left != rc.left || rcNew.top != rc.top)
		{
			rc = rcNew;
			MoveWindow(hWnd, rc.left, rc.top, nWidth, nHeight, FALSE);
		}

		::SetWindowPos(hWnd, HWND_TOPMOST,0,0,0,0,SWP_NOMOVE|SWP_NOSIZE);
		Sleep(10);

		RenderOverlay();
		if (bUseJoystick)
			UpdateJoystick();

		while(PeekMessage(&msg, NULL, 0, 0, PM_REMOVE))
		{
			TranslateMessage(&msg);
			DispatchMessage(&msg);

			switch(msg.message)
			{
			case WM_QUIT:
				fDone = true;
				break;
			}
		}
	}

	if (bUseJoystick)
		FreeDirectInput();

	return msg.wParam;
}


LRESULT CALLBACK WindowProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	switch(message)
	{
	case WM_PAINT:
		DwmExtendFrameIntoClientArea(hWnd, &margin);
		break;
	case WM_DESTROY:
		PostQuitMessage(0);
		return 0;
	case WM_HOTKEY:
		if (wParam >= 0 && wParam <= 24)
			ToggleDisplaySection(wParam);
		else if (wParam >= 100 && wParam <= 109)
			SetCountdown(wParam - 100);
		else if (wParam == 110)
			ResetDistance();
		else if (wParam == 201)
			ToggleInvert();
		else if (wParam == 202)
			ToggleFontOutline();
		else if (wParam == 203)
			ToggleSpeedLimitOnly();
		break;
	}

	return DefWindowProc (hWnd, message, wParam, lParam);
}
