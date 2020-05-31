//
//  TopicsViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation


/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol TopicsCoordinatorDelegate: class {
    func didSelect(topic: Topic)
    func topicsPlusButtonTapped()
}

protocol AddButtonTopicView {
    func addTopicsButtonTapped()
}

/// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol TopicsViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics()
}

struct userTopic {
    let userId: Int
    let avatar: String?
}

/// ViewModel que representa un listado de topics
class TopicsViewModel {
    weak var coordinatorDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    let topicsDataManager: TopicsDataManager
    var topicViewModels: [TopicCellViewModelBase] = []
    var userTopicList: [userTopic] = []
    init(topicsDataManager: TopicsDataManager) {
        self.topicsDataManager = topicsDataManager
    }

    func viewWasLoaded() {
        /** TODO: DONE
         Recuperar el listado de latest topics del dataManager
         Asignar el resultado a la lista de viewModels (que representan celdas de la interfaz
         Avisar a la vista de que ya tenemos topics listos para pintar
         */
        
        topicsDataManager.fetchAllTopics {[weak self] (result) in
            guard let self = self else {
                return
            }
            self.topicViewModels = []
            
            let topicCellViewModelBienvenida = TopicCellViewModelBienvenida()
            self.topicViewModels.append(topicCellViewModelBienvenida)
            
                
            switch result {
                case .success(let topics):
                    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    if let topics = topics {
                        
                            guard let self = self else {return}
                            
                            for user in topics.users {
                                self.userTopicList.append(userTopic(userId: user.id, avatar: user.avatarTemplate))
                            }
                            
                            for topic in topics.topicList.topics {
                            let userIndex = self.userTopicList.firstIndex { (user) -> Bool in
                                user.userId == topic.posters.last?.userId
                            }
                            
                            var dataSelected: Data? = nil
                            if let index = userIndex {
                                if let photo = self.userTopicList[index].avatar {
                                    let formatURL = photo.replacingOccurrences(of: "{size}", with: "64")
                                    let url = URL(string: apiURL + formatURL)
                                    if let urlFormated = url {
                                        if let data = try? Data(contentsOf: urlFormated) {
                                            dataSelected = data
                                        }
                                    }
                                }
                            }
                            
                            let topicViewModelAux = TopicCellViewModel(topic: topic, imagen: dataSelected)
                            self.topicViewModels.append(topicViewModelAux)
                        }
                        
                            
                    }
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else {
                            return
                        }
                        self.viewDelegate?.topicsFetched()
                    }
                }
                
                    
                case .failure(_):
                    self.viewDelegate?.errorFetchingTopics()
                }
        }
        
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return topicViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> TopicCellViewModelBase? {
        guard indexPath.row < topicViewModels.count else { return nil }
        return topicViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < topicViewModels.count else { return }
        if let topicViewModel = topicViewModels[indexPath.row] as? TopicCellViewModel {
            coordinatorDelegate?.didSelect(topic: topicViewModel.topic)
        }
        
    }

    func plusButtonTapped() {
        coordinatorDelegate?.topicsPlusButtonTapped()
    }

    func newTopicWasCreated() {
        // TODO: Seguramente debamos recuperar de nuevo los topics del datamanager, y pintarlos de nuevo
        viewWasLoaded()
    }
}
