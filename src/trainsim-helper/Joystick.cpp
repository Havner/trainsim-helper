#include "stdafx.h"

#include <stdio.h>
#include "Config.h"
#include "Joystick.h"

#define MAX_VALUE		32768
#define JOYSTICKS		8
#define JOY_AXES		8

BOOL CALLBACK    EnumObjectsCallback( const DIDEVICEOBJECTINSTANCE* pdidoi, VOID* pContext );
BOOL CALLBACK    EnumJoysticksCallback( const DIDEVICEINSTANCE* pdidInstance, VOID* pContext );

#define SAFE_DELETE(p)  { if(p) { delete (p);     (p)=NULL; } }
#define SAFE_RELEASE(p) { if(p) { (p)->Release(); (p)=NULL; } }

LPDIRECTINPUT8          g_pDI = NULL;

struct Joystick {
	LPDIRECTINPUTDEVICE8 pJoystick;
	int nSliders;
	bool bAxes[JOY_AXES];
	char *sName[JOY_AXES];
	int nPrevValues[JOY_AXES];
};

Joystick gJoysticks[JOYSTICKS];

inline float Normalize(int nValue)
{
	return ( nValue / (float)MAX_VALUE );
}

// Frame update
void UpdateJoystick()
{
	bool bChanged = false;

	// First loop for polling and saving results
	for ( int nJoy = 0; nJoy < JOYSTICKS; ++nJoy )
	{
		if( NULL == gJoysticks[nJoy].pJoystick )
			continue;

		HRESULT hr;

		// Poll the device to read the current state
		hr = gJoysticks[nJoy].pJoystick->Poll();
		if( FAILED( hr ) )
		{
			// DInput is telling us that the input stream has been
			// interrupted. We aren't tracking any state between polls, so
			// we don't have any special reset that needs to be done. We
			// just re-acquire and try again.
			hr = gJoysticks[nJoy].pJoystick->Acquire();
			while( hr == DIERR_INPUTLOST )
				hr = gJoysticks[nJoy].pJoystick->Acquire();

			// hr may be DIERR_OTHERAPPHASPRIO or other errors.  This
			// may occur when the app is minimized or in the process of
			// switching, so just try again later
			continue;
		}

		// Get the input's device state
		DIJOYSTATE2 js;
		if( FAILED( hr = gJoysticks[nJoy].pJoystick->GetDeviceState( sizeof( DIJOYSTATE2 ), &js ) ) )
			continue; // The device should have been acquired during the Poll()

		LONG *nValues = (LONG*)&js;

		for (int i = 0; i < JOY_AXES; ++i)
		{
			if (gJoysticks[nJoy].bAxes[i] && (gJoysticks[nJoy].nPrevValues[i] != nValues[i]))
			{
				gJoysticks[nJoy].nPrevValues[i] = nValues[i];
				bChanged = true;
			}
		}
	}

	if (!bChanged)
		return;

	FILE *f = fopen(SETDATATXT, "w");
	if (f == NULL)
		return;

	int nLine = 1;
	// Second loop for writing file to minimize the write time
	for ( int nJoy = 0; nJoy < JOYSTICKS; ++nJoy )
		for ( int i = 0; i < JOY_AXES; ++i )
			if ( gJoysticks[nJoy].bAxes[i] )
				fprintf(f, "%f     #%d Joy %d: %s\n", Normalize(gJoysticks[nJoy].nPrevValues[i]), nLine++, nJoy+1, gJoysticks[nJoy].sName[i]);

	fclose(f);
}


//-----------------------------------------------------------------------------
// Name: InitDirectInput()
// Desc: Initialize the DirectInput variables.
//-----------------------------------------------------------------------------
HRESULT InitDirectInput()
{
	HRESULT hr;
	int nJoyIter = 0;

	// Register with the DirectInput subsystem and get a pointer
	// to a IDirectInput interface we can use.
	// Create a DInput object
	if( FAILED( hr = DirectInput8Create( GetModuleHandle( NULL ), DIRECTINPUT_VERSION,
		IID_IDirectInput8, ( VOID** )&g_pDI, NULL ) ) )
		return hr;

	// Look for a simple joystick we can use for this sample program.
	if( FAILED( hr = g_pDI->EnumDevices( DI8DEVCLASS_GAMECTRL,
		EnumJoysticksCallback, &nJoyIter, DIEDFL_ATTACHEDONLY ) ) )
		return hr;

	bool bFound = false;

	for ( nJoyIter = 0; nJoyIter < JOYSTICKS; ++nJoyIter )
	{
		if( gJoysticks[nJoyIter].pJoystick == NULL )
			continue;

		// Set the data format to "simple joystick" - a predefined data format 
		// A data format specifies which controls on a device we are interested in,
		// and how they should be reported. This tells DInput that we will be
		// passing a DIJOYSTATE2 structure to IDirectInputDevice::GetDeviceState().
		if( FAILED( hr = gJoysticks[nJoyIter].pJoystick->SetDataFormat( &c_dfDIJoystick2 ) ) )
		{
			gJoysticks[nJoyIter].pJoystick->Unacquire();
			gJoysticks[nJoyIter].pJoystick = NULL;
			SAFE_RELEASE( gJoysticks[nJoyIter].pJoystick );
			continue;
		}

		// Enumerate the joystick objects. The callback function enabled user
		// interface elements for objects that are found, and sets the min/max
		// values property for discovered axes.
		if( FAILED( hr = gJoysticks[nJoyIter].pJoystick->EnumObjects( EnumObjectsCallback, &nJoyIter, DIDFT_ALL ) ) )
		{
			gJoysticks[nJoyIter].pJoystick->Unacquire();
			gJoysticks[nJoyIter].pJoystick = NULL;
			SAFE_RELEASE( gJoysticks[nJoyIter].pJoystick );
			continue;
		}

		bFound = true;
	}

	// Make sure we got a joystick
	if( !bFound )
		MessageBox( NULL, TEXT( "Joystick not found." ),
			TEXT( "TrainSim Helper" ), MB_ICONERROR | MB_OK );

	return S_OK;
}

//-----------------------------------------------------------------------------
// Name: EnumJoysticksCallback()
// Desc: Called once for each enumerated joystick. If we find one, create a
//       device interface on it so we can play with it.
//-----------------------------------------------------------------------------
BOOL CALLBACK EnumJoysticksCallback( const DIDEVICEINSTANCE* pdidInstance, VOID* pContext )
{
	int* nJoy = ( int* )pContext;
	HRESULT hr;

	// Obtain an interface to the enumerated joystick.
	hr = g_pDI->CreateDevice( pdidInstance->guidInstance, &gJoysticks[*nJoy].pJoystick, NULL );

	// If it failed, then we can't use this joystick. (Maybe the user unplugged
	// it while we were in the middle of enumerating it.)
	if( FAILED( hr ) ) {
		gJoysticks[*nJoy].pJoystick = NULL;
	}

	// Continue the enumeration up to 8 devices.
	if ( (*nJoy)++ >= JOYSTICKS )
		return DIENUM_STOP;

	return DIENUM_CONTINUE;
}

//-----------------------------------------------------------------------------
// Name: EnumObjectsCallback()
// Desc: Callback function for enumerating objects (axes, buttons, POVs) on a 
//       joystick. This function enables user interface elements for objects
//       that are found to exist, and scales axes min/max values.
//-----------------------------------------------------------------------------
BOOL CALLBACK EnumObjectsCallback( const DIDEVICEOBJECTINSTANCE* pdidoi, VOID* pContext )
{
	int* nJoy = ( int* )pContext;

	// For axes that are returned, set the DIPROP_RANGE property for the
	// enumerated axis in order to scale min/max values.
	if( pdidoi->dwType & DIDFT_AXIS )
	{
		DIPROPRANGE diprg;
		diprg.diph.dwSize = sizeof( DIPROPRANGE );
		diprg.diph.dwHeaderSize = sizeof( DIPROPHEADER );
		diprg.diph.dwHow = DIPH_BYID;
		diprg.diph.dwObj = pdidoi->dwType; // Specify the enumerated axis
		diprg.lMin = 0;
		diprg.lMax = MAX_VALUE;

		// Set the range for the axis
		if( FAILED( gJoysticks[*nJoy].pJoystick->SetProperty( DIPROP_RANGE, &diprg.diph ) ) )
			return DIENUM_STOP;
	}

    // Set the UI to reflect what objects the joystick supports 
    if( pdidoi->guidType == GUID_XAxis )
	{
		gJoysticks[*nJoy].bAxes[0] = true;
		gJoysticks[*nJoy].sName[0] = "X";
	}
    else if( pdidoi->guidType == GUID_YAxis )
	{
		gJoysticks[*nJoy].bAxes[1] = true;
		gJoysticks[*nJoy].sName[1] = "Y";
	}
    else if( pdidoi->guidType == GUID_ZAxis )
	{
		gJoysticks[*nJoy].bAxes[2] = true;
		gJoysticks[*nJoy].sName[2] = "Z";
	}
    else if( pdidoi->guidType == GUID_RxAxis )
	{
		gJoysticks[*nJoy].bAxes[3] = true;
		gJoysticks[*nJoy].sName[3] = "Rx";
	}
    else if( pdidoi->guidType == GUID_RyAxis )
	{
		gJoysticks[*nJoy].bAxes[4] = true;
		gJoysticks[*nJoy].sName[4] = "Ry";
	}
    else if( pdidoi->guidType == GUID_RzAxis )
	{
		gJoysticks[*nJoy].bAxes[5] = true;
		gJoysticks[*nJoy].sName[5] = "Rz";
	}
    else if( pdidoi->guidType == GUID_Slider )
    {
		switch( gJoysticks[*nJoy].nSliders++ )
        {
            case 0 :
				gJoysticks[*nJoy].bAxes[6] = true;
				gJoysticks[*nJoy].sName[6] = "Slider1";
                break;
            case 1 :
				gJoysticks[*nJoy].bAxes[7] = true;
				gJoysticks[*nJoy].sName[7] = "Slider2";
                break;
        }
    }

	return DIENUM_CONTINUE;
}

//-----------------------------------------------------------------------------
// Name: FreeDirectInput()
// Desc: Initialize the DirectInput variables.
//-----------------------------------------------------------------------------
VOID FreeDirectInput()
{
	// Unacquire the device one last time just in case 
	// the app tried to exit while the device is still acquired.
	for ( int nJoy = 0; nJoy < JOYSTICKS; ++nJoy )
		if ( gJoysticks[nJoy].pJoystick != NULL )
		{
			gJoysticks[nJoy].pJoystick->Unacquire();
			SAFE_RELEASE( gJoysticks[nJoy].pJoystick );
		}

	// Release any DirectInput objects.
	SAFE_RELEASE( g_pDI );
}
