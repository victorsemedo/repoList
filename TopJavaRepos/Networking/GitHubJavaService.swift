//
//  GitHubJavaService.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 05/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import Foundation

class GitHubJavaService: GitHubService {

    func fetchRepositories(page: Int, callback: @escaping RepositoriesReturnFunc) {
        let endpoint = GitHubEndpoint.repositories.rawValue
        var urlComponents = URLComponents(string: endpoint)
        urlComponents?.queryItems = getJavaRepositoriesQueryItems(page)
        
        guard let url = urlComponents?.url else {
            callback(.error(GitHubServiceError()))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                callback(.error(GitHubServiceError()))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let repositories = try jsonDecoder.decode(RepositoriesResponse.self, from: data)
                DispatchQueue.main.async(execute: {
                    callback(.success(repositories.items))
                })
            } catch {
                DispatchQueue.main.async(execute: {
                    callback(.error(error))
                })
            }
        }
        
        task.resume()
    }
    
    func fetchRepositoryPullRequests(repository: Repository, state: String?, page: Int, callback: @escaping PullResquestsReturnFunc) {
        
        let endpoint = GitHubEndpoint.pullRequestsEndpoint(repository: repository)
        var urlComponents = URLComponents(string: endpoint)
         urlComponents?.queryItems = [URLQueryItem]()
        if let state = state {
            urlComponents?.queryItems?.append(URLQueryItem(name: "state", value: state))
        }
        urlComponents?.queryItems?.append(URLQueryItem(name: "page", value: String(1)))

        
        guard let url = urlComponents?.url else {
            callback(.error(GitHubServiceError()))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                callback(.error(GitHubServiceError()))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let pullRequests = try jsonDecoder.decode([PullRequest].self, from: data)
                DispatchQueue.main.async(execute: {
                    callback(.success(pullRequests))
                })
            } catch {
                DispatchQueue.main.async(execute: {
                    callback(.error(error))
                })
            }
        }
        
        task.resume()
    }
    
    func countRepositoryPullRequests(repository: Repository, state: String?, callback: @escaping CountPullResquestsReturnFunc) {
        let endpoint = GitHubEndpoint.pullRequestsEndpoint(repository: repository)
        var urlComponents = URLComponents(string: endpoint)
        urlComponents?.queryItems = [URLQueryItem]()
        if let state = state {
            urlComponents?.queryItems?.append(URLQueryItem(name: "state", value: state))
        }
        urlComponents?.queryItems?.append(URLQueryItem(name: "page", value: String(1)))
        
        guard let url = urlComponents?.url else {
            callback(.error(GitHubServiceError()))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async(execute: {
                    callback(.error(GitHubServiceError()))
                })
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async(execute: {
                    callback(.error(GitHubServiceError()))
                })
                return
            }
            
            do {
                if let links = httpResponse.allHeaderFields["Link"] as? String {
                    let matches = try links.matches(for: "page=[+-]?[0-9]{1,10}>; rel=\"last\"", in: links)
                    
                    if matches.count == 1 {
                        var last = matches[0].replacingOccurrences(of: "page=", with: "")
                        last = last.replacingOccurrences(of: ">; rel=\"last\"", with: "")
                        
                        if let lastPage = Int(last) {
                            self.fetchRepositoryPullRequests(repository: repository, state: state, page: lastPage, callback: { (result) in
                                switch result {
                                case .success(let requests):
                                    DispatchQueue.main.async(execute: {
                                        callback(.success((lastPage - 1)*30 + requests.count))
                                    })
                                case .error(let error):
                                    DispatchQueue.main.async(execute: {
                                        callback(.error(error))
                                    })
                                }
                            })
                        } else {
                            DispatchQueue.main.async(execute: {
                                callback(.error(GitHubServiceError()))
                            })
                        }
                    } else {
                        DispatchQueue.main.async(execute: {
                            callback(.success(0))
                        })
                    }
                } else {
                    let jsonDecoder = JSONDecoder()
                    
                    do {
                        let pullRequests = try jsonDecoder.decode([PullRequest].self, from: data)
                        DispatchQueue.main.async(execute: {
                            callback(.success(pullRequests.count))
                        })
                    } catch {
                        DispatchQueue.main.async(execute: {
                            callback(.error(error))
                        })
                    }
                }
            } catch {
                callback(.error(error))
            }
        }
        
        task.resume()
    }

}

private extension GitHubJavaService {
    
    func getJavaRepositoriesQueryItems(_ page: Int) -> [URLQueryItem] {
        var urlQueryItems = [URLQueryItem]()
        
        urlQueryItems.append(URLQueryItem(name: "q", value: "language:java"))
        urlQueryItems.append(URLQueryItem(name: "sort", value: "stars"))
        urlQueryItems.append(URLQueryItem(name: "page", value: String(page)))

        return urlQueryItems
    }
}
