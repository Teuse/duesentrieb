# ApolloCodegen

The ApolloCodegen project downloads the GraphQL schema and generates Swift code.
A detailed description can be found here: https://www.apollographql.com/docs/ios/swift-scripting/

## Usage

### Github Token

The github token can be generated here...

### Download Schema
In terminal, cd into the ApolloCodegen folder and run
> export GITHUB_TOKEN=<your-github-token>
> swift run ApolloCodegen downloadSchema

### Generate Swift Code
You need to have .graphql files which contains queries, subscriptions or ??

In terminal, cd into the ApolloCodegen folder and run
> swift run ApolloCodegen generate
