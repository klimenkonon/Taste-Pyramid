//
//  LogoView.swift
//  
//
//  Created by Danylo Klymenko on 20.08.2024.
//

import SwiftUI

struct LogoView: View {
    
    var width: CGFloat
    var height: CGFloat
    
    
    var body: some View {
        Image("logo")
            .resizable()
            .frame(width: width, height: height)
    }
}

//#Preview {
//    LogoView()
//}
