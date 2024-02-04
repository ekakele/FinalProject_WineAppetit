//
//  SpinTheBottleViewController.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 03.02.24.
//

import UIKit
import AVFoundation

class SpinTheBottleViewController: UIViewController {
    // MARK: - Properties
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.AppUIImage.bottleBackground
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
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelBackgroundView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        view.layer.cornerRadius = 12
        view.isHidden = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewModel = SpinTheBottleViewModel()
    private var player: AVAudioPlayer!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupBottlePanGestureRecognizer()
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    private func setupBottlePanGestureRecognizer() {
        bottleImage.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleBottlePanGesture(_:)))
        bottleImage.addGestureRecognizer(panGesture)
    }
    
    @objc private func handleBottlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let touchPoint = gesture.location(in: view)
        let centerPoint = bottleImage.center
        let state = gesture.state
        
        viewModel.handleBottlePanGesture(touchPoint: touchPoint, centerPoint: centerPoint, state: state)
    }
    
    private func hideLabelText() {
        questionLabel.isHidden = true
        labelBackgroundView.isHidden = true
    }
    
    private func showLabelText() {
        questionLabel.isHidden = false
        labelBackgroundView.isHidden = false
    }
    
    private func playSound() {
        let url = Bundle.main.url(forResource: "popSound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    private func setupUI() {
        addSubviews()
        setupQuestionLabelConstraints()
        setupLabelViewConstraints()
        setupBottleImageConstraints()
        setupBackgroundImageConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        view.addSubview(bottleImage)
        
        view.addSubview(labelBackgroundView)
        labelBackgroundView.contentView.addSubview(questionLabel)
    }
    
    private func setupQuestionLabelConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: labelBackgroundView.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: labelBackgroundView.trailingAnchor, constant: -20),
            questionLabel.topAnchor.constraint(equalTo: labelBackgroundView.topAnchor, constant: 20),
            questionLabel.bottomAnchor.constraint(equalTo: labelBackgroundView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupLabelViewConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 260),
            questionLabel.widthAnchor.constraint(equalToConstant: 300),
            questionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
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
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - SpinTheBottleViewModelDelegate
extension SpinTheBottleViewController: SpinTheBottleViewModelDelegate {
    func didUpdateBottleRotation(_ rotation: CGFloat) {
        bottleImage.transform = bottleImage.transform.rotated(by: rotation)
    }
    
    func didEndBottleRotation() {
        playSound()
    }
    
    func didUpdateQuestion(_ question: String) {
        questionLabel.text = question
    }
    
    func shouldShowLabel(_ show: Bool) {
        questionLabel.isHidden = !show
        labelBackgroundView.isHidden = !show
    }
}
