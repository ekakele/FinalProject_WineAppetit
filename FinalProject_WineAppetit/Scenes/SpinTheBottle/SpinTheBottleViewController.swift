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
    
    private var lastRotation: CGFloat = 0.0
    private var angularVelocity: CGFloat = 0.0
    private var remainingQuestions = questionsArray
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottlePanGestureRecognizer()
        setupUI()
    }
    
    //MARK: - Private Methods
    private func setupBottlePanGestureRecognizer() {
        bottleImage.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleBottlePanGesture(_:)))
        bottleImage.addGestureRecognizer(panGesture)
    }
    
    @objc private func handleBottlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let touchPoint = gesture.location(in: view)
        let centerPoint = bottleImage.center
        
        let currentAngle = atan2(touchPoint.y - centerPoint.y, touchPoint.x - centerPoint.x)
        
        switch gesture.state {
        case .began:
            lastRotation = currentAngle
            hideLabelText()
        case .changed:
            let angleDifference = currentAngle - lastRotation
            angularVelocity = angleDifference
            bottleImage.transform = bottleImage.transform.rotated(by: angleDifference)
            lastRotation = currentAngle
        case .ended, .cancelled:
            decelerateBottleRotation()
        default:
            break
        }
    }
    
    private func decelerateBottleRotation() {
        let decelerationRate = CGFloat(0.95)
        let minimumVelocity = CGFloat(0.01)
        
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            self.angularVelocity *= decelerationRate
            self.bottleImage.transform = self.bottleImage.transform.rotated(by: self.angularVelocity)
            
            if abs(self.angularVelocity) < minimumVelocity {
                timer.invalidate()
                presentRandomQuestion()
            }
        }
    }
    
    private func presentRandomQuestion() {
        
        if remainingQuestions.isEmpty {
            remainingQuestions = questionsArray
        }
        
        let randomIndex = Int.random(in: 0..<remainingQuestions.count)
        let randomQuestion = remainingQuestions[randomIndex]
        let removedQuestion = remainingQuestions.remove(at: randomIndex)
        
        questionLabel.text = randomQuestion
        showLabelText()
    }
    
    func hideLabelText() {
        questionLabel.isHidden = true
        labelBackgroundView.isHidden = true
    }
    
    func showLabelText() {
        questionLabel.isHidden = false
        labelBackgroundView.isHidden = false
    }
    
    //MARK: - UI Setup
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
            questionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 300),
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
