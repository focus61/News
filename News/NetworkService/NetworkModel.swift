struct NetworkModel: Codable {
    let news: [News]
}
struct News: Codable {
    let title: String
    let author: String
    let description: String
    let image: String
    let category: [String]
    let published: String
}
