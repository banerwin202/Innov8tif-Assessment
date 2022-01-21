//
//  Timer.swift
//  Innov8tif Assignment
//
//  Created by Ban Er Win on 21/01/2022.
//

import Foundation
import UIKit

class TimerCountdown {
   class func timer(time: Int, vc: UIViewController, selector: Selector) {
       CircularSpinner.show()
      Timer.scheduledTimer(timeInterval: TimeInterval(time), target: vc, selector: selector, userInfo: nil, repeats: false)

    }

}





