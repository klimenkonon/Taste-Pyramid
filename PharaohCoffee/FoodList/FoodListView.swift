//
//  FoodListView.swift
//  PharaohCoffee
//
//  Created by Danylo Klymenko on 22.08.2024.
//

import SwiftUI

struct FoodListView: View {
    
    init(completion: @escaping () -> ()) {
        UISegmentedControl.appearance().backgroundColor = .white
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.black.opacity(0.7))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        self.completion = completion
    }
    
    
    @State private var selectedTab = "HOT"
    var tabs = ["HOT", "ICED", "FOOD", "COFFEE"]
    var completion: () -> ()
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    HStack {
                        Text("FOOD LIST")
                            .foregroundStyle(Color.semiYellow)
                            .font(.system(size: 34, weight: .heavy, design: .serif))
                            
                        Spacer()
                    }
                    .padding(.horizontal, 40)
                    
                    Picker("", selection: $selectedTab) {
                        ForEach(tabs, id: \.self) {
                            Text($0)
                        }
                    }
                    .colorMultiply(.yellow)
                    .pickerStyle(.segmented)
                    .padding(.horizontal,40)
                    
                    
                    VStack {
                        switch selectedTab {
                        case "HOT": ProductScrollView(type: .hot) { completion() }                           
                        case "ICED": ProductScrollView(type: .iced) { completion() }
                        case "FOOD": ProductScrollView(type: .food) { completion() }
                        case "COFFEE": ProductScrollView(type: .coffee) { completion() }
                        default:
                            ProductScrollView(type: .hot) {}
                        }
                    }
                    .padding(.top)
                }
            }
        }
    }
}

#Preview {
    FoodListView() {}
}
