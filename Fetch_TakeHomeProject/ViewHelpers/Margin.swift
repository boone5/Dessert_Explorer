//
//  Margin.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/21/23.
//

import Foundation

enum Margin {
    case top
    case leading
    case trailing

    var value: CGFloat {
        switch self {
        case .top:
            return 10
        case .leading:
            return 20
        case .trailing:
            return 20
        }
    }
}
