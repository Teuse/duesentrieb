import SwiftUI

struct ReposSettingsView: View {
    @ObservedObject var viewModel: GithubViewModel
    
    @State private var org = ""
    @State private var repo = ""
    
    var canAddRepo: Bool { !org.isEmpty && !repo.isEmpty }
    
    func addRepoAction() {
        guard canAddRepo else { return }
        let path = RepositoryPath(org: org, repo: repo)
        viewModel.checkRepo(repoPath: path) { ok in
            if ok {
                viewModel.addRepo(repoPath: path)
            }
        }
    }
    
    func deleteRepoAction(repoPath: RepositoryPath) {
        viewModel.deleteRepo(repoPath: repoPath)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            addRepo
            
            if viewModel.requestState == .error {
                Spacer().frame(height: 4)
                HStack {
                Text("Failed to add Repository.")
                    .foregroundColor(Color.red)
                    Spacer()
                }
            }
            
            Spacer().frame(height: 10)
            
            GeometryReader { geometry in
                ScrollView {
                    repoList
                    Rectangle() // Fix a bug in ScrollView
                        .frame(width: geometry.size.width, height: 0.01)
                }
            }
        }
    }
    
    var repoList: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.reposViewModel) { repoViewModel in
                row(repoViewModel: repoViewModel)
                
                if repoViewModel.uuid != viewModel.reposViewModel.last?.uuid {
                    Rectangle().fill(Color.black).frame(height: 1).opacity(0.7)
                }
            }
        }
    }
    
    var addRepo: some View {
        HStack {
            TextField("org", text: $org)
            TextField("repo", text: $repo)
            
            Spacer().frame(width: 50)
            
            if viewModel.requestState == .requesting {
                ActivityIndicator()
                    .frame(width: 100, height: 20)
            }
            else {
                LargeButton(text: "Add Repo", disabled: !canAddRepo, action: addRepoAction)
                    .frame(width: 100)
            }
        }
    }
    
    func row(repoViewModel: RepositoryViewModel) -> some View {
        HStack {
            Spacer().frame(width: 12)
            if repoViewModel.requestState == .error {
                Text("⚠️")
            }
            Text(repoViewModel.repoPath.pathString)
            Spacer()
            
            Button(action: { deleteRepoAction(repoPath: repoViewModel.repoPath) }) {
                Image("DustbinIcon")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(height: 14)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing)
            
        }
        .frame(height: 22)
    }
}
