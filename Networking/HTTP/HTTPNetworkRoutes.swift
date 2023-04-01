import Foundation

public enum HTTPNetworkRoute: String{
    case getAllPosts = "posts/all"
    case createPost = "posts/new"
    case editPost = "posts/:id/edit"
    case deletePost = "posts/:id"

    case createToken = "api/teamchat/mobile/amity/auth/:staff_id"
    // You can add as many routes/endpoints as you have/want
}
