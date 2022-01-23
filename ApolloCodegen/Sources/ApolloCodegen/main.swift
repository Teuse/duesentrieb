import Foundation
import ApolloCodegenLib
import ArgumentParser

struct SwiftScript: ParsableCommand {

    //NOTE: Environment Variable "GITHUB_TOKEN" must be set
    static let subfolder = "Duesentrieb/Github/Apollo"
    static let endpoint = URL(string: "https://git.daimler.com/api/graphql")!
    
    // -----------------------------------------------
    
    static var configuration = CommandConfiguration(
            abstract: """
        A swift-based utility for performing Apollo-relatgithubTokened tasks.
        
        NOTE: If running from a compiled binary, prefix subcommands with `swift-script`. Otherwise use `swift run ApolloCodegen [subcommand]`.
        """,
            subcommands: [DownloadSchema.self, GenerateCode.self, DownloadSchemaAndGenerateCode.self])
    
    /// The sub-command to download a schema from a provided endpoint.
    struct DownloadSchema: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "downloadSchema",
            abstract: "Downloads the schema with the settings you've set up in the `DownloadSchema` command in `main.swift`.")
        
        func run() throws {
            let fileStructure = try FileStructure()
            CodegenLogger.log("File structure: \(fileStructure)")

            let folderForDownloadedSchema = fileStructure.sourceRootURL
                .apollo.childFolderURL(folderName: subfolder)
            
            try FileManager.default.apollo.createFolderIfNeeded(at: folderForDownloadedSchema)
            
            guard let githubToken = ProcessInfo.processInfo.environment["GITHUB_TOKEN"] else {
                return CodegenLogger.log("Environment Variable \"GITHUB_TOKEN\" not set.", logLevel: .error)
            }
            let authHeader = ApolloSchemaDownloadConfiguration.HTTPHeader(key: "Authorization", value: "token \(githubToken)")
            
            // https://www.apollographql.com/docs/ios/api/ApolloCodegenLib/structs/ApolloSchemaDownloadConfiguration/
            let schemaDownloadOptions = ApolloSchemaDownloadConfiguration(using: .introspection(endpointURL: endpoint),
                                                                          timeout: 30.0,
                                                                          headers: [authHeader],
                                                                          outputFolderURL: folderForDownloadedSchema)
            try ApolloSchemaDownloader.fetch(with: schemaDownloadOptions)
        }
    }
    
    /// The sub-command to actually generate code.
    struct GenerateCode: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "generate",
            abstract: "Generates swift code from your schema + your operations based on information set up in the `GenerateCode` command.")
        
        func run() throws {
            let fileStructure = try FileStructure()
            CodegenLogger.log("File structure: \(fileStructure)")

            let targetRootURL = fileStructure.sourceRootURL
                .apollo.childFolderURL(folderName: subfolder)
            
            try FileManager.default.apollo.createFolderIfNeeded(at: targetRootURL)

            // https://www.apollographql.com/docs/ios/api/ApolloCodegenLib/structs/ApolloCodegenOptions/
            let codegenOptions = ApolloCodegenOptions(targetRootURL: targetRootURL)
            
            try ApolloCodegen.run(from: targetRootURL, with: fileStructure.cliFolderURL, options: codegenOptions)
        }
    }

    /// A sub-command which lets you download the schema then generate swift code.
    ///
    /// NOTE: This will both take significantly longer than code generation alone and fail when you're offline, so this is not recommended for use in a Run Phase Build script that runs with every build of your project.
    struct DownloadSchemaAndGenerateCode: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "all",
            abstract: "Downloads the schema and generates swift code. NOTE: Not recommended for use as part of a Run Phase Build Script.")

        func run() throws {
            try DownloadSchema().run()
            try GenerateCode().run()
        }
    }
}

// This will set up the command and parse the arguments when this executable is run.
SwiftScript.main()
