//
//  CalorieCounterViewController.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 29.01.24.
//

import UIKit

class CalorieCounterViewController: UIViewController {
    //MARK: - Properties
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.AppDefaultImage.calorieCounterBackground
        imageView.contentMode = .scaleAspectFill
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.1
        imageView.layer.shadowRadius = 1.5
        imageView.layer.masksToBounds = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradient
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let counterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let glassNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
        label.textColor = .label.withAlphaComponent(0.8)
        return label
    }()
    
    private let calorieCounterLabel: UILabel = {
        let label = UILabel()
        label.text = "Start counting"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 2
        label.textColor = .label
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let winePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private let incrementButton = IconButton(imageName: "plus")
    private let decrementButton = IconButton(imageName: "minus")
    private let resetButton = IconButton(imageName: "arrow.counterclockwise")
    
    private var glassNumber = 0
    private var selectedWineTypeIndex = 0
    private var selectedWineCategoryIndex = 0
    
    private let viewModel = CalorieCounterViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupWinePickerView()
        setupButtonActions()
        setupUI()
    }
    
    //MARK: - Private Methods
    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    private func setupWinePickerView() {
        winePickerView.dataSource = self
        winePickerView.delegate = self
    }
    
    private func setupButtonActions() {
        setupDecrementButtonAction()
        setupIncrementButtonAction()
        setupResetButtonAction()
    }
    
    private func setupDecrementButtonAction() {
        decrementButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.viewModel.decrementGlassNumber()
                self?.updateLabels()
            }),
            for: .touchUpInside
        )
    }
    
    private func setupIncrementButtonAction() {
        incrementButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.viewModel.incrementGlassNumber()
                self?.updateLabels()
            }),
            for: .touchUpInside
        )
    }
    
    private func setupResetButtonAction() {
        resetButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.viewModel.resetGlassNumber()
                self?.updateLabels()
            }),
            for: .touchUpInside
        )
    }
    
    private func updateLabels() {
        let glassNumber = viewModel.glassNumber
        
        guard glassNumber > 0 else {
            glassNumberLabel.text = "0"
            calorieCounterLabel.text = "Start counting"
            return
        }
        
        let totalCalories = viewModel.calculateTotalCalories()
        
        let typeIndex = viewModel.selectedWineTypeIndex
        let categoryIndex = viewModel.selectedWineCategoryIndex
        
        let wineType = viewModel.wineTypes[typeIndex].rawValue
        let wineCategory = viewModel.wineCategories[categoryIndex].rawValue
        
        let glassUnit = glassNumber == 1 ? "Glass" : "Glasses"
        let verb = glassNumber == 1 ? "equals" : "equal"
        
        let caloriesInfo = "\(glassUnit) of \(wineCategory) \(wineType) Wine \(verb) \(totalCalories) calories"
        
        glassNumberLabel.text = "\(glassNumber)"
        calorieCounterLabel.text = caloriesInfo
    }
    
    private func selectedWineCalories() -> CalorieInfo? {
        let selectedWineType = WineType.allCases[selectedWineTypeIndex]
        return wineCalories[selectedWineType]?[selectedWineCategoryIndex]
    }
    
    private func calculateCalories(glassNumber: Int, calorieInfo: CalorieInfo) -> Int {
        return glassNumber * calorieInfo.calories
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        setupBackground()
        addSubviews()
        setupCounterStackViewConstraints()
        setupMainStackViewConstraints()
    }
    
    private func setupBackground() {
        setupBackgroundImage()
        setupGradientBackground()
    }
    
    private func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.layer.zPosition = 1
        setupBackgroundImageConstraints()
    }
    
    private func setupBackgroundImageConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupGradientBackground() {
        view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = view.frame //view VS bounds??
        
        updateBackgroundForWineType()
    }
    
    private func updateBackgroundForWineType() {
        let index = viewModel.selectedWineTypeIndex
        let selectedWineType = viewModel.wineTypes[index]
        
        let colorSet = selectedWineType.backgroundColors
        gradientLayer.colors = colorSet
    }
    
    private func addSubviews() {
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(counterStackView)
        mainStackView.addArrangedSubview(calorieCounterLabel)
        mainStackView.addArrangedSubview(resetButton)
        mainStackView.addArrangedSubview(winePickerView)
        
        counterStackView.addArrangedSubview(decrementButton)
        counterStackView.addArrangedSubview(glassNumberLabel)
        counterStackView.addArrangedSubview(incrementButton)
    }
    
    private func setupCounterStackViewConstraints() {
        NSLayoutConstraint.activate([
            counterStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 100),
            counterStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -100),
        ])
    }
    
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 130),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


//1 glass = 148ml
//MARK: - UIPickerView DataSource
extension CalorieCounterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return  WineType.allCases.count
        } else {
            let selectedWineType = WineType.allCases[selectedWineTypeIndex]
            return wineCalories[selectedWineType]?.count ?? 0
        }
    }
}

//MARK: - UIPickerView Delegate
extension CalorieCounterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return WineType.allCases[row].rawValue
        } else {
            let selectedWineType = WineType.allCases[selectedWineTypeIndex]
            return wineCalories[selectedWineType]?[row].description ?? "Unknown Category"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            viewModel.updateSelectedWineType(index: row)
            pickerView.reloadComponent(1)
            updateBackgroundForWineType()
        } else {
            viewModel.updateSelectedWineCategory(index: row)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label: UILabel
        if let reuseLabel = view as? UILabel {
            label = reuseLabel
        } else {
            label = UILabel()
        }
        
        label.text = component == 0 ? viewModel.wineTypes[row].rawValue : viewModel.wineCategories[row].rawValue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }
}

// MARK: - CalorieCounterViewModelDelegate Methods
extension CalorieCounterViewController: CalorieCounterViewModelDelegate {
    func didUpdateGlassNumber(_ viewModel: CalorieCounterViewModel) {
        updateLabels()
    }
    
    func didUpdateWineSelection(_ viewModel: CalorieCounterViewModel) {
        updateBackgroundForWineType()
        updateLabels()
    }
}
