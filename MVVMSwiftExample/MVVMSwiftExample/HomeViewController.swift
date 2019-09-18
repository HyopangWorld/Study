//
//  HomeViewController.swift
//  MVVMSwiftExample
//
//  Created by Dino Bartosak on 25/09/16.
//  Copyright © 2016 Toptal. All rights reserved.
//
// GameScoreboardEditorViewcontroller을 제공하는 루트 뷰 컨트롤러

import UIKit

class HomeViewController: UIViewController {
    
    var gameLibrary: GameLibrary? {
        didSet {
            showGameScoreboardEditorViewController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showGameScoreboardEditorViewController()
    }
    
    // MARK: Private
    
    fileprivate func showGameScoreboardEditorViewController() {
        if !self.isViewLoaded {
            return
        }
        
        guard let gameLibrary = gameLibrary else {
            return
        }
        
        if gameLibrary.allGames().first != nil {
            
            let controller = UIStoryboard.loadGameScoreboardEditorViewController()
            
            // uncomment this when view model is implemented
//            let viewModel = GameScoreboardEditorViewModelFromGame(withGame: game)
//            controller.viewModel = viewModel
            
            self.insertChildController(controller, intoParentView: self.view)
        }
    }
}


