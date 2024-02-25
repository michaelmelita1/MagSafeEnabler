/* MagSafe Enabler - enables new native MagSafe charging view when connecting device to power source on iOS 14.1 and above on iOS/iPadOS
 * (c) Copyright 2020-2022 Tomasz Poliszuk
 *
 * MagSafe Enabler is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3 of the License.
 *
 * MagSafe Enabler is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with MagSafe Enabler. If not, see <https://www.gnu.org/licenses/>.
 */
#import <UIKit/UIKit.h>

@interface SBFTouchPassThroughView : UIView
@end
@interface CSCoverSheetViewBase : SBFTouchPassThroughView
@end
@interface CSBatteryChargingView : CSCoverSheetViewBase
@end
@interface CSBatteryChargingRingView : CSBatteryChargingView
@property (nonatomic, retain) CALayer *chargingBoltGlyph;
@end
@interface CSPowerChangeObserver : NSObject
@property (nonatomic) bool isConnectedToWirelessInternalCharger;
@end

%hook CSPowerChangeObserver
- (void)update {
	%orig;
	[self setIsConnectedToWirelessInternalCharger:YES];
}
%end


%hook CSLockScreenChargingSettings
- (long long)wirelessChargingAnimationType {
	return 1;
}
- (void)setWirelessChargingAnimationType:(long long)arg1 {
	%orig(1);
}
%end

%hook CSAccessoryConfiguration
- (CGSize)boltSize {
	CGSize size = %orig;
	if ( [UIScreen mainScreen].bounds.size.width < 321 ) {
		size.width = 72;
		size.height = 108;
	} else {
		size.width = 84;
		size.height = 124;
	}
	return size;
}
- (double)ringDiameter {
	if ( [UIScreen mainScreen].bounds.size.width < 321 ) {
		return 256;
	}
	return 300;
}
- (double)splashRingDiameter {
	if ( [UIScreen mainScreen].bounds.size.width < 321 ) {
		return 598;
	}
	return 700;
}
- (double)staticViewRingDiameter {
	if ( [UIScreen mainScreen].bounds.size.width < 321 ) {
		return 598;
	}
	return 700;
}
- (double)lineWidth {
	if ( [UIScreen mainScreen].bounds.size.width < 321 ) {
		return 20;
	}
	return 24;
}
%end

%hook CSMagSafeRingConfiguration
- (double)ringDiameter {
	if ( [UIScreen mainScreen].bounds.size.width < 321 ) {
		return 256;
	}
	return 300;
}
- (double)splashRingDiameter {
	if ( [UIScreen mainScreen].bounds.size.width < 321 ) {
		return 598;
	}
	return 700;
}
- (double)staticViewRingDiameter {
	if ( [UIScreen mainScreen].bounds.size.width < 321 ) {
		return 598;
	}
	return 700;
}
- (double)lineWidth {
	if ( [UIScreen mainScreen].bounds.size.width < 321 ) {
		return 20;
	}
	return 24;
}
%end

%hook CSBatteryChargingRingView
- (CALayer *)chargingBoltGlyph {
	CALayer *origValue = %orig;
	CGRect newBoltFrame = origValue.frame;
	if ( [UIScreen mainScreen].bounds.size.width < 321 ) {
		newBoltFrame.size.width = 72;
		newBoltFrame.size.height = 108;
	} else {
		newBoltFrame.size.width = 84;
		newBoltFrame.size.height = 124;
	}
	origValue.frame = newBoltFrame;
	return origValue;
}
- (void)_layoutChargePercentLabel {
	[self chargingBoltGlyph];
	%orig;
}
%end
