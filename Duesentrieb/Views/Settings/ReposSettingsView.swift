import SwiftUI

struct ReposSettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    @State private var org = ""
    @State private var repo = ""
    
    var canAddRepo: Bool { org.isEmpty || repo.isEmpty }
    
    func addRepoAction() {
        viewModel.addRepository(org: org, repo: repo)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Manage Repositories").font(.headline).padding([.leading, .trailing])
            Rectangle().fill(Color.black).frame(height: 1).padding([.leading, .trailing])
            
            HStack(spacing: 5) {
                repoList.padding(.top, 5)
                
                addRepo
                    .frame(width: 100)
                    .padding(.bottom)
            }.padding([.leading, .trailing])
        }
    }
    
    var repoList: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.repoPaths, id: \.uuid) { repoPath in
                        row(repo: repoPath)
                        //                Text(repoPath.pathString)
                        
                        if repoPath.uuid != viewModel.repoPaths.last?.uuid {
                            Rectangle().fill(Color.black).frame(height: 1).opacity(0.7)
                        }
                    }
                }
                
                Rectangle() // Fix a bug in ScrollView
                    .frame(width: geometry.size.width, height: 0.01)
            }
        }
    }
    
    var addRepo: some View {
        VStack(spacing: 5) {
            Spacer()
            TextField("org", text: $org)
            TextField("repo", text: $repo)
            Spacer()
            LargeButton(text: "Add Repo", disabled: canAddRepo, action: addRepoAction)
        }
    }
    
    func row(repo: RepositoryPath) -> some View {
        HStack {
            Text(repo.pathString)
            Spacer()
            
            Button(action: { viewModel.deleteRepository(repoPath: repo) }) {
                Image("DustbinIcon")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(height: 14)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing)
            
        }
        .frame(height: 18)
    }
}
