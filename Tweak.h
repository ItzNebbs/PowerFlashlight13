#import <AudioToolbox/AudioServices.h>
#import "AVFlashlight.h"

NSTimer *pressedTimer;
static AVFlashlight *_sharedFlashlight;

@interface SpringBoard : NSObject
- (BOOL)_handlePhysicalButtonEvent:(id)arg1 ;
- (void)_simulateHomeButtonPress;
- (void)_simulateLockButtonPress;
@end

@interface AVSystemController
+ (id)sharedAVSystemController;
- (BOOL)getActiveCategoryVolume:(float *)volume andName:(id *)name;
- (BOOL)setActiveCategoryVolumeTo:(float)to;
@end