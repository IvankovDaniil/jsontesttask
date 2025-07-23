//
//  TaskViewModel.swift
//  JSONTestTask
//
//  Created by Даниил Иваньков on 22.07.2025.
//

import CoreData

final class PostViewModel {
    var posts: [Post] = []
    
    func fetchPosts(context: NSManagedObjectContext, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchPosts {[weak self] result in
            switch result {
            case .success(let dto):
                self?.savePostsToCoreData(posts: dto, context: context)
                self?.loadFromCoreData(context: context)
                print(self?.posts.count ?? 0)
            case .failure(_):
                self?.loadFromCoreData(context: context)
                print("error")
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    
    func post(at index: Int) -> Post {
        return posts[index]
    }
    
    func avatarURL(for index: Int) -> URL? {
        let userId = posts[index].userId
        return URL(string: "https://picsum.photos/id/\(userId)/50/50")
    }
    
    func loadFromCoreData(context: NSManagedObjectContext) {
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        
        do {
            posts = try context.fetch(request)
        } catch {
            print("Not loaded")
        }
    }
    
    private func savePostsToCoreData(posts: [PostDTO], context: NSManagedObjectContext) {
        
        //Удаление старых записей с БД
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Post.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            
        }
        //Добавление новых
        for postDTO in posts {
            let post = Post(context: context)
            post.id = UUID()
            post.userId = Int64(postDTO.userId)
            post.title = postDTO.title
            post.body = postDTO.body
        }
        
        do {
            try context.save()
        } catch {
            print("Not saved")
        }
    }
}
