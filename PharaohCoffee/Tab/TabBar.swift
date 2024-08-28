import SwiftUI

struct TabBarView: View {
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State private var isTabBarShown = true
    @State private var activeTab: Tab = .home
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                TabView(selection: $activeTab) {
                    MainView()
                        .tag(Tab.home)
                    
                    FoodListView() {
                        isTabBarShown.toggle()
                    }
                    .tag(Tab.food)
                    
                    QRView()
                        .tag(Tab.qr)
                    
                    FavouriteView()
                        .tag(Tab.favourite)
                    
                    ProfileView()
                        .environmentObject(authViewModel)
                        .tag(Tab.profile)
                }
                
                if isTabBarShown {
                    VStack(spacing: 0) {
                        Spacer()
                        CustomTabBar(activeTab: $activeTab)
                    }
                    .ignoresSafeArea(.all, edges: .bottom)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .onAppear {
                DataManager.shared.createInitial()
            }
        }
        
    }
}


#Preview {
    TabBarView()
        .environmentObject(AuthViewModel())
}
