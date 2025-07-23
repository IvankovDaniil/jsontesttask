//
//  TaskViewController.swift
//  JSONTestTask
//
//  Created by Даниил Иваньков on 22.07.2025.
//

import UIKit

final class PostViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = PostViewModel()
    private let refreshControl = UIRefreshControl()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Posts"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setUpTableView()
        viewModel.fetchPosts(context: context, completion: { [weak self] in
            self?.tableView.reloadData()
        })
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
    private func setUpTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        )
        
        tableView.register(CellView.self, forCellReuseIdentifier: "TableViewCell")
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    //Метод обновления данных pull-to-refresh
    @objc private func refreshData() {
        viewModel.loadFromCoreData(context: context)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }
}


extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? CellView else {
            return UITableViewCell()
        }
        
        let post = viewModel.post(at: indexPath.row)
        let avatarURL = viewModel.avatarURL(for: indexPath.row)
        
        cell.configure(title: post.title, body: post.body, url: avatarURL)
        return cell
    }

}
