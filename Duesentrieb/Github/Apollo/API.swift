// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// The possible states of a pull request.
public enum PullRequestState: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// A pull request that is still open.
  case `open`
  /// A pull request that has been closed without being merged.
  case closed
  /// A pull request that has been closed by being merged.
  case merged
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "OPEN": self = .open
      case "CLOSED": self = .closed
      case "MERGED": self = .merged
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .open: return "OPEN"
      case .closed: return "CLOSED"
      case .merged: return "MERGED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: PullRequestState, rhs: PullRequestState) -> Bool {
    switch (lhs, rhs) {
      case (.open, .open): return true
      case (.closed, .closed): return true
      case (.merged, .merged): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [PullRequestState] {
    return [
      .open,
      .closed,
      .merged,
    ]
  }
}

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

public final class UserQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query User {
      viewer {
        __typename
        id
        login
        email
        avatarUrl(size: 120)
      }
    }
    """

  public let operationName: String = "User"

  public let operationIdentifier: String? = "a9ce01c6157118b93636bf3d1be669204a6ba11523f11bb84e923571b1ce539f"

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
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("avatarUrl", arguments: ["size": 120], type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, login: String, email: String, avatarUrl: String) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "login": login, "email": email, "avatarUrl": avatarUrl])
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

public final class StateQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query State {
      viewer {
        __typename
        id
        login
        email
        avatarUrl(size: 120)
        pullRequests(first: 100, states: OPEN) {
          __typename
          totalCount
          nodes {
            __typename
            id
            url
            title
            baseRepository {
              __typename
              name
            }
            author {
              __typename
              login
              avatarUrl(size: 120)
            }
            createdAt
            number
            state
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
                    email
                    avatarUrl
                  }
                }
              }
            }
            reviews(first: 10) {
              __typename
              totalCount
              nodes {
                __typename
                state
                author {
                  __typename
                  login
                  avatarUrl
                }
                comments(first: 10) {
                  __typename
                  nodes {
                    __typename
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

  public let operationName: String = "State"

  public let operationIdentifier: String? = "746e39ffdea3617f152c8a0801ecc3e518d749e71edf773211f53c6e1ff3df4b"

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
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("avatarUrl", arguments: ["size": 120], type: .nonNull(.scalar(String.self))),
          GraphQLField("pullRequests", arguments: ["first": 100, "states": "OPEN"], type: .nonNull(.object(PullRequest.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, login: String, email: String, avatarUrl: String, pullRequests: PullRequest) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "login": login, "email": email, "avatarUrl": avatarUrl, "pullRequests": pullRequests.resultMap])
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

      /// A list of pull requests associated with this user.
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
              GraphQLField("baseRepository", type: .object(BaseRepository.selections)),
              GraphQLField("author", type: .object(Author.selections)),
              GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
              GraphQLField("number", type: .nonNull(.scalar(Int.self))),
              GraphQLField("state", type: .nonNull(.scalar(PullRequestState.self))),
              GraphQLField("comments", type: .nonNull(.object(Comment.selections))),
              GraphQLField("mergeable", type: .nonNull(.scalar(MergeableState.self))),
              GraphQLField("reviewDecision", type: .scalar(PullRequestReviewDecision.self)),
              GraphQLField("reviewRequests", arguments: ["first": 10], type: .object(ReviewRequest.selections)),
              GraphQLField("reviews", arguments: ["first": 10], type: .object(Review.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, url: String, title: String, baseRepository: BaseRepository? = nil, author: Author? = nil, createdAt: String, number: Int, state: PullRequestState, comments: Comment, mergeable: MergeableState, reviewDecision: PullRequestReviewDecision? = nil, reviewRequests: ReviewRequest? = nil, reviews: Review? = nil) {
            self.init(unsafeResultMap: ["__typename": "PullRequest", "id": id, "url": url, "title": title, "baseRepository": baseRepository.flatMap { (value: BaseRepository) -> ResultMap in value.resultMap }, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "createdAt": createdAt, "number": number, "state": state, "comments": comments.resultMap, "mergeable": mergeable, "reviewDecision": reviewDecision, "reviewRequests": reviewRequests.flatMap { (value: ReviewRequest) -> ResultMap in value.resultMap }, "reviews": reviews.flatMap { (value: Review) -> ResultMap in value.resultMap }])
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

          /// The repository associated with this pull request's base Ref.
          public var baseRepository: BaseRepository? {
            get {
              return (resultMap["baseRepository"] as? ResultMap).flatMap { BaseRepository(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "baseRepository")
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

          /// Identifies the date and time when the object was created.
          public var createdAt: String {
            get {
              return resultMap["createdAt"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "createdAt")
            }
          }

          /// Identifies the pull request number.
          public var number: Int {
            get {
              return resultMap["number"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "number")
            }
          }

          /// Identifies the state of the pull request.
          public var state: PullRequestState {
            get {
              return resultMap["state"]! as! PullRequestState
            }
            set {
              resultMap.updateValue(newValue, forKey: "state")
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

          public struct BaseRepository: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Repository"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String) {
              self.init(unsafeResultMap: ["__typename": "Repository", "name": name])
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

                public static func makeUser(id: GraphQLID, login: String, email: String, avatarUrl: String) -> RequestedReviewer {
                  return RequestedReviewer(unsafeResultMap: ["__typename": "User", "id": id, "login": login, "email": email, "avatarUrl": avatarUrl])
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
                      GraphQLField("email", type: .nonNull(.scalar(String.self))),
                      GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
                    ]
                  }

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(id: GraphQLID, login: String, email: String, avatarUrl: String) {
                    self.init(unsafeResultMap: ["__typename": "User", "id": id, "login": login, "email": email, "avatarUrl": avatarUrl])
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
                  GraphQLField("author", type: .object(Author.selections)),
                  GraphQLField("comments", arguments: ["first": 10], type: .nonNull(.object(Comment.selections))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(state: PullRequestReviewState, author: Author? = nil, comments: Comment) {
                self.init(unsafeResultMap: ["__typename": "PullRequestReview", "state": state, "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }, "comments": comments.resultMap])
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

              /// The actor who authored the comment.
              public var author: Author? {
                get {
                  return (resultMap["author"] as? ResultMap).flatMap { Author(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "author")
                }
              }

              /// A list of review comments for the current pull request review.
              public var comments: Comment {
                get {
                  return Comment(unsafeResultMap: resultMap["comments"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "comments")
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

              public struct Comment: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["PullRequestReviewCommentConnection"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("nodes", type: .list(.object(Node.selections))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(nodes: [Node?]? = nil) {
                  self.init(unsafeResultMap: ["__typename": "PullRequestReviewCommentConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
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
                  public static let possibleTypes: [String] = ["PullRequestReviewComment"]

                  public static var selections: [GraphQLSelection] {
                    return [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("author", type: .object(Author.selections)),
                    ]
                  }

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(author: Author? = nil) {
                    self.init(unsafeResultMap: ["__typename": "PullRequestReviewComment", "author": author.flatMap { (value: Author) -> ResultMap in value.resultMap }])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
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
