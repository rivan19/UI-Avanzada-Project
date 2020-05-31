//
//  TopicsViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit
import Lottie

/// ViewController que representa un listado de topics
class TopicsViewController: UIViewController {
    
    //@IBOutlet weak var viewButton: AddButtonView!
    
    private var animatedView: AnimationView?
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: TopicCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: TopicCell.cellIdentifier)
        table.register(UINib(nibName: TopicCellBienvenida.cellIdentifier, bundle: nil), forCellReuseIdentifier: TopicCellBienvenida.cellIdentifier)
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        table.backgroundColor = .white
        
        return table
    }()
    
    lazy var buttonView: AddButtonView = {
       return AddButtonView()
    }()
    
    //let imageAddTopicView: UIImageView
    let viewModel: TopicsViewModel
    //let buttonAddTopic: UIButton!
    
    init(viewModel: TopicsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        
        
        animatedView = AnimationView(name: "18378-retro-game-loading-animation")
        if let animatedView = animatedView {
            
            animatedView.frame = .zero
            
            view.addSubview(animatedView)
            animatedView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                animatedView.topAnchor.constraint(equalTo: view.topAnchor),
                animatedView.leftAnchor.constraint(equalTo: view.leftAnchor),
                animatedView.rightAnchor.constraint(equalTo: view.rightAnchor),
                animatedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            animatedView.loopMode = .loop
            
            
        }
        
        tableView.isHidden = true
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        view.sendSubviewToBack(tableView)

        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icoSearch"), style: .plain, target: self, action: nil)
        //rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icoAdd"), style: .plain, target: self, action: #selector(plusButtonTapped))
        //leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        animatedView?.isHidden = true
        animatedView?.stop()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (tableView.isHidden){
            animatedView?.isHidden = false
            animatedView?.play()
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animatedView?.play()
        
        buttonView.isHidden = true
        buttonView.backgroundColor = .clear
        
        buttonView.isOpaque = false
        
        view.addSubview(buttonView)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            buttonView.widthAnchor.constraint(equalToConstant: 64.0),
            buttonView.heightAnchor.constraint(equalToConstant: 64.0)
        ])
        
        buttonView.addTopicBlock = {
            self.viewModel.plusButtonTapped()
        }
        
        viewModel.viewWasLoaded()
        
    }

    @objc func plusButtonTapped() {
        viewModel.plusButtonTapped()
    }

    fileprivate func showErrorFetchingTopicsAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topics\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
}

extension TopicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TopicCell.cellIdentifier, for: indexPath) as? TopicCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) as? TopicCellViewModel {
            cell.viewModel = cellViewModel
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: TopicCellBienvenida.cellIdentifier, for: indexPath) as? TopicCellBienvenida,
            let cellViewModel = viewModel.viewModel(at: indexPath) as? TopicCellViewModelBienvenida {
            cell.viewModel = cellViewModel
            
            //cell.heightAnchor.constraint(equalToConstant: 103.0)
            return cell
        } else {
            return UITableViewCell()
        }

        //fatalError()
    }
}

extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
    
}

extension TopicsViewController: TopicsViewDelegate {
    func topicsFetched() {
        tableView.isHidden = false
        tableView.reloadData()
        tableView.setNeedsLayout()
        if let animatedView = animatedView {
            animatedView.stop()
            animatedView.isHidden = true
        }
        
        buttonView.isHidden = false
        
    }

    func errorFetchingTopics() {
        showErrorFetchingTopicsAlert()
        animatedView?.stop()
        animatedView?.isHidden = true
    }
}
