#import <Cephei/HBPreferences.h>

// The following functions are used with MSHookMessageEx and its beautiful method swizzling.
BOOL (*old_isInternalInstall)(id self, SEL _cmd);
BOOL new_isInternalInstall(id self, SEL _cmd) {
	// Yes, we're totally 100% an internal install.
	return true;
};

void (*old_setHidden)(id self, SEL _cmd);
void new_setHidden(id self, SEL _cmd) {
	// Do nothing, whatsoever.
};

// Preferences related items.
BOOL isEnabled = YES;

static NSString *const kPreferencesDomain = @"io.github.awesomebing1.internallock";
static NSString *const kPreferencesEnabledKey = @"isEnabled";
static NSString *const kPreferencesDeclarationKey = @"internalDeclaration";
static NSString *const kPreferencesInstructionsKey = @"internalInstructions";
static NSString *const kPreferencesContactKey = @"internalContact";
NSString *INTERNAL_INSTALL_LEGAL_DECLARATION = @"Hello";
NSString *INTERNAL_INSTALL_LEGAL_INSTRUCTIONS = @"configure me";
NSString *INTERNAL_INSTALL_LEGAL_CONTACT = @"in settings!";

HBPreferences *preferences;

%ctor {
	preferences = [[HBPreferences alloc] initWithIdentifier:kPreferencesDomain];

	// Set up defaults
	[preferences registerBool:&isEnabled default:YES forKey:kPreferencesEnabledKey];
	[preferences registerObject:&INTERNAL_INSTALL_LEGAL_DECLARATION default:@"Hello," forKey:kPreferencesDeclarationKey];
	[preferences registerObject:&INTERNAL_INSTALL_LEGAL_INSTRUCTIONS default:@"configure me" forKey:kPreferencesInstructionsKey];
	[preferences registerObject:&INTERNAL_INSTALL_LEGAL_CONTACT default:@"in settings!" forKey:kPreferencesContactKey];
}

// Now, we'll change the actual strings.

%hook SBLockScreenStatusTextViewController

// Normal format: @"%@ (1), %@ (2) %@ (3)"
// 1: INTERNAL_INSTALL_LEGAL_DECLARATION
// 2: INTERNAL_INSTALL_LEGAL_INSTRUCTIONS
// 3: INTERNAL_INSTALL_LEGAL_CONTACT

-(void)updateTextView {
	// Make it seem as if this is an internal install
	// only for this instance.
	MSHookMessageEx(
    objc_getClass("SBPlatformController"), @selector(isInternalInstall),
    (IMP) new_isInternalInstall, (IMP*)old_isInternalInstall
  );

	// Don't get rid of me 2.0™
	MSHookMessageEx(
		objc_getClass("UITextView"), @selector(setHidden),
		(IMP) new_setHidden, (IMP*)old_setHidden
	);
	%orig;
}

-(id)_legalString {
	if (isEnabled) {
		// Remove comma
  	return [NSString stringWithFormat:@"%@ %@ %@", INTERNAL_INSTALL_LEGAL_DECLARATION, INTERNAL_INSTALL_LEGAL_INSTRUCTIONS, INTERNAL_INSTALL_LEGAL_CONTACT];
	} else {
		return @"";
	}
}

%end
