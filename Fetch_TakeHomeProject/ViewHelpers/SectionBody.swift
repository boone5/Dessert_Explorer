//
//  SectionBody.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/21/23.
//

import SwiftUI

struct SectionBody: View {
    let text: String?

    var body: some View {
        Text(text ?? "")
            .font(.headline)
            .foregroundColor(Color(red: 53/255, green: 53/255, blue: 53/255))
    }
}

struct DetailHeading_Previews: PreviewProvider {
    static var previews: some View {
        SectionBody(text: "Heading")
    }
}
