//
//  UIAlertController+CK.swift
//  ORHP-Toolbox
//
//  Created by Corey Klass on 9/3/16.
//  Copyright © 2016 Corey Klass. All rights reserved.
//

import Foundation
import UIKit


extension UIAlertController {
    
    
    static func promptWithTitle(_ title: String?, message: String?, completionHandler: ((_ alertController: UIAlertController) -> Void)?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default) { (alertAction: UIAlertAction) in
            completionHandler?(alertController)
        }
        
        alertController.addAction(dismissAction)
        
        return alertController
    }
    
    
    
}



