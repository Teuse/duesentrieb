import SwiftUI

struct MainView: View {
    @EnvironmentObject private var rootState: RootState
    
    @State var page: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ViewPicker(selection: $page)
                    .padding(.trailing)
            }
            .padding()
            
            reposList
            
            Spacer()
        }
    }
    
    var reposList: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    
                    ForEach(rootState.gitStates, id: \.uuid) { gitState in
                        ForEach(gitState.repoStates, id: \.uuid) { repoState in
                            RepositoryView(repoState: repoState, page: self.page)
                        }
                    }
                    
                    Spacer()
                    Rectangle() // Fix a bug in ScrollView
                        .frame(width: geometry.size.width, height: 0.01)
                }
            }
        }
    }
}
