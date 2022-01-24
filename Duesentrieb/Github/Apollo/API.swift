// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// Whether or not a PullRequest can be merged.
public enum MergeableState: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// The pull request can be merged.
  case mergeable
  /// The pull request cannot be merged due to merge conflicts.
  case conflicting
  /// The mergeability of the pull request is still being calculated.
  case unknown
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "MERGEABLE": self = .mergeable
      case "CONFLICTING": self = .conflicting
      case "UNKNOWN": self = .unknown
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .mergeable: return "MERGEABLE"
      case .conflicting: return "CONFLICTING"
      case .unknown: return "UNKNOWN"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: MergeableState, rhs: MergeableState) -> Bool {
    switch (lhs, rhs) {
      case (.mergeable, .mergeable): return true
      case (.conflicting, .conflicting): return true
      case (.unknown, .unknown): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [MergeableState] {
    return [
      .mergeable,
      .conflicting,
      .unknown,
    ]
  }
}

/// The review status of a pull request.
public enum PullRequestReviewDecision: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// Changes have been requested on the pull request.
  case changesRequested
  /// The pull request has received an approving review.
  case approved
  /// A review is required before the pull request can be merged.
  case reviewRequired
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "CHANGES_REQUESTED": self = .changesRequested
      case "APPROVED": self = .approved
      case "REVIEW_REQUIRED": self = .reviewRequired
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .changesRequested: return "CHANGES_REQUESTED"
      case .approved: return "APPROVED"
      case .reviewRequired: return "REVIEW_REQUIRED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: PullRequestReviewDecision, rhs: PullRequestReviewDecision) -> Bool {
    switch (lhs, rhs) {
      case (.changesRequested, .changesRequested): return true
      case (.approved, .approved): return true
      case (.reviewRequired, .reviewRequired): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [PullRequestReviewDecision] {
    return [
      .changesRequested,
      .approved,
      .reviewRequired,
    ]
  }
}

/// The possible states of a pull request review.
public enum PullRequestReviewState: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// A review that has not yet been submitted.
  case pending
  /// An informational review.
  case commented
  /// A review allowing the pull request to merge.
  case approved
  /// A review blocking the pull request from merging.
  case changesRequested
  /// A review that has been dismissed.
  case dismissed
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "PENDING": self = .pending
      case "COMMENTED": self = .commented
      case "APPROVED": self = .approved
      case "CHANGES_REQUESTED": self = .changesRequested
      case "DISMISSED": self = .dismissed
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .pending: return "PENDING"
      case .commented: return "COMMENTED"
      case .approved: return "APPROVED"
      case .changesRequested: return "CHANGES_REQUESTED"
      case .dismissed: return "DISMISSED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: PullRequestReviewState, rhs: PullRequestReviewState) -> Bool {
    switch (lhs, rhs) {
      case (.pending, .pending): return true
      case (.commented, .commented): return true
      case (.approved, .approved): return true
      case (.changesRequested, .changesRequested): return true
      case (.dismissed, .dismissed): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [PullRequestReviewState] {
    return [
      .pending,
      .commented,
      .approved,
      .changesRequested,
      .dismissed,
    ]
  }
}

public final class OrganizationsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Organizations($curser: String) {
      viewer {
        __typename
        organizations(first: 40, after: $curser) {
          __typename
          pageInfo {
            __typename
            endCursor
            hasNextPage
          }
          totalCount
          nodes {
            __typename
            repositories(first: 40) {
              __typename
              totalCount
              nodes {
                __typename
                name
                nameWithOwner
                pullRequests(first: 10, states: OPEN) {
                  __typename
                  totalCount
                  nodes {
                    __typename
                    id
                    url
                    title
                    author {
                      __typename
                      login
                      avatarUrl(size: 120)
                    }
                    comments {
                      __typename
                      totalCount
                    }
                    mergeable
                    reviewDecision
                    reviewRequests(first: 10) {
                      __typename
                      totalCount
                      nodes {
                        __typename
                        requestedReviewer {
                          __typename
                          ... on User {
                            __typename
                            id
                            login
                            name
                            email
                            avatarUrl
                          }
                        }
                      }
                    }
                    reviews(first: 20) {
                      __typename
                      totalCount
                      nodes {
                        __typename
                        state
                        createdAt
                        author {
                          __typename
                          login
                          avatarUrl
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "Organizations"

  public let operationIdentifier: String? = "1d96bc874b9210e9a628eccbcbd08632e9133cadb2b866a1608dac9ed44de2fb"

  public var curser: String?

  public init(curser: String? = nil) {
    self.curser = curser
  }

  public var variables: GraphQLMap? {
    return ["curser": curser]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("viewer", type: .nonNull(.object(Viewer.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(viewer: Viewer) {
      self.init(unsafeResultMap: ["__typename": "Query", "viewer": viewer.resultMap])
    }

    /// The currently authenticated user.
    public var viewer: Viewer {
      get {
        return Viewer(unsafeResultMap: resultMap["viewer"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("organizations", arguments: ["first": 40, "after": GraphQLVariable("curser")], type: .nonNull(.object(Organization.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(organizations: Organization) {
        self.init(unsafeResultMap: ["__typename": "User", "organizations": organizations.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of organizations the user belongs to.
      public var organizations: Organization {
        get {
          return Organization(unsafeResultMap: resultMap["organizations"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "organizations")
        }
      }

      public struct Organization: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["OrganizationConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
            GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(pageInfo: PageInfo, totalCount: Int, nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "OrganizationConnection", "pageInfo": pageInfo.resultMap, "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Information to aid in pagination.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
          }
        }

        /// Identifies the total count of items in the connection.
        public var totalCount: Int {
          get {
            return resultMap["totalCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "totalCount")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PageInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("endCursor", type: .scalar(String.self)),
              GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return resultMap["endCursor"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return resultMap["hasNextPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Organization"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("repositories", arguments: ["first": 40], type: .nonNull(.object(Repository.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(repositories: Repository) {
            self.init(unsafeResultMap: ["__typename": "Organization", "repositories": repositories.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of repositories that the user owns.
          public var repositories: Repository {
            get {
              return Repository(unsafeResultMap: resultMap["repositories"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "repositories")
            }
          }

          public struct Repository: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["RepositoryConnection"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                GraphQLField("nodes", type: .list(.object(Node.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(totalCount: Int, nodes: [Node?]? = nil) {
              self.init(unsafeResultMap: ["__typename": "RepositoryConnection", "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Identifies the total count of items in the connection.
            public var totalCount: Int {
              get {
                return resultMap["totalCount"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "totalCount")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Repository"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .nonNull(.scalar(String.self))),
                  GraphQLField("nameWithOwner", type: .nonNull(.scalar(String.self))),
                  GraphQLField("pullRequests", arguments: ["first": 10, "states": "OPEN"], type: .nonNull(.object(PullRequest.selections))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(name: String, nameWithOwner: String, pullRequests: PullRequest) {
                self.init(unsafeResultMap: ["__typename": "Repository", "name": name, "nameWithOwner": nameWithOwner, "pullRequests": pullRequests.resultMap])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The name of the repository.
              public var name: String {
                get {
                  return resultMap["name"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "name")
                }
              }

              /// The repository's name with owner.
              public var nameWithOwner: String {
                get {
                  return resultMap["nameWithOwner"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "nameWithOwner")
                }
              }

              /// A list of pull requests that have been opened in the repository.
              public var pullRequests: PullRequest {
                get {
                  return PullRequest(unsafeResultMap: resultMap["pullRequests"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "pullRequests")
                }
              }

              public struct PullRequest: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["PullRequestConnection"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("nodes", type: .list(.object(Node.selections))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(totalCount: Int, nodes: [Node?]? = nil) {
                  self.init(unsafeResultMap: ["__typename": "PullRequestConnection", "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the total count of items in the connection.
                public var totalCount: Int {
                  get {
                    return resultMap["totalCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "totalCount")
                  }
                }

                /// A list of nodes.
                public var nodes: [Node?]? {
                  get {
                    return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
                  }
                  set {
                    resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
                  }
                }

                public struct Node: GraphQLSelectionSet {
                  public static let possibleTypes: [String] = ["PullRequest"]

                  public static var selections: [GraphQLSelection] {
                    return [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                      GraphQLField("url", type: .nonNull(.scalar(String.self))),
                      GraphQLField("title", type: .nonNull(.scalar(String.self))),
                      GraphQLField("author", type: .object(Author.selections)),
                      GraphQLField("comments", type: .nonNull(.object(Comment.selections))),
                      GraphQLField("mergeable", type: .nonNull(.scalar(MergeableState.self))),
                      GraphQLField("reviewDecision", type: .scalar(PullRequestReviewDecision.self)),
                      GraphQLField("reviewRequests", arguments: ["first": 10], type: .object(ReviewRequest.selections)),
                      GraphQLField("reviews", arguments: ["first": 20], type: .object(Review.selections)),
                    ]
                  }

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(id: GraphQLID, url: String, title: String, author: Author? = nil, comments: Comment, mergeable: MergeableState, reviewDecision: PullRequestReviewDecision? = nil, reviewRequests: ReviewRequest? = nil, reviews: Review? = nil) {
                    self.init(unsafeResultMap: ["__typename": "PullRequest", "id": id, "url": url, "title": title, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "comments": comments.resultMap, "mergeable": mergeable, "reviewDecision": reviewDecision, "reviewRequests": reviewRequests.flatMap { (value: ReviewRequest) -> ResultMap in value.resultMap }, "reviews": reviews.flatMap { (value: Review) -> ResultMap in value.resultMap }])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  public var id: GraphQLID {
                    get {
                      return resultMap["id"]! as! GraphQLID
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "id")
                    }
                  }

                  /// The HTTP URL for this pull request.
                  public var url: String {
                    get {
                      return resultMap["url"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "url")
                    }
                  }

                  /// Identifies the pull request title.
                  public var title: String {
                    get {
                      return resultMap["title"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "title")
                    }
                  }

                  /// The actor who authored the comment.
                  public var author: Author? {
                    get {
                      return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
                    }
                    set {
                      resultMap.updateValue(newValue?.resultMap, forKey: "author")
                    }
                  }

                  /// A list of comments associated with the pull request.
                  public var comments: Comment {
                    get {
                      return Comment(unsafeResultMap: resultMap["comments"]! as! ResultMap)
                    }
                    set {
                      resultMap.updateValue(newValue.resultMap, forKey: "comments")
                    }
                  }

                  /// Whether or not the pull request can be merged based on the existence of merge conflicts.
                  public var mergeable: MergeableState {
                    get {
                      return resultMap["mergeable"]! as! MergeableState
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "mergeable")
                    }
                  }

                  /// The current status of this pull request with respect to code review.
                  public var reviewDecision: PullRequestReviewDecision? {
                    get {
                      return resultMap["reviewDecision"] as? PullRequestReviewDecision
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "reviewDecision")
                    }
                  }

                  /// A list of review requests associated with the pull request.
                  public var reviewRequests: ReviewRequest? {
                    get {
                      return (resultMap["reviewRequests"] as? ResultMap).flatMap { ReviewRequest(unsafeResultMap: $0) }
                    }
                    set {
                      resultMap.updateValue(newValue?.resultMap, forKey: "reviewRequests")
                    }
                  }

                  /// A list of reviews associated with the pull request.
                  public var reviews: Review? {
                    get {
                      return (resultMap["reviews"] as? ResultMap).flatMap { Review(unsafeResultMap: $0) }
                    }
                    set {
                      resultMap.updateValue(newValue?.resultMap, forKey: "reviews")
                    }
                  }

                  public struct Author: GraphQLSelectionSet {
                    public static let possibleTypes: [String] = ["Bot", "EnterpriseUserAccount", "Mannequin", "Organization", "User"]

                    public static var selections: [GraphQLSelection] {
                      return [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("login", type: .nonNull(.scalar(String.self))),
                        GraphQLField("avatarUrl", arguments: ["size": 120], type: .nonNull(.scalar(String.self))),
                      ]
                    }

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public static func makeBot(login: String, avatarUrl: String) -> Author {
                      return Author(unsafeResultMap: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
                    }

                    public static func makeEnterpriseUserAccount(login: String, avatarUrl: String) -> Author {
                      return Author(unsafeResultMap: ["__typename": "EnterpriseUserAccount", "login": login, "avatarUrl": avatarUrl])
                    }

                    public static func makeMannequin(login: String, avatarUrl: String) -> Author {
                      return Author(unsafeResultMap: ["__typename": "Mannequin", "login": login, "avatarUrl": avatarUrl])
                    }

                    public static func makeOrganization(login: String, avatarUrl: String) -> Author {
                      return Author(unsafeResultMap: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
                    }

                    public static func makeUser(login: String, avatarUrl: String) -> Author {
                      return Author(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The username of the actor.
                    public var login: String {
                      get {
                        return resultMap["login"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "login")
                      }
                    }

                    /// A URL pointing to the actor's public avatar.
                    public var avatarUrl: String {
                      get {
                        return resultMap["avatarUrl"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "avatarUrl")
                      }
                    }
                  }

                  public struct Comment: GraphQLSelectionSet {
                    public static let possibleTypes: [String] = ["IssueCommentConnection"]

                    public static var selections: [GraphQLSelection] {
                      return [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                      ]
                    }

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(totalCount: Int) {
                      self.init(unsafeResultMap: ["__typename": "IssueCommentConnection", "totalCount": totalCount])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the total count of items in the connection.
                    public var totalCount: Int {
                      get {
                        return resultMap["totalCount"]! as! Int
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "totalCount")
                      }
                    }
                  }

                  public struct ReviewRequest: GraphQLSelectionSet {
                    public static let possibleTypes: [String] = ["ReviewRequestConnection"]

                    public static var selections: [GraphQLSelection] {
                      return [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                        GraphQLField("nodes", type: .list(.object(Node.selections))),
                      ]
                    }

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(totalCount: Int, nodes: [Node?]? = nil) {
                      self.init(unsafeResultMap: ["__typename": "ReviewRequestConnection", "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the total count of items in the connection.
                    public var totalCount: Int {
                      get {
                        return resultMap["totalCount"]! as! Int
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "totalCount")
                      }
                    }

                    /// A list of nodes.
                    public var nodes: [Node?]? {
                      get {
                        return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
                      }
                      set {
                        resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
                      }
                    }

                    public struct Node: GraphQLSelectionSet {
                      public static let possibleTypes: [String] = ["ReviewRequest"]

                      public static var selections: [GraphQLSelection] {
                        return [
                          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                          GraphQLField("requestedReviewer", type: .object(RequestedReviewer.selections)),
                        ]
                      }

                      public private(set) var resultMap: ResultMap

                      public init(unsafeResultMap: ResultMap) {
                        self.resultMap = unsafeResultMap
                      }

                      public init(requestedReviewer: RequestedReviewer? = nil) {
                        self.init(unsafeResultMap: ["__typename": "ReviewRequest", "requestedReviewer": requestedReviewer.flatMap { (value: RequestedReviewer) -> ResultMap in value.resultMap }])
                      }

                      public var __typename: String {
                        get {
                          return resultMap["__typename"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// The reviewer that is requested.
                      public var requestedReviewer: RequestedReviewer? {
                        get {
                          return (resultMap["requestedReviewer"] as? ResultMap).flatMap { RequestedReviewer(unsafeResultMap: $0) }
                        }
                        set {
                          resultMap.updateValue(newValue?.resultMap, forKey: "requestedReviewer")
                        }
                      }

                      public struct RequestedReviewer: GraphQLSelectionSet {
                        public static let possibleTypes: [String] = ["Mannequin", "Team", "User"]

                        public static var selections: [GraphQLSelection] {
                          return [
                            GraphQLTypeCase(
                              variants: ["User": AsUser.selections],
                              default: [
                                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                              ]
                            )
                          ]
                        }

                        public private(set) var resultMap: ResultMap

                        public init(unsafeResultMap: ResultMap) {
                          self.resultMap = unsafeResultMap
                        }

                        public static func makeMannequin() -> RequestedReviewer {
                          return RequestedReviewer(unsafeResultMap: ["__typename": "Mannequin"])
                        }

                        public static func makeTeam() -> RequestedReviewer {
                          return RequestedReviewer(unsafeResultMap: ["__typename": "Team"])
                        }

                        public static func makeUser(id: GraphQLID, login: String, name: String? = nil, email: String, avatarUrl: String) -> RequestedReviewer {
                          return RequestedReviewer(unsafeResultMap: ["__typename": "User", "id": id, "login": login, "name": name, "email": email, "avatarUrl": avatarUrl])
                        }

                        public var __typename: String {
                          get {
                            return resultMap["__typename"]! as! String
                          }
                          set {
                            resultMap.updateValue(newValue, forKey: "__typename")
                          }
                        }

                        public var asUser: AsUser? {
                          get {
                            if !AsUser.possibleTypes.contains(__typename) { return nil }
                            return AsUser(unsafeResultMap: resultMap)
                          }
                          set {
                            guard let newValue = newValue else { return }
                            resultMap = newValue.resultMap
                          }
                        }

                        public struct AsUser: GraphQLSelectionSet {
                          public static let possibleTypes: [String] = ["User"]

                          public static var selections: [GraphQLSelection] {
                            return [
                              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                              GraphQLField("login", type: .nonNull(.scalar(String.self))),
                              GraphQLField("name", type: .scalar(String.self)),
                              GraphQLField("email", type: .nonNull(.scalar(String.self))),
                              GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                            ]
                          }

                          public private(set) var resultMap: ResultMap

                          public init(unsafeResultMap: ResultMap) {
                            self.resultMap = unsafeResultMap
                          }

                          public init(id: GraphQLID, login: String, name: String? = nil, email: String, avatarUrl: String) {
                            self.init(unsafeResultMap: ["__typename": "User", "id": id, "login": login, "name": name, "email": email, "avatarUrl": avatarUrl])
                          }

                          public var __typename: String {
                            get {
                              return resultMap["__typename"]! as! String
                            }
                            set {
                              resultMap.updateValue(newValue, forKey: "__typename")
                            }
                          }

                          public var id: GraphQLID {
                            get {
                              return resultMap["id"]! as! GraphQLID
                            }
                            set {
                              resultMap.updateValue(newValue, forKey: "id")
                            }
                          }

                          /// The username used to login.
                          public var login: String {
                            get {
                              return resultMap["login"]! as! String
                            }
                            set {
                              resultMap.updateValue(newValue, forKey: "login")
                            }
                          }

                          /// The user's public profile name.
                          public var name: String? {
                            get {
                              return resultMap["name"] as? String
                            }
                            set {
                              resultMap.updateValue(newValue, forKey: "name")
                            }
                          }

                          /// The user's publicly visible profile email.
                          public var email: String {
                            get {
                              return resultMap["email"]! as! String
                            }
                            set {
                              resultMap.updateValue(newValue, forKey: "email")
                            }
                          }

                          /// A URL pointing to the user's public avatar.
                          public var avatarUrl: String {
                            get {
                              return resultMap["avatarUrl"]! as! String
                            }
                            set {
                              resultMap.updateValue(newValue, forKey: "avatarUrl")
                            }
                          }
                        }
                      }
                    }
                  }

                  public struct Review: GraphQLSelectionSet {
                    public static let possibleTypes: [String] = ["PullRequestReviewConnection"]

                    public static var selections: [GraphQLSelection] {
                      return [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                        GraphQLField("nodes", type: .list(.object(Node.selections))),
                      ]
                    }

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(totalCount: Int, nodes: [Node?]? = nil) {
                      self.init(unsafeResultMap: ["__typename": "PullRequestReviewConnection", "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// Identifies the total count of items in the connection.
                    public var totalCount: Int {
                      get {
                        return resultMap["totalCount"]! as! Int
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "totalCount")
                      }
                    }

                    /// A list of nodes.
                    public var nodes: [Node?]? {
                      get {
                        return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
                      }
                      set {
                        resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
                      }
                    }

                    public struct Node: GraphQLSelectionSet {
                      public static let possibleTypes: [String] = ["PullRequestReview"]

                      public static var selections: [GraphQLSelection] {
                        return [
                          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                          GraphQLField("state", type: .nonNull(.scalar(PullRequestReviewState.self))),
                          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                          GraphQLField("author", type: .object(Author.selections)),
                        ]
                      }

                      public private(set) var resultMap: ResultMap

                      public init(unsafeResultMap: ResultMap) {
                        self.resultMap = unsafeResultMap
                      }

                      public init(state: PullRequestReviewState, createdAt: String, author: Author? = nil) {
                        self.init(unsafeResultMap: ["__typename": "PullRequestReview", "state": state, "createdAt": createdAt, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }])
                      }

                      public var __typename: String {
                        get {
                          return resultMap["__typename"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      /// Identifies the current state of the pull request review.
                      public var state: PullRequestReviewState {
                        get {
                          return resultMap["state"]! as! PullRequestReviewState
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "state")
                        }
                      }

                      /// Identifies the date and time when the object was created.
                      public var createdAt: String {
                        get {
                          return resultMap["createdAt"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "createdAt")
                        }
                      }

                      /// The actor who authored the comment.
                      public var author: Author? {
                        get {
                          return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
                        }
                        set {
                          resultMap.updateValue(newValue?.resultMap, forKey: "author")
                        }
                      }

                      public struct Author: GraphQLSelectionSet {
                        public static let possibleTypes: [String] = ["Bot", "EnterpriseUserAccount", "Mannequin", "Organization", "User"]

                        public static var selections: [GraphQLSelection] {
                          return [
                            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                            GraphQLField("login", type: .nonNull(.scalar(String.self))),
                            GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                          ]
                        }

                        public private(set) var resultMap: ResultMap

                        public init(unsafeResultMap: ResultMap) {
                          self.resultMap = unsafeResultMap
                        }

                        public static func makeBot(login: String, avatarUrl: String) -> Author {
                          return Author(unsafeResultMap: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
                        }

                        public static func makeEnterpriseUserAccount(login: String, avatarUrl: String) -> Author {
                          return Author(unsafeResultMap: ["__typename": "EnterpriseUserAccount", "login": login, "avatarUrl": avatarUrl])
                        }

                        public static func makeMannequin(login: String, avatarUrl: String) -> Author {
                          return Author(unsafeResultMap: ["__typename": "Mannequin", "login": login, "avatarUrl": avatarUrl])
                        }

                        public static func makeOrganization(login: String, avatarUrl: String) -> Author {
                          return Author(unsafeResultMap: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
                        }

                        public static func makeUser(login: String, avatarUrl: String) -> Author {
                          return Author(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                        }

                        public var __typename: String {
                          get {
                            return resultMap["__typename"]! as! String
                          }
                          set {
                            resultMap.updateValue(newValue, forKey: "__typename")
                          }
                        }

                        /// The username of the actor.
                        public var login: String {
                          get {
                            return resultMap["login"]! as! String
                          }
                          set {
                            resultMap.updateValue(newValue, forKey: "login")
                          }
                        }

                        /// A URL pointing to the actor's public avatar.
                        public var avatarUrl: String {
                          get {
                            return resultMap["avatarUrl"]! as! String
                          }
                          set {
                            resultMap.updateValue(newValue, forKey: "avatarUrl")
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class RepositoriesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Repositories {
      viewer {
        __typename
        repositories(first: 60) {
          __typename
          totalCount
          nodes {
            __typename
            name
            nameWithOwner
            pullRequests(first: 10, states: OPEN) {
              __typename
              totalCount
              nodes {
                __typename
                id
                url
                title
                author {
                  __typename
                  login
                  avatarUrl(size: 120)
                }
                comments {
                  __typename
                  totalCount
                }
                mergeable
                reviewDecision
                reviewRequests(first: 10) {
                  __typename
                  totalCount
                  nodes {
                    __typename
                    requestedReviewer {
                      __typename
                      ... on User {
                        __typename
                        id
                        login
                        name
                        email
                        avatarUrl
                      }
                    }
                  }
                }
                reviews(first: 20) {
                  __typename
                  totalCount
                  nodes {
                    __typename
                    state
                    createdAt
                    author {
                      __typename
                      login
                      avatarUrl
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "Repositories"

  public let operationIdentifier: String? = "c28659f2905f61f30e547829f28058e85e28cf1e149d993d5820c3c25ead0338"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("viewer", type: .nonNull(.object(Viewer.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(viewer: Viewer) {
      self.init(unsafeResultMap: ["__typename": "Query", "viewer": viewer.resultMap])
    }

    /// The currently authenticated user.
    public var viewer: Viewer {
      get {
        return Viewer(unsafeResultMap: resultMap["viewer"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("repositories", arguments: ["first": 60], type: .nonNull(.object(Repository.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(repositories: Repository) {
        self.init(unsafeResultMap: ["__typename": "User", "repositories": repositories.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of repositories that the user owns.
      public var repositories: Repository {
        get {
          return Repository(unsafeResultMap: resultMap["repositories"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "repositories")
        }
      }

      public struct Repository: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["RepositoryConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(totalCount: Int, nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "RepositoryConnection", "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Identifies the total count of items in the connection.
        public var totalCount: Int {
          get {
            return resultMap["totalCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "totalCount")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Repository"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("nameWithOwner", type: .nonNull(.scalar(String.self))),
              GraphQLField("pullRequests", arguments: ["first": 10, "states": "OPEN"], type: .nonNull(.object(PullRequest.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String, nameWithOwner: String, pullRequests: PullRequest) {
            self.init(unsafeResultMap: ["__typename": "Repository", "name": name, "nameWithOwner": nameWithOwner, "pullRequests": pullRequests.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The name of the repository.
          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          /// The repository's name with owner.
          public var nameWithOwner: String {
            get {
              return resultMap["nameWithOwner"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "nameWithOwner")
            }
          }

          /// A list of pull requests that have been opened in the repository.
          public var pullRequests: PullRequest {
            get {
              return PullRequest(unsafeResultMap: resultMap["pullRequests"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "pullRequests")
            }
          }

          public struct PullRequest: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["PullRequestConnection"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                GraphQLField("nodes", type: .list(.object(Node.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(totalCount: Int, nodes: [Node?]? = nil) {
              self.init(unsafeResultMap: ["__typename": "PullRequestConnection", "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Identifies the total count of items in the connection.
            public var totalCount: Int {
              get {
                return resultMap["totalCount"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "totalCount")
              }
            }

            /// A list of nodes.
            public var nodes: [Node?]? {
              get {
                return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["PullRequest"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("url", type: .nonNull(.scalar(String.self))),
                  GraphQLField("title", type: .nonNull(.scalar(String.self))),
                  GraphQLField("author", type: .object(Author.selections)),
                  GraphQLField("comments", type: .nonNull(.object(Comment.selections))),
                  GraphQLField("mergeable", type: .nonNull(.scalar(MergeableState.self))),
                  GraphQLField("reviewDecision", type: .scalar(PullRequestReviewDecision.self)),
                  GraphQLField("reviewRequests", arguments: ["first": 10], type: .object(ReviewRequest.selections)),
                  GraphQLField("reviews", arguments: ["first": 20], type: .object(Review.selections)),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID, url: String, title: String, author: Author? = nil, comments: Comment, mergeable: MergeableState, reviewDecision: PullRequestReviewDecision? = nil, reviewRequests: ReviewRequest? = nil, reviews: Review? = nil) {
                self.init(unsafeResultMap: ["__typename": "PullRequest", "id": id, "url": url, "title": title, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "comments": comments.resultMap, "mergeable": mergeable, "reviewDecision": reviewDecision, "reviewRequests": reviewRequests.flatMap { (value: ReviewRequest) -> ResultMap in value.resultMap }, "reviews": reviews.flatMap { (value: Review) -> ResultMap in value.resultMap }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var id: GraphQLID {
                get {
                  return resultMap["id"]! as! GraphQLID
                }
                set {
                  resultMap.updateValue(newValue, forKey: "id")
                }
              }

              /// The HTTP URL for this pull request.
              public var url: String {
                get {
                  return resultMap["url"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "url")
                }
              }

              /// Identifies the pull request title.
              public var title: String {
                get {
                  return resultMap["title"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "title")
                }
              }

              /// The actor who authored the comment.
              public var author: Author? {
                get {
                  return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "author")
                }
              }

              /// A list of comments associated with the pull request.
              public var comments: Comment {
                get {
                  return Comment(unsafeResultMap: resultMap["comments"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "comments")
                }
              }

              /// Whether or not the pull request can be merged based on the existence of merge conflicts.
              public var mergeable: MergeableState {
                get {
                  return resultMap["mergeable"]! as! MergeableState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "mergeable")
                }
              }

              /// The current status of this pull request with respect to code review.
              public var reviewDecision: PullRequestReviewDecision? {
                get {
                  return resultMap["reviewDecision"] as? PullRequestReviewDecision
                }
                set {
                  resultMap.updateValue(newValue, forKey: "reviewDecision")
                }
              }

              /// A list of review requests associated with the pull request.
              public var reviewRequests: ReviewRequest? {
                get {
                  return (resultMap["reviewRequests"] as? ResultMap).flatMap { ReviewRequest(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "reviewRequests")
                }
              }

              /// A list of reviews associated with the pull request.
              public var reviews: Review? {
                get {
                  return (resultMap["reviews"] as? ResultMap).flatMap { Review(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "reviews")
                }
              }

              public struct Author: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["Bot", "EnterpriseUserAccount", "Mannequin", "Organization", "User"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("login", type: .nonNull(.scalar(String.self))),
                    GraphQLField("avatarUrl", arguments: ["size": 120], type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public static func makeBot(login: String, avatarUrl: String) -> Author {
                  return Author(unsafeResultMap: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
                }

                public static func makeEnterpriseUserAccount(login: String, avatarUrl: String) -> Author {
                  return Author(unsafeResultMap: ["__typename": "EnterpriseUserAccount", "login": login, "avatarUrl": avatarUrl])
                }

                public static func makeMannequin(login: String, avatarUrl: String) -> Author {
                  return Author(unsafeResultMap: ["__typename": "Mannequin", "login": login, "avatarUrl": avatarUrl])
                }

                public static func makeOrganization(login: String, avatarUrl: String) -> Author {
                  return Author(unsafeResultMap: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
                }

                public static func makeUser(login: String, avatarUrl: String) -> Author {
                  return Author(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// The username of the actor.
                public var login: String {
                  get {
                    return resultMap["login"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "login")
                  }
                }

                /// A URL pointing to the actor's public avatar.
                public var avatarUrl: String {
                  get {
                    return resultMap["avatarUrl"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "avatarUrl")
                  }
                }
              }

              public struct Comment: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["IssueCommentConnection"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(totalCount: Int) {
                  self.init(unsafeResultMap: ["__typename": "IssueCommentConnection", "totalCount": totalCount])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the total count of items in the connection.
                public var totalCount: Int {
                  get {
                    return resultMap["totalCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "totalCount")
                  }
                }
              }

              public struct ReviewRequest: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["ReviewRequestConnection"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("nodes", type: .list(.object(Node.selections))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(totalCount: Int, nodes: [Node?]? = nil) {
                  self.init(unsafeResultMap: ["__typename": "ReviewRequestConnection", "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the total count of items in the connection.
                public var totalCount: Int {
                  get {
                    return resultMap["totalCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "totalCount")
                  }
                }

                /// A list of nodes.
                public var nodes: [Node?]? {
                  get {
                    return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
                  }
                  set {
                    resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
                  }
                }

                public struct Node: GraphQLSelectionSet {
                  public static let possibleTypes: [String] = ["ReviewRequest"]

                  public static var selections: [GraphQLSelection] {
                    return [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("requestedReviewer", type: .object(RequestedReviewer.selections)),
                    ]
                  }

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(requestedReviewer: RequestedReviewer? = nil) {
                    self.init(unsafeResultMap: ["__typename": "ReviewRequest", "requestedReviewer": requestedReviewer.flatMap { (value: RequestedReviewer) -> ResultMap in value.resultMap }])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// The reviewer that is requested.
                  public var requestedReviewer: RequestedReviewer? {
                    get {
                      return (resultMap["requestedReviewer"] as? ResultMap).flatMap { RequestedReviewer(unsafeResultMap: $0) }
                    }
                    set {
                      resultMap.updateValue(newValue?.resultMap, forKey: "requestedReviewer")
                    }
                  }

                  public struct RequestedReviewer: GraphQLSelectionSet {
                    public static let possibleTypes: [String] = ["Mannequin", "Team", "User"]

                    public static var selections: [GraphQLSelection] {
                      return [
                        GraphQLTypeCase(
                          variants: ["User": AsUser.selections],
                          default: [
                            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                          ]
                        )
                      ]
                    }

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public static func makeMannequin() -> RequestedReviewer {
                      return RequestedReviewer(unsafeResultMap: ["__typename": "Mannequin"])
                    }

                    public static func makeTeam() -> RequestedReviewer {
                      return RequestedReviewer(unsafeResultMap: ["__typename": "Team"])
                    }

                    public static func makeUser(id: GraphQLID, login: String, name: String? = nil, email: String, avatarUrl: String) -> RequestedReviewer {
                      return RequestedReviewer(unsafeResultMap: ["__typename": "User", "id": id, "login": login, "name": name, "email": email, "avatarUrl": avatarUrl])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    public var asUser: AsUser? {
                      get {
                        if !AsUser.possibleTypes.contains(__typename) { return nil }
                        return AsUser(unsafeResultMap: resultMap)
                      }
                      set {
                        guard let newValue = newValue else { return }
                        resultMap = newValue.resultMap
                      }
                    }

                    public struct AsUser: GraphQLSelectionSet {
                      public static let possibleTypes: [String] = ["User"]

                      public static var selections: [GraphQLSelection] {
                        return [
                          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                          GraphQLField("login", type: .nonNull(.scalar(String.self))),
                          GraphQLField("name", type: .scalar(String.self)),
                          GraphQLField("email", type: .nonNull(.scalar(String.self))),
                          GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                        ]
                      }

                      public private(set) var resultMap: ResultMap

                      public init(unsafeResultMap: ResultMap) {
                        self.resultMap = unsafeResultMap
                      }

                      public init(id: GraphQLID, login: String, name: String? = nil, email: String, avatarUrl: String) {
                        self.init(unsafeResultMap: ["__typename": "User", "id": id, "login": login, "name": name, "email": email, "avatarUrl": avatarUrl])
                      }

                      public var __typename: String {
                        get {
                          return resultMap["__typename"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "__typename")
                        }
                      }

                      public var id: GraphQLID {
                        get {
                          return resultMap["id"]! as! GraphQLID
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "id")
                        }
                      }

                      /// The username used to login.
                      public var login: String {
                        get {
                          return resultMap["login"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "login")
                        }
                      }

                      /// The user's public profile name.
                      public var name: String? {
                        get {
                          return resultMap["name"] as? String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "name")
                        }
                      }

                      /// The user's publicly visible profile email.
                      public var email: String {
                        get {
                          return resultMap["email"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "email")
                        }
                      }

                      /// A URL pointing to the user's public avatar.
                      public var avatarUrl: String {
                        get {
                          return resultMap["avatarUrl"]! as! String
                        }
                        set {
                          resultMap.updateValue(newValue, forKey: "avatarUrl")
                        }
                      }
                    }
                  }
                }
              }

              public struct Review: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["PullRequestReviewConnection"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("nodes", type: .list(.object(Node.selections))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(totalCount: Int, nodes: [Node?]? = nil) {
                  self.init(unsafeResultMap: ["__typename": "PullRequestReviewConnection", "totalCount": totalCount, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// Identifies the total count of items in the connection.
                public var totalCount: Int {
                  get {
                    return resultMap["totalCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "totalCount")
                  }
                }

                /// A list of nodes.
                public var nodes: [Node?]? {
                  get {
                    return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
                  }
                  set {
                    resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
                  }
                }

                public struct Node: GraphQLSelectionSet {
                  public static let possibleTypes: [String] = ["PullRequestReview"]

                  public static var selections: [GraphQLSelection] {
                    return [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("state", type: .nonNull(.scalar(PullRequestReviewState.self))),
                      GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                      GraphQLField("author", type: .object(Author.selections)),
                    ]
                  }

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(state: PullRequestReviewState, createdAt: String, author: Author? = nil) {
                    self.init(unsafeResultMap: ["__typename": "PullRequestReview", "state": state, "createdAt": createdAt, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// Identifies the current state of the pull request review.
                  public var state: PullRequestReviewState {
                    get {
                      return resultMap["state"]! as! PullRequestReviewState
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "state")
                    }
                  }

                  /// Identifies the date and time when the object was created.
                  public var createdAt: String {
                    get {
                      return resultMap["createdAt"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "createdAt")
                    }
                  }

                  /// The actor who authored the comment.
                  public var author: Author? {
                    get {
                      return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
                    }
                    set {
                      resultMap.updateValue(newValue?.resultMap, forKey: "author")
                    }
                  }

                  public struct Author: GraphQLSelectionSet {
                    public static let possibleTypes: [String] = ["Bot", "EnterpriseUserAccount", "Mannequin", "Organization", "User"]

                    public static var selections: [GraphQLSelection] {
                      return [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("login", type: .nonNull(.scalar(String.self))),
                        GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                      ]
                    }

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public static func makeBot(login: String, avatarUrl: String) -> Author {
                      return Author(unsafeResultMap: ["__typename": "Bot", "login": login, "avatarUrl": avatarUrl])
                    }

                    public static func makeEnterpriseUserAccount(login: String, avatarUrl: String) -> Author {
                      return Author(unsafeResultMap: ["__typename": "EnterpriseUserAccount", "login": login, "avatarUrl": avatarUrl])
                    }

                    public static func makeMannequin(login: String, avatarUrl: String) -> Author {
                      return Author(unsafeResultMap: ["__typename": "Mannequin", "login": login, "avatarUrl": avatarUrl])
                    }

                    public static func makeOrganization(login: String, avatarUrl: String) -> Author {
                      return Author(unsafeResultMap: ["__typename": "Organization", "login": login, "avatarUrl": avatarUrl])
                    }

                    public static func makeUser(login: String, avatarUrl: String) -> Author {
                      return Author(unsafeResultMap: ["__typename": "User", "login": login, "avatarUrl": avatarUrl])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                      }
                    }

                    /// The username of the actor.
                    public var login: String {
                      get {
                        return resultMap["login"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "login")
                      }
                    }

                    /// A URL pointing to the actor's public avatar.
                    public var avatarUrl: String {
                      get {
                        return resultMap["avatarUrl"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "avatarUrl")
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class UserQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query User {
      viewer {
        __typename
        id
        login
        name
        email
        avatarUrl(size: 120)
      }
    }
    """

  public let operationName: String = "User"

  public let operationIdentifier: String? = "0a689749652be14c3e7c5562915b24f73684ca3b7e502c62c1df1b8d3d33a8e3"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("viewer", type: .nonNull(.object(Viewer.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(viewer: Viewer) {
      self.init(unsafeResultMap: ["__typename": "Query", "viewer": viewer.resultMap])
    }

    /// The currently authenticated user.
    public var viewer: Viewer {
      get {
        return Viewer(unsafeResultMap: resultMap["viewer"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("login", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("avatarUrl", arguments: ["size": 120], type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, login: String, name: String? = nil, email: String, avatarUrl: String) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "login": login, "name": name, "email": email, "avatarUrl": avatarUrl])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// The username used to login.
      public var login: String {
        get {
          return resultMap["login"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "login")
        }
      }

      /// The user's public profile name.
      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// The user's publicly visible profile email.
      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      /// A URL pointing to the user's public avatar.
      public var avatarUrl: String {
        get {
          return resultMap["avatarUrl"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "avatarUrl")
        }
      }
    }
  }
}
