//
//  SpinTheBottleViewModel.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 03.02.24.
//

import UIKit
import AVFoundation

protocol SpinTheBottleViewModelDelegate: AnyObject {
    func didUpdateBottleRotation(_ rotation: CGFloat)
    func didUpdateQuestion(_ question: String)
    func shouldShowLabel(_ show: Bool)
}

final class SpinTheBottleViewModel {
    // MARK: - Properties
    private var lastRotation: CGFloat = 0.0
    private var angularVelocity: CGFloat = 0.0
    private var randomQuestionsArray = GameData.questionsArray.shuffled()
    private var player: AVAudioPlayer?
    weak var delegate: SpinTheBottleViewModelDelegate?
    
    // MARK: - Methods
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
    
    // MARK: - Private Methods
    private func decelerateBottleRotation() {
        let decelerationRate = CGFloat(0.95)
        let minimumVelocity = CGFloat(0.01)
        
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            angularVelocity *= decelerationRate
            delegate?.didUpdateBottleRotation(angularVelocity)
            
            if abs(self.angularVelocity) < minimumVelocity {
                timer.invalidate()
                presentRandomQuestion()
                playSound()
            }
        }
    }
    
    private func presentRandomQuestion() {
        if randomQuestionsArray.isEmpty {
            refillQuestionsArray()
            presentNextQuestion()
        } else {
            presentNextQuestion()
        }
        delegate?.shouldShowLabel(true)
    }
    
    private func presentNextQuestion() {
        let question = randomQuestionsArray.removeFirst()
        delegate?.didUpdateQuestion(question)
    }
    
    private func refillQuestionsArray() {
        randomQuestionsArray = GameData.questionsArray.shuffled()
    }
    
    private func playSound() {
        guard let url = Bundle.main.url(
            forResource: "popSound",
            withExtension: "mp3"
        ) else {
            print("Error: Sound file not found")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
