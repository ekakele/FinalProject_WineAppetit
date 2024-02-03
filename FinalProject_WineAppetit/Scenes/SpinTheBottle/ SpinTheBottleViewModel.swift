//
//   SpinTheBottleViewModel.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 03.02.24.
//

import Foundation
import UIKit

protocol SpinTheBottleViewModelDelegate: AnyObject {
    func didUpdateBottleRotation(_ rotation: CGFloat)
    func didEndBottleRotation()
    func didUpdateQuestion(_ question: String)
    func shouldShowLabel(_ show: Bool)
}

final class  SpinTheBottleViewModel {
    //MARK: - Properties
    private var lastRotation: CGFloat = 0.0
    private var angularVelocity: CGFloat = 0.0
    private var remainingQuestions: [String] = questionsArray
    weak var delegate: SpinTheBottleViewModelDelegate?
    
    //MARK: - Methods
    func handleBottlePanGesture(touchPoint: CGPoint, centerPoint: CGPoint, state: UIGestureRecognizer.State) {
        let currentAngle = atan2(touchPoint.y - centerPoint.y, touchPoint.x - centerPoint.x)
        
        switch state {
        case .began:
            lastRotation = currentAngle
            delegate?.shouldShowLabel(false)
        case .changed:
            let angleDifference = currentAngle - lastRotation
            angularVelocity = angleDifference
            delegate?.didUpdateBottleRotation(angleDifference)
            lastRotation = currentAngle
        case .ended, .cancelled:
            decelerateBottleRotation()
        default:
            break
        }
    }
    
    //MARK: - Private Methods
    private func decelerateBottleRotation() {
        let decelerationRate = CGFloat(0.95)
        let minimumVelocity = CGFloat(0.01)
        
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            self.angularVelocity *= decelerationRate
            self.delegate?.didUpdateBottleRotation(self.angularVelocity)
            
            if abs(self.angularVelocity) < minimumVelocity {
                timer.invalidate()
                self.presentRandomQuestion()
                self.delegate?.didEndBottleRotation()
            }
        }
    }
    
    private func presentRandomQuestion() {
        if remainingQuestions.isEmpty {
            remainingQuestions = questionsArray
        }
        
        let randomIndex = Int.random(in: 0..<remainingQuestions.count)
        let randomQuestion = remainingQuestions[randomIndex]
        remainingQuestions.remove(at: randomIndex)
        
        delegate?.didUpdateQuestion(randomQuestion)
        delegate?.shouldShowLabel(true)
    }
}
