//
//  SceneDelegate.swift
//  Pokemons
//
//  Created by Давид Тоноян  on 15.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "pokemonList")
        let navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

