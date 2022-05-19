//
//  ReusableIdentifier.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 19.05.22.
//

import Foundation

protocol ReusableIdentifier {
    static var reusableId: String { get }
}

extension ReusableIdentifier {
    static var reusableId: String {
        return String(describing: self)
    }
}
