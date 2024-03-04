//
//  SpinTheBottleViewController.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 03.02.24.
//

import UIKit

final class SpinTheBottleViewController: UIViewController {
    // MARK: - Properties
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.AppUIImage.bottleBackground
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bottleImage: UIImageView = {
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
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelBackgroundView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        view.layer.cornerRadius = 12
        view.isHidden = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewModel = SpinTheBottleViewModel()
    
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
    
    private func setupUI() {
        addSubviews()
        setupQuestionLabelConstraints()
        setupLabelBackgroundViewConstraints()
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
            questionLabel.leadingAnchor.constraint(equalTo: labelBackgroundView.leadingAnchor, constant: 12),
            questionLabel.trailingAnchor.constraint(equalTo: labelBackgroundView.trailingAnchor, constant: -12),
            questionLabel.topAnchor.constraint(equalTo: labelBackgroundView.topAnchor, constant: 12),
            questionLabel.bottomAnchor.constraint(equalTo: labelBackgroundView.bottomAnchor, constant: -12)
        ])
    }
    
    private func setupLabelBackgroundViewConstraints() {
        NSLayoutConstraint.activate([
            labelBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelBackgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 260),
            labelBackgroundView.widthAnchor.constraint(equalToConstant: 300),
            labelBackgroundView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
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

// MARK: - SpinTheBottleViewModelDelegate Methods
extension SpinTheBottleViewController: SpinTheBottleViewModelDelegate {
    func didUpdateBottleRotation(_ rotation: CGFloat) {
        DispatchQueue.main.async {
            self.bottleImage.transform = self.bottleImage.transform.rotated(by: rotation)
        }
    }
    
    func didUpdateQuestion(_ question: String) {
        DispatchQueue.main.async {
            self.questionLabel.text = question
        }
    }
    
    func shouldShowLabel(_ show: Bool) {
        DispatchQueue.main.async {
            self.questionLabel.isHidden = !show
            self.labelBackgroundView.isHidden = !show
        }
    }
}
