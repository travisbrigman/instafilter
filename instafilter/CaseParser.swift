//
//  CaseParser.swift
//  instafilter
//
//  Created by Travis Brigman on 2/25/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import Foundation

extension String {
    func titleCase() -> String {
        return self
            .replacingOccurrences(of: "([A-Z])",
                                  with: " $1",
                                  options: .regularExpression,
                                  range: range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized // If input is in llamaCase
    }
}
