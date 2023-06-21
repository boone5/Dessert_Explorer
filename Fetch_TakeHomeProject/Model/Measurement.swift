//
//  Measurement.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/19/23.
//

import Foundation.NSUUID

struct Measurement: Identifiable, Equatable {
    let id = UUID()
    let name: String
}
