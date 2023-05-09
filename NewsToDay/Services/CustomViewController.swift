//
//  CustomViewController.swift
//  NewsToDay
//
//  Created by Sergey on 09.05.2023.
//

import Foundation
import UIKit

class CustomViewController<V: CustomView>: UIViewController {
    
    override func loadView() {
        view = V()
    }
    
    var customView: V {
        view as! V
    }
}
