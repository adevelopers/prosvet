//
//  String.swift
//  Prosvet
//
//  Created by adeveloper on 22.04.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

// example: "Back".localized
