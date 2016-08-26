//
//  GeneralExtensions.swift
//  WHH
//
//  Created by Andras on 25/04/16.
//  Copyright © 2016 Wanda. All rights reserved.
//

import SwiftDate
import Darwin


// MARK: - String Extensions

// MARK: String Localization
extension String {
    
    ///Helper: add html style metadata to string to parse, the size here is be used rather than attribute config panel
    func styledHTML() -> String {
        //HelveticaNeue ... b {font-family: 'MarkerFelt-Wide';}
        let style = "<meta charset=\"UTF-8\"><style> body { font-family: 'Helvetica'; font-size: 16px;} b { font-family: 'Helvetica'; }</style>";
        return String(format:"%@%@", style, self)
        
    }
    ///Helper: convert string to HTML version's AttributtedString
    func attributedString() -> NSAttributedString? {
        let options = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        let attributedString = try? NSAttributedString(data: data!, options: options, documentAttributes: nil)
        return attributedString
    }
    ///Helper: replace return characters to <br> for html 
    func returnToBrTag() -> String {
        return self.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()).joinWithSeparator("<br>")
    }
    
    ///to NSAttributtedString for textView.attributeText,  textView need delegate for shouldInteractWithURL & disable editable
    ///if use label: anchor will not work
    func attributedHtml() -> NSAttributedString? {
        let stringWithBr = returnToBrTag()
        let styledHtml = stringWithBr.styledHTML()
        return styledHtml.attributedString()
    }
    
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var URLValue: NSURL? {
        return NSURL(string: self)
    }
    
    func localizedStringFormatted(withArguments arguments: CVarArgType...) -> String{
        //http://stackoverflow.com/questions/29399882/swift-function-with-args-pass-to-another-function-with-args
        return String(format:NSLocalizedString(self, comment:""), arguments: arguments)
    }
    var doubleValue: Double {
        return Double(self) ?? 0
    }
    var justifiedAlignmentString: NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Justified
        
        let attributedString = NSAttributedString(string: self,
                                                  attributes: [
                                                    NSParagraphStyleAttributeName: paragraphStyle,
                                                    NSBaselineOffsetAttributeName: NSNumber(float: 0)
            ])
        return attributedString
    }
}

// MARK: - UIColor Extensions

// MARK: Color from hex code
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

// MARK: - NSData Extensions

// MARK: Convert to HexString (for push DeviceToken)
extension NSData {
    func hexString() -> String {
        // "Array" of all bytes:
        let bytes = UnsafeBufferPointer<UInt8>(start: UnsafePointer(self.bytes), count:self.length)
        // Array of hex strings, one for each byte:
        let hexBytes = bytes.map({ String(format: "%02hhx", $0) })
        // Concatenate all hex strings:
        return hexBytes.joinWithSeparator("")
    }
}

// MARK: - NSBundle Extensions

// MARK: Get Application version informations
extension NSBundle {
    
    var appVersionString: String { return "\(releaseVersionNumber) (build \(buildVersionNumber))" }
    
    var releaseVersionNumber: String {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?"
    }
    
    var buildVersionNumber: String {
        return self.infoDictionary?["CFBundleVersion"] as? String ?? "?"
    }
    
}

// MARK: - NSDate

// MARK: Acceptable ISO8601 Date Format

infix operator .. {}

func ..(startDate: NSDate, endDate: NSDate) -> [NSDate] {
    
    let startOfStartDate = startDate.startOf(.Day)
    let startOfEndDate = endDate.startOf(.Day)
    
    var dates = [startOfStartDate]
    var currentDate = startOfStartDate
    
    repeat {
        currentDate = currentDate.add(days: 1)
        dates.append(currentDate)
        
    } while currentDate < startOfEndDate
    
    return dates
}

extension NSDate {
    func toISO8601String() -> String? {
        return self.inRegion(Region.utcRegion).toString(DateFormat.ISO8601Format(.Full))
    }
    func toTimeString() -> String? {
        return self.inRegion(Region.utcRegion).toString(DateFormat.Custom("HH:mm"))
    }
    func toDateString() -> String? {
        let utcRegion = Region(calendarName: nil, timeZoneName: TimeZoneName.Gmt, localeName: nil)
        return self.inRegion(utcRegion).toString(DateFormat.ISO8601Format(.Date))
    }
}

extension Region {
    
    static var utcRegion:Region {
        return Region(calendarName: nil, timeZoneName: TimeZoneName.Gmt, localeName: nil)
    }
    
}

// MARK: - Dictionary

// MARK: Invert a dictionary (in case of same values the last one will be applied)

extension Dictionary where Value: Hashable {
    
    func invert() -> Dictionary<Value, Key> {
        var result = Dictionary<Value, Key>()
        for key in self.keys {
            if let value = self[key] {
                result[value] = key
            }
        }
        return result;
    }
}

// MARK: - UIView Extensions

/* Reusable view which can be designed in a standalone .xib but it can be embedded inside of larger views.
 
   Based on: http://www.maytro.com/2014/04/27/building-reusable-views-with-interface-builder-and-auto-layout.html
*/
class ReusableView: UIView {

    /// View which contains all the content of the reusable view
    @IBOutlet weak var view: UIView!

    /// Specify the name of the nib belonging to the view. By default the nib with same name as the class has will be looked for
    var nibName:String {
       return String(self.dynamicType)
    }
    
    /**
     Entry point for subclasses to customize the UI
     */
    func nibDidLoaded() {
        
    }
    
    func loadViewFromNib() -> UIView {
        
        let nib = UINib(nibName: nibName, bundle: nil)
        //Because we specify 'self' as owner, all of the defined IBOutlet, IBAction will work
        return  nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
    }
    
    /**
     Load the nib of the view and add it to the current instance
     */
    func setupViewFromNib() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Adding custom subview on top of our view
        addSubview(view)

        // Make the view stretch with containing view
        view.snp_makeConstraints { [unowned self] (make) -> Void in
            make.edges.equalTo(self)
        }
        
        nibDidLoaded()
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setupViewFromNib()
    }

}

// MARK: UITableViewCell
extension UITableViewCell {
    func updateClassIfNeeded(klass: AnyClass) -> Bool {

        if String(self.dynamicType) != String(klass) {
            object_setClass(self, klass)
            return true
        }
        return false
    }
}

// MARK: - UIStoryboardSegue Extensions
extension UIStoryboardSegue {
    var concreteDestinationViewController: UIViewController {
        return self.destinationViewController.concreteViewController
    }
    func tryGetDestinationViewController<T: UIViewController>() -> T? {
        if let destNavigationVC = self.destinationViewController as? UINavigationController {
            if let viewController = destNavigationVC.topViewController as? T {
                return viewController
            }
        }else if let viewController = self.destinationViewController as? T {
            return viewController
        }
        return nil
    }
}

// MARK: - UIViewController Extensions

extension UIViewController {
    var canPresentViewController: Bool {
        return self.presentedViewController == nil
    }
    
    var concreteViewController: UIViewController {
        if let navVC = self as? UINavigationController,
            let navRootVC = navVC.viewControllers.first {
            return navRootVC
        }
        return self
    }


    var topmostPresentedViewController: UIViewController {
        if let tabVC = self as? UITabBarController,
            let selectedVC = tabVC.selectedViewController {
            return selectedVC.topmostPresentedViewController
        } else if let navVC = self as? UINavigationController,
            let selectedVC = navVC.viewControllers.last {
            return selectedVC.topmostPresentedViewController
        } else if let presentedVC = self.presentedViewController {
            return presentedVC.topmostPresentedViewController
        } else {
            return self
        }
    }
}

//MARK: UINavigationController
extension UINavigationController {
    
    func makeTransparent() {
        // http://stackoverflow.com/questions/19082963/how-to-make-completely-transparent-navigation-bar-in-ios-7
        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.translucent = true
        self.view.backgroundColor = UIColor.clearColor()
        self.navigationBar.backgroundColor = UIColor.clearColor()
    }
    
    func revertTransparency() {
        navigationBar.translucent = false
        self.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
    }
    
    func addStatusbarBackground(withColor color: UIColor?) {
        let statusbarBackgroundView = UIView(frame: UIApplication.sharedApplication().statusBarFrame)
        statusbarBackgroundView.backgroundColor = color
        self.view.addSubview(statusbarBackgroundView)
    }
}

//MARK: Double
// Format a doble
extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    
}

//MARK: UITextField
extension UITextField {
        
    static func createAccessoryView(done doneAction: Selector, cancel cancelAction: Selector, target: AnyObject) -> (view:UIView, cancelButton: UIBarButtonItem, doneButton:UIBarButtonItem) {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.sizeToFit()
        
        let doneBarButton = UIBarButtonItem(title: "general.done".localizedString, style: UIBarButtonItemStyle.Done, target: target, action: doneAction)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "general.cancel".localizedString, style: UIBarButtonItemStyle.Done, target: target, action: cancelAction)
        
        toolBar.setItems([cancelBarButton, spaceButton, doneBarButton], animated: false)
        toolBar.userInteractionEnabled = true
        return (view:toolBar, cancelButton: cancelBarButton, doneButton: doneBarButton)
    }
    
}
//MARK: UIView
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(CGColor: self.layer.borderColor!) }
        set { self.layer.borderColor = newValue.CGColor }
    }
    
    func createSnapshotImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0)
        self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        let snapshotImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshotImage
    }
    
}

/*
 http://stackoverflow.com/questions/19108513/uistatusbarstyle-preferredstatusbarstyle-does-not-work-on-ios-7
 
 Transfer status bar preference color to actual viewcontroller
 */
extension UITabBarController {
    public override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return selectedViewController
    }
}

extension UINavigationController {
    public override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return visibleViewController
    }
}

extension UITableView{
    func configForAutoDynamicRowHeight(estimatedRowHeight estimatedRowHeight: CGFloat = 80.0, estimatedSectionHeaderHeight: CGFloat = 80.0){
        self.estimatedRowHeight = estimatedRowHeight
        self.rowHeight = UITableViewAutomaticDimension
        self.sectionHeaderHeight = UITableViewAutomaticDimension
        self.estimatedSectionHeaderHeight = estimatedSectionHeaderHeight
    }
}

extension SequenceType where Generator.Element: Hashable {
    var uniqueElements: [Generator.Element] {
        return Array(Set(self))
    }
}

extension SequenceType where Generator.Element: Equatable {
    var uniqueElements: [Generator.Element] {
        return self.reduce([]){uniqueElements, element in
            uniqueElements.contains(element)
                ? uniqueElements
                : uniqueElements + [element]
        }
    }
}

extension Array {
    public func groupBy<U: Hashable>(callback: (Element) -> U) -> [U: [Element]] {
        var grouped = [U: [Element]]()
        for element in self {
            let key = callback(element)
            if grouped[key] != nil {
                grouped[key]?.append(element)
            } else {
                grouped[key] = [element]
            }            
        }
        return grouped
    }
}


extension NSNull {
    
    //RestKit try to mapp NSNull to double (especially when mapping `image_info` to imageSize - feedItem), let them to do this
    func doubleValue() -> Double {
        return 0.0
    }
}

//MARK: UILabel Extensions
extension UILabel
{
    func appendImage(imageName: String)
    {
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        //http://stackoverflow.com/questions/26105803/center-nstextattachment-image-next-to-single-line-uilabel
        //center on y axis with text
        attachment.bounds = CGRectMake(0, self.font.descender, attachment.image!.size.width, attachment.image!.size.height)
        
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        let myString: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
        myString.appendAttributedString(attachmentString)
        
        self.attributedText = myString
    }
    ///replace all occurance or replaceText with image named imageName
    func addImage(named imageName: String, replaceText: String) {
        guard let components = self.text?.componentsSeparatedByString(replaceText) else { return }
        //create "image string"
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        attachment.bounds = CGRectMake(0, self.font.descender, attachment.image!.size.width, attachment.image!.size.height)
        let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
        
        let componentString: NSMutableAttributedString = NSMutableAttributedString(string: "")
        for component in components {
            let attributedComponent = NSAttributedString(string: component)
            componentString.appendAttributedString(attributedComponent)
            guard component != components.last else { break }
            componentString.appendAttributedString(attachmentString)
            
        }
        self.attributedText = componentString
    }
    
    func isTruncated() -> Bool {
        
        if let string = self.text {
            
            //Fix the width, but let the height being adjusted
            let fittingSize = CGSize(width: self.frame.size.width, height: CGFloat(FLT_MAX))
            
            //Compute the size of the full text
            let textSize = (string as NSString).boundingRectWithSize( fittingSize ,
                options:        NSStringDrawingOptions.UsesLineFragmentOrigin,
                attributes:     [NSFontAttributeName: self.font],
                context:        nil
            ).size
            
            //Compute the size of the label (important: set the numberOfRows properly)
            let maxLabelSize = self.sizeThatFits(CGSize(width: self.frame.size.width, height: 1000));
            
            if (textSize.height > maxLabelSize.height) {
                return true
            }
        }
        
        return false
    }
}

//MARK: UIBezierPath 
//http://stackoverflow.com/questions/13528898/how-can-i-draw-an-arrow-using-core-graphics/37985645#37985645
extension UIBezierPath {
    
    class func arrow(from start: CGPoint, to end: CGPoint, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat) -> Self {
        let length = hypot(end.x - start.x, end.y - start.y)
        let tailLength = length - headLength
        
        func p(x: CGFloat, _ y: CGFloat) -> CGPoint { return CGPoint(x: x, y: y) }
        var points: [CGPoint] = [
            p(0, tailWidth / 2),
            p(tailLength, tailWidth / 2),
            p(tailLength, headWidth / 2),
            p(length, 0),
            p(tailLength, -headWidth / 2),
            p(tailLength, -tailWidth / 2),
            p(0, -tailWidth / 2)
        ]
        
        let cosine = (end.x - start.x) / length
        let sine = (end.y - start.y) / length
        var transform = CGAffineTransform(a: cosine, b: sine, c: -sine, d: cosine, tx: start.x, ty: start.y)
        
        let path = CGPathCreateMutable()
        CGPathAddLines(path, &transform, &points, points.count)
        CGPathCloseSubpath(path)
        
        return self.init(CGPath: path)
    }
    
}

//MARK: UIApplication
extension UIApplication {
    class func sharedApplicationHasSendingNotificationsPermission() -> Bool {
        return UIApplication.sharedApplication().hasSendingNotificationsPermission()
    }
    
    func hasSendingNotificationsPermission() -> Bool {
        guard let settings = self.currentUserNotificationSettings() else { return false }
        return settings.types != .None
    }
}

//MARK: NSURL
extension NSURL
{
    @objc var queryDictionary:[String: [String]]? {
        get {
            if let query = self.query {
                var dictionary = [String: [String]]()
                
                for keyValueString in query.componentsSeparatedByString("&") {
                    var parts = keyValueString.componentsSeparatedByString("=")
                    if parts.count < 2 { continue; }
                    
                    let key = parts[0].stringByRemovingPercentEncoding!
                    let value = parts[1].stringByRemovingPercentEncoding!
                    
                    var values = dictionary[key] ?? [String]()
                    values.append(value)
                    dictionary[key] = values
                }
                
                return dictionary
            }
            return nil
        }
    }
}

