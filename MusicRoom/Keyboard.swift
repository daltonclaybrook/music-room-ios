//
//  Copyright (c) 2016 Dalton Claybrook
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

extension UIViewAnimationCurve {
    
    var animationOptions: UIViewAnimationOptions {
        switch self {
        case .easeIn:
            return .curveEaseIn
        case .easeOut:
            return .curveEaseOut
        case .easeInOut:
            return .curveEaseInOut
        case .linear:
            return .curveLinear
        }
    }
}

struct Keyboard {
    
    enum KeyboardError: Error {
        case invalidNotification // Notification was not valid. Must use the notification instance obtained from one of the keyboard notifications.
    }
    
    let startingFrame: CGRect
    let endingFrame: CGRect
    let animationDuration: TimeInterval
    let animationCurve: UIViewAnimationCurve
    
    init(notification: Notification) throws {
        guard let endingFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let startingFrame = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let animationDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
            let animationCurveInt = (notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue,
            let animationCurve = UIViewAnimationCurve(rawValue: Int(animationCurveInt))
            else {
                throw KeyboardError.invalidNotification
        }
        
        self.startingFrame = startingFrame
        self.endingFrame = endingFrame
        self.animationDuration = TimeInterval(animationDuration)
        self.animationCurve = animationCurve
    }
    
    //MARK: Public
    
    func animate(with animationBlock: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: animationCurve.animationOptions, animations: animationBlock, completion: completion)
    }
}
