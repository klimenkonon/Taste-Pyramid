//
//  SwiftUIView.swift
//  
//
//  Created by Danylo Klymenko on 26.08.2024.
//

import SwiftUI

struct TimeSelectionView: View {
    @Binding var selectedTime: Date
    @Binding var isClosed: Bool
        
        var body: some View {
            let now = Date()
            let calendar = Calendar.current
            
            let openingTime = calendar.date(bySettingHour: 8, minute: 0, second: 0, of: now)!
            let closingTime = calendar.date(bySettingHour: 21, minute: 45, second: 0, of: now)!
            let minimumTime = calendar.date(byAdding: .minute, value: 15, to: now)!
           // let isClosed = now < openingTime || minimumTime > closingTime
            
            VStack {
                if isClosed {
                    Text("Caffee is Closed")
                        .font(.headline)
                        .foregroundColor(.red)
                } else {
                    DatePicker("Select Time", selection: $selectedTime, in: minimumTime...closingTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .tint(.yellow)
                        .colorMultiply(.yellow)
                        .environment(\.colorScheme, .dark)
                }
            }
            .onAppear {
                if selectedTime < minimumTime {
                    selectedTime = minimumTime
                }
                
                isClosed = now < openingTime || minimumTime > closingTime
            }
            .padding()
        }
    }


#Preview {
    TimeSelectionView(selectedTime: .constant(Date()), isClosed: .constant(true))
}
