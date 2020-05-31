//
//  UsersViewController.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit
import Lottie

class UsersViewController: UIViewController {
    private var animatedView: AnimationView?
    
    let numberOfColumns: Int = 3
    let sectionInset: CGFloat = 18
    let minimumInteritemSpacing: CGFloat = 18
    let sectionTop: CGFloat = 18.0
    let sectionBottom: CGFloat = 18.0
    let sectionLeft: CGFloat = 20.5
    let sectionRight: CGFloat = 20.5
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
     let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 95.0, height: 124.0)
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionTop, left: sectionLeft, bottom: sectionBottom, right: sectionRight)
        
        return layout
    }()

    lazy var tableView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: UserCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: UserCell.cellIdentifier)
        return collectionView
    }()
    
    let viewModel: UsersViewModel
    
    init(viewModel: UsersViewModel){
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
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icoAdd"), style: .plain, target: self, action: nil)
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        animatedView?.isHidden = true
        animatedView?.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animatedView?.play()
        viewModel.viewWasLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (tableView.isHidden){
            animatedView?.isHidden = false
            animatedView?.play()
        }
        
        
    }
    
    /*override func view(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.viewWasLoaded()
    }*/
    
    fileprivate func showErrorFetchingUsersAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topics\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
}

extension UsersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = tableView.dequeueReusableCell(withReuseIdentifier: UserCell.cellIdentifier, for: indexPath) as? UserCell, let cellViewModel = viewModel.viewModel(at: indexPath){
            cell.viewModel = cellViewModel
            return cell
        }
        
        fatalError()
    }
    
}

extension UsersViewController: UICollectionViewDelegate {
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }*/
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

extension UsersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //var height: Float
        
        var letrasTotal = 0.0
        
        
        if let palabras = self.viewModel.viewModel(at: indexPath)?.textLabelText?.count {
            letrasTotal = Double(palabras)
        }
        
        let heightAux = (CGFloat(letrasTotal / 12) * (UIFont.textStyle.lineHeight) )
        let minHeighInset = CGFloat(9)
        let heightImage = viewModel.viewModel(at: indexPath)?.imageString?.size.height ?? 80
        
        let heightAux1 = CGFloat(heightAux + minHeighInset + heightImage)
        
        
        
        let valueAux1 = sectionRight * 2
        let valueAux2 = minimumInteritemSpacing
        //let valueAux3 = valueAux1 + (valueAux2 * (CGFloat(numberOfColumns) - 1))
        let valueAux4 = valueAux1 + (valueAux2 * (CGFloat(numberOfColumns) - 1))
        let valueAux5 = UIScreen.main.bounds.width - valueAux4
        
        
        let width: CGFloat = CGFloat(valueAux5) / CGFloat(numberOfColumns)
        
        
        return CGSize(width: width > 95 ? 95 : width, height: heightAux1 < 124 ? 124 : heightAux1)
    }
    
    
}


extension UsersViewController: UsersViewDelegate {
    func usersFetched() {
        tableView.isHidden = false
        tableView.reloadData()
        tableView.setNeedsLayout()
        if let animatedView = animatedView {
            animatedView.stop()
            animatedView.isHidden = true
        }
    }
    
    func errorFetchingUsers() {
        showErrorFetchingUsersAlert()
        animatedView?.stop()
        animatedView?.isHidden = true
    }
}
