//
//  SectionTitle.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/21/23.
//

import SwiftUI

struct SectionTitle: View {
    let text: String?

    var body: some View {
        Text(text ?? "")
            .font(.title2.weight(.bold))
            .foregroundColor(.black)
    }
}

struct SectionTitle_Previews: PreviewProvider {
    static var previews: some View {
        SectionTitle(text: "Title")
    }
}
