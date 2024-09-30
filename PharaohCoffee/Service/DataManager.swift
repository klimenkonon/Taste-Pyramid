//
//  DataManager.swift
//  
//
//  Created by Danylo Klymenko on 25.08.2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

class DataManager {
    static let shared = DataManager()
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    private init(){}
    
    func createInitial() {
        if !UserDefaults.standard.bool(forKey: "init") {
            UserDefaults.standard.setValue(true, forKey: "init")
            
            UserDefaults.standard.setValue(generateCode(), forKey: "code")
        }
    }
    
    func generateCode() -> String {
        var numbers = ""
        for _ in 0..<4 {
            let number = Int.random(in: 0...99)
            numbers += String(format: "%02d", number) + " "
        }
        numbers.removeLast()
        return numbers
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data("http://bookOfDelightRa.com/order/\(string)".utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
