source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

def shared_pods
    # Networking
    pod 'RestKit', '~> 0.27.0'
    pod 'ReachabilitySwift', '~> 2.3.3' #, :git => 'https://github.com/ashleymills/Reachability.swift'

    # DAL Helper
    pod 'MagicalRecord', '~> 2.3'

    # Dependency Injection
    pod 'Swinject', '~> 1.1'

    # UI
    pod 'Eureka', '~> 1.7.0' # Forms
    pod 'SwiftValidator', '~> 3.0' # Form Validation
    pod 'CWStatusBarNotification', '~> 2.3' # Nav Bar notifications
    pod 'SVProgressHUD', '~> 2.0' # Progress HUD
    pod 'SnapKit', '~> 0.22' # Auto Layout in Code
    pod 'NSDate+TimeAgo', '~> 1.0.6' # Time format (x mins ago)
    pod 'Kanna', '~> 1.1.0' # Show preview of a url (XML/HTML Parser)
    pod 'Koloda', :git => 'https://github.com/petalvlad/Koloda' # Cards swiping
    pod 'UIActivityIndicator-for-SDWebImage', :git => 'https://github.com/masterfego/UIActivityIndicator-for-SDWebImage' # Downloading images
    pod 'SlackTextViewController', '~> 1.9.4' # Expandable UITextView
    pod 'ActionSheetPicker-3.0', '~> 2.1.0' # Custom Action Sheet Based Pickers

    pod 'SwiftCharts', :git => 'https://github.com/wsdwsd0829/SwiftCharts.git'

    pod 'TPKeyboardAvoiding', '~> 1.3' # Adjust scrollview when keyboard comes up
    pod 'FDTake', '~> 0.3.3' # Choose photo
    pod 'TTTAttributedLabel', '~> 2.0.0' # Label with hyperlinks
    pod 'VideoSplashKit', :git => 'https://github.com/petalvlad/VideoSplashKit'
    pod 'KAProgressLabel', '~> 3.3.0' # Circular progress
    pod 'JTSImageViewController', '~> 1.5.1' # Open images in fullscreen

    pod 'YBTopAlignedCollectionViewFlowLayout', :git => 'https://github.com/benski/TopAlignedCollectionViewLayout'  # UICollectionView cells with dynamic heights will be aligned at the top
    pod 'AMScrollingNavbar', '~> 2.1.2' #create auto-scrolling navigation bars!

    # Crashlytics & Dev Release
    pod 'Fabric', '~> 1.6.8'
    pod 'Crashlytics', '~> 3.7.3'

    # Twitter Integration
    pod 'TwitterKit', '~> 2.3.0'
    pod 'TwitterCore', '~> 2.3.0'

    # FB Integration
pod 'FBSDKCoreKit'
    pod 'FBSDKLoginKit', '~> 4.14.0'
    pod 'FBSDKShareKit'

    # Utils
    pod 'SwiftDate', '~> 3.0.8'
    pod 'PromiseKit', '~> 3.5.0' # Promises
    pod 'Locksmith', '~> 2.0' # KeyChain Access
    pod 'DeviceKit', '~> 0.3'

    # DEBUGGING
    # pod 'GDCoreDataConcurrencyDebugging', :git => 'https://github.com/balazsnemeth/GDCoreDataConcurrencyDebugging.git'

    # Location
    # pod 'GooglePlacePicker', '~> 2.0.1'

    # Analytics Flurry & Mixpanel
    # pod 'Mixpanel', '~> 3.0.2'
    # pod 'Flurry-iOS-SDK/FlurrySDK', '~> 7.6.6'
    pod 'Analytics', '~> 3.0'
    # pod 'Segment-Mixpanel', '~> 1.1.0'
    pod 'CleverTap-iOS-SDK', '~> 2.2'

end

target 'GooglePlace' do
    shared_pods
end

target 'GooglePlaceTests' do
    shared_pods
end
