//
//  SpinTheBottleViewController.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 03.02.24.
//

import UIKit

class SpinTheBottleViewController: UIViewController {
    //MARK: - Properties
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.AppUIImage.tableclothBackground
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bottleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.AppUIImage.wineBottle
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = CGSize(width: 2, height: 2)
        imageView.layer.shadowRadius = 5
        
        return imageView
    }()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        addSubviews()
        setupBottleImageConstraints()
        setupBackgroundImageConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        view.addSubview(bottleImage)
    }
    
    private func setupBottleImageConstraints() {
        NSLayoutConstraint.activate([
            bottleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottleImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupBackgroundImageConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
