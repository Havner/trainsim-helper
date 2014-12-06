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

		if (isdigit(pArgList[i][1]))
		{
			int nSection = atoi(pArgList[i]+1);
			if (nSection >= 1 && nSection <= 12)
				ToggleDisplaySection(nSection);
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

	// 0-9 digits for the countdown
	for (int i = 0; i <= 9; ++i)
		RegisterHotKey(hWnd, i, MOD_SHIFT | MOD_ALT, 0x30 + i);

	// additional 0, 7, 8, 9 for the countdown
	RegisterHotKey(hWnd, 0, MOD_SHIFT | MOD_ALT, 0x4F); // O
	RegisterHotKey(hWnd, 7, MOD_SHIFT | MOD_ALT, 0x51); // Q
	RegisterHotKey(hWnd, 8, MOD_SHIFT | MOD_ALT, 0x57); // W
	RegisterHotKey(hWnd, 9, MOD_SHIFT | MOD_ALT, 0x45); // E

	// R for the countdown reset
	RegisterHotKey(hWnd, 10, MOD_SHIFT | MOD_ALT, 0x52 /* R key */);

	// F1-F12 for the overlay
	for (int i = 11; i <= 22; ++i)
		RegisterHotKey(hWnd, i, MOD_SHIFT | MOD_ALT, VK_F1-11 + i);

	// V for the whole overlay
	RegisterHotKey(hWnd, 23, MOD_SHIFT | MOD_ALT, 0x56 /* V key */);

	// S for invert
	RegisterHotKey(hWnd, 24, MOD_SHIFT | MOD_ALT, 0x53 /* S key */);

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
		if (wParam >= 0 && wParam <= 9)
			SetCountdown(wParam);
		else if (wParam == 10)
			ResetDistance();
		else if (wParam >= 11 && wParam <= 22)
			ToggleDisplaySection(wParam - 10);
		else if (wParam == 23)
			ToggleDisplaySection(0);
		else if (wParam == 24)
			ToggleInvert();
		break;
	}

	return DefWindowProc (hWnd, message, wParam, lParam);
}
