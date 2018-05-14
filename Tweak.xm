#import <Cephei/HBPreferences.h>

// Preferences related items.
BOOL isEnabled = YES;

static NSString *const kPreferencesDomain = @"io.github.spotlighishere.internallock6";
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

%hook NSBundle
-(NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
	if (isEnabled) {
		if ([tableName isEqual: @"SpringBoard-Internal"] && [value isEqual: @""]) {
			if ([key isEqual: @"INTERNAL_INSTALL_LEGAL_DECLARATION"]) {
				return INTERNAL_INSTALL_LEGAL_DECLARATION;
			} else if ([key isEqual: @"INTERNAL_INSTALL_LEGAL_INSTRUCTIONS"]) {
				return INTERNAL_INSTALL_LEGAL_INSTRUCTIONS;
			} else if ([key isEqual: @"INTERNAL_INSTALL_LEGAL_CONTACT"]) {
				return INTERNAL_INSTALL_LEGAL_CONTACT;
			}
		}
	}
	return %orig;
}
%end
