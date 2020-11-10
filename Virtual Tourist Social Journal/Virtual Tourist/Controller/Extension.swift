//
//  Extension.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    public static let MKAnnotationDidSelect = NSNotification.Name("MKAnnotationDidSelect")
}

extension String {

    func toNSError(in domain: String) -> NSError {
        return NSError(domain: domain, code: 1, userInfo: [NSLocalizedDescriptionKey : self])
    }
    
    var sqlExactlyEqual: String {
        return self + " == %@"
    }
}
