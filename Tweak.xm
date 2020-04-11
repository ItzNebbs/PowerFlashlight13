#import "Tweak.h"

%hook AVFlashlight
	- (id)init {
		if (!_sharedFlashlight) {
			_sharedFlashlight = %orig;
		}
		return _sharedFlashlight;
	}
%end

%hook SpringBoard
	- (BOOL)_handlePhysicalButtonEvent:(UIPressesEvent *)arg1  {
		int type = arg1.allPresses.allObjects[0].type; 
		int force = arg1.allPresses.allObjects[0].force;
		if (type == 104 && force == 1) {
            pressedTimer = [[NSTimer scheduledTimerWithTimeInterval:.6 target:self selector:@selector(toggleFlashlightOn) userInfo:nil repeats:NO] retain];
		}
		if (type == 104 && force == 0) {
			pressedTimer = [[NSTimer scheduledTimerWithTimeInterval:.6 target:self selector:@selector(toggleFlashlightOff) userInfo:nil repeats:NO] retain];
		}
		return %orig;
	}
    %new
    - (void)toggleFlashlightOn {
        if (_sharedFlashlight.flashlightLevel == 0.0) {
            [_sharedFlashlight setFlashlightLevel:1.0 withError:nil];
        }
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, ^{
            AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
        });
    }
	%new
	- (void)toggleFlashlightOff {
		if (_sharedFlashlight.flashlightLevel == 1.0) {
            [_sharedFlashlight setFlashlightLevel:0.0 withError:nil];
        }
		AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, ^{
            AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
        });
	}
%end