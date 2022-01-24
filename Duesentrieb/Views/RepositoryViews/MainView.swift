import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: GithubViewModel
    
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
                    
                    ForEach(viewModel.repoViewModels, id: \.uuid) {
                        RepositoryView(viewModel: $0, page: self.page)
                    }
                    
                    Spacer()
                    Rectangle() // Fix a bug in ScrollView
                        .frame(width: geometry.size.width, height: 0.01)
                }
            }
        }
    }
}
