//
//  String+Extensions.swift
//
//  Created by Igor Malyarov on 15.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

public extension String {
    func removingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }

    func removingSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else { return self }
        return String(dropLast(suffix.count))
    }

    func appendingSuffixIfNeeded(_ suffix: String) -> String {
        guard !hasSuffix(suffix) else { return self }
        return appending(suffix)
    }
}

public extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }
}
