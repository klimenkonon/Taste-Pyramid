//
//  RegistrationView.swift
//  
//
//  Created by Danylo Klymenko on 07.08.2024.
//



import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var fullname = ""
    @State private var confirmPassword = ""
    
    @State private var isAlertShown = false
    @State private var isNotificationShown = false
    @State private var switcher = true
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            ScrollView {
                VStack {
                    Image("registration")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 100)
                        .padding(.top, 22)
                    
                    VStack(spacing: 24) {
                        InputView(text: $email,
                                  title: "Email",
                                  placeholder: "email@example.com")
                        .textInputAutocapitalization(.never)
                        
                        InputView(text: $fullname,
                                  title: "Full name",
                                  placeholder: "Enter name")
                        
                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Enter password",
                                  isSecure: true)
                        .textInputAutocapitalization(.never)
                        
                        InputView(text: $confirmPassword,
                                  title: "Confirm password",
                                  placeholder: "Confirm password",
                                  isSecure: true)
                        .textInputAutocapitalization(.never)
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    Button {
                        if isFormValid {
                            viewModel.fullName = fullname
                            viewModel.email = email
                            Task {
                                try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                            }
                            withAnimation {
                                isAlertShown.toggle()
                            }
                        } else {
                            isNotificationShown.toggle()
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(LinearGradient(colors: [.darkYellow, .semiYellow], startPoint: .bottom, endPoint: .top))
                                .frame(width: getScreenSize().width - 40, height: 90)
                                .cornerRadius(12)
                            
                            Text("SIGN UP")
                                .foregroundStyle(.black)
                                .font(.system(size: 34, weight: .heavy, design: .serif))
                        }
                    }
                    .padding(.top, 40)
                    .alert("Incorrect Data Entered", isPresented: $isNotificationShown) {
                        Button {
                            isNotificationShown.toggle()
                        } label: {
                            Text("Ok")
                        }
                    } message: {
                        Text("Please enter valid information. \nEmail: Must include «‎@» and end with a valid domain, such as «‎.com». \nPassword: Must be longer than 6 characters.")
                    }

                    
                    Button {
                        dismiss()
                    } label: {
                        Text("ALREADY HAVE AN ACCOUNT?")
                            .foregroundStyle(Color.semiYellow)
                            .font(.system(size: 16, weight: .light, design: .serif))
                            .frame(width: 300)
                    }
                    .padding(.top, 40)
                    
                    

                }
                .padding(.bottom, 100)
            }
            .scrollIndicators(.hidden)
        }
        .overlay {
            if isAlertShown {
                ProgressAlertView(text: "Incorrect data or a user with this email already exists.", switcher: $switcher) {
                    withAnimation {
                        isAlertShown = false
                        switcher = true
                        
                        email = ""
                        password = ""
                        fullname = ""
                        confirmPassword = ""
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        switcher = false
                    }
                }
            }
        }
    }
}

extension RegistrationView: AuthViewModelProtocol {
    var isFormValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
        
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView( viewModel: AuthViewModel())
    }
}
