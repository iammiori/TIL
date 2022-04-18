//
//  UIViewController.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/04/02.
//

import Foundation
import UIKit

extension UIViewController {
    var sceneViewController : UIViewController {
        return self.children.last ?? self
    }
}
