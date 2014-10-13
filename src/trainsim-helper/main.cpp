// Overlay.cpp : Defines the entry point for the application.
//

#include "stdafx.h"
#include "Joystick.h"
#include "Overlay.h"


HWND hWnd;
MARGINS margin = {0, 800, 0, 600};

HWND FindTSWindow()
{
	HWND ret;

	ret = FindWindow(NULL, "Train Simulator 2015");
	if (!ret)
		ret = FindWindow(NULL, "Train Simulator 2014");

	return ret;
}

PCHAR* CommandLineToArgvA(PCHAR CmdLine, int* _argc)
{
	PCHAR* argv;
	PCHAR  _argv;
	ULONG   len;
	ULONG   argc;
	CHAR   a;
	ULONG   i, j;

	BOOLEAN  in_QM;
	BOOLEAN  in_TEXT;
	BOOLEAN  in_SPACE;

	len = strlen(CmdLine);
	i = ((len+2)/2)*sizeof(PVOID) + sizeof(PVOID);

	argv = (PCHAR*)GlobalAlloc(GMEM_FIXED,
		i + (len+2)*sizeof(CHAR));

	_argv = (PCHAR)(((PUCHAR)argv)+i);

	argc = 0;
	argv[argc] = _argv;
	in_QM = FALSE;
	in_TEXT = FALSE;
	in_SPACE = TRUE;
	i = 0;
	j = 0;

	while( a = CmdLine[i] ) {
		if(in_QM) {
			if(a == '\"') {
				in_QM = FALSE;
			} else {
				_argv[j] = a;
				j++;
			}
		} else {
			switch(a) {
			case '\"':
				in_QM = TRUE;
				in_TEXT = TRUE;
				if(in_SPACE) {
					argv[argc] = _argv+j;
					argc++;
				}
				in_SPACE = FALSE;
				break;
			case ' ':
			case '\t':
			case '\n':
			case '\r':
				if(in_TEXT) {
					_argv[j] = '\0';
					j++;
				}
				in_TEXT = FALSE;
				in_SPACE = TRUE;
				break;
			default:
				in_TEXT = TRUE;
				if(in_SPACE) {
					argv[argc] = _argv+j;
					argc++;
				}
				_argv[j] = a;
				j++;
				in_SPACE = FALSE;
				break;
			}
		}
		i++;
	}
	_argv[j] = '\0';
	argv[argc] = NULL;

	(*_argc) = argc;
	return argv;
}

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

		if (isdigit(pArgList[i][1]))
		{
			int nSection = atoi(pArgList[i]+1);
			if (nSection >= 0 && nSection <= 12)
				ToggleDisplaySection(nSection % 12);
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

	for (int i = 1; i <= 12; ++i)
		RegisterHotKey(hWnd, i % 12, MOD_SHIFT | MOD_ALT, VK_F1+i-1);

	RegisterHotKey(hWnd, 12, MOD_SHIFT | MOD_ALT, 0x52 /* R key */);

	for (int i = 20; i <= 29; ++i)
		RegisterHotKey(hWnd, i, MOD_SHIFT | MOD_ALT, i-20+0x30);

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
		if (wParam >= 0 && wParam <= 11)
			ToggleDisplaySection(wParam);
		else if (wParam == 12)
			ResetDistance();
		else if (wParam >= 20 && wParam <= 29)
			SetCountdown(wParam - 20);
		break;
	}

	return DefWindowProc (hWnd, message, wParam, lParam);
}
