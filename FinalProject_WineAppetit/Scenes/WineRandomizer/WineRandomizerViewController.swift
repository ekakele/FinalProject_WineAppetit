//
//  WineRandomizerViewController.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 04.02.24.
//

import UIKit

final class WineRandomizerViewController: UIViewController {
    // MARK: - Properties
    private lazy var mainStackView = ShortInfoStackView(
        arrangedSubviews: [menuButtonsStackView, infoStackView, winePickerView, randomizeButton],
        distribution: .fillProportionally,
        stackSpacing: 10
    )
    
    private lazy var menuButtonsStackView = ShortInfoStackView(
        arrangedSubviews: [wineColorButton, sweetnessLevelButton, technologyButton, regionButton, resetButton],
        axis: .horizontal,
        distribution: .equalSpacing
    )
    
    private let wineColorButton = MenuButton(title: "Color")
    private let sweetnessLevelButton = MenuButton(title: "Sweetness")
    private let technologyButton = MenuButton(title: "Technology")
    private let regionButton = MenuButton(title: "Region")
    private let resetButton = IconButton(imageName: "arrow.counterclockwise")
    
    private lazy var infoStackView = ShortInfoStackView(
        arrangedSubviews: [titleLabel, brandLabel],
        distribution: .fill
    )
    
    private let titleLabel = CustomLabel(
        textColor: Constants.AppUIColor.labelText,
        font: Constants.AppUIFont.primaryTitle,
        numberOfLines: 2
    )
    
    private let brandLabel = CustomLabel(
        textColor: Constants.AppUIColor.labelText,
        font: Constants.AppUIFont.primaryInfo,
        numberOfLines: 2
    )
    
    private let winePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.layer.cornerRadius = 10
        pickerView.isUserInteractionEnabled = true
        return pickerView
    }()
    
    private let randomizeButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.setTitle("Randomize", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 11
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.backgroundColor = Constants.AppUIColor.iconBackground
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 2
        return button
    }()
    
    private var selectedWineColor: String?
    private var selectedSweetnessLevel: String?
    private var selectedTechnology: String?
    private var selectedRegion: String?
    
    private var pickerViewTapRecognizer = UITapGestureRecognizer()
    private let viewModel = WineRandomizerViewModel()
    private var wines: [Wine] = []
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarTitle()
        setupPickerViewTapRecognizer()
        setupViewModel()
        setupButtonActions()
        setupWinePickerView()
        setupMenus()
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupNavigationBarTitle() {
        NavigationBarManager.setupNavigationBar(for: self, title: "Random Wine Select")
    }
    
    private func setupPickerViewTapRecognizer() {
        pickerViewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickerViewTapped(_:)))
        pickerViewTapRecognizer.delegate = self
    }
    
    @objc func pickerViewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        let rowHeight = winePickerView.rowSize(forComponent: 0).height
        
        let selectedRowFrame = winePickerView.bounds.insetBy(
            dx: 0,
            dy: (winePickerView.frame.height - rowHeight) / 2
        )
        
        let userTappedOnSelectedRow = selectedRowFrame.contains(
            gestureRecognizer.location(in: winePickerView)
        )
        
        if userTappedOnSelectedRow {
            let selectedRow = winePickerView.selectedRow(inComponent: 0)
            navigateToWineDetails(with: wines[selectedRow].id)
        }
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    private func setupButtonActions() {
        setupResetButtonAction()
        setupRandomizeButtonAction()
    }
    
    private func setupResetButtonAction() {
        resetButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.resetFilters()
            }),
            for: .touchUpInside
        )
    }
    
    private func resetFilters() {
        selectedWineColor = nil
        wineColorButton.setTitle("Color", for: .normal)
        
        selectedSweetnessLevel = nil
        sweetnessLevelButton.setTitle("Sweetness", for: .normal)
        
        selectedTechnology = nil
        technologyButton.setTitle("Technology", for: .normal)
        
        selectedRegion = nil
        regionButton.setTitle("Region", for: .normal)
    }
    
    private func setupRandomizeButtonAction() {
        randomizeButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.filterWines()
            }),
            for: .touchUpInside
        )
    }
    
    private func filterWines() {
        viewModel.filterWines(
            with: selectedWineColor,
            subCategory: selectedSweetnessLevel,
            technology: selectedTechnology,
            region: selectedRegion
        )
    }
    
    private func setupWinePickerView() {
        winePickerView.delegate = self
        winePickerView.dataSource = self
        winePickerView.addGestureRecognizer(pickerViewTapRecognizer)
    }
    
    private func setupMenus() {
        wineColorButton.menu = createMenu(
            for: WineType.self,
            updatingButton: wineColorButton
        )
        
        sweetnessLevelButton.menu = createMenu(
            for: WineCategory.self,
            updatingButton: sweetnessLevelButton
        )
        
        technologyButton.menu = createMenu(
            for: WineTechnology.self,
            updatingButton: technologyButton
        )
        
        regionButton.menu = createMenu(
            for: WineRegion.self,
            updatingButton: regionButton
        )
    }
    
    private func createMenu<T: DropdownOption>(for type: T.Type, updatingButton button: UIButton) -> UIMenu {
        var actions: [UIAction] = []
        for value in type.allCases {
            let action = UIAction(title: value.rawValue) { [weak self] action in
                button.setTitle(value.rawValue, for: .normal)
                
                switch button {
                case self?.wineColorButton:
                    self?.selectedWineColor = value.rawValue
                case self?.sweetnessLevelButton:
                    self?.selectedSweetnessLevel = value.rawValue
                case self?.technologyButton:
                    self?.selectedTechnology = value.rawValue
                case self?.regionButton:
                    self?.selectedRegion = value.rawValue
                default:
                    break
                }
            }
            actions.append(action)
        }
        return UIMenu(title: "", children: actions)
    }
    
    private func setupUI() {
        setupBackground()
        addSubviews()
        setupMenuButtonConstraints()
        setupButtonConstraints()
        setupInfoStackView()
        setupMainStackViewConstraints()
    }
    
    private func setupBackground() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(mainStackView)
    }
    
    private func setupMenuButtonConstraints() {
        NSLayoutConstraint.activate([
            menuButtonsStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            menuButtonsStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            menuButtonsStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
    }
    
    private func setupButtonConstraints() {
        NSLayoutConstraint.activate([
            randomizeButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 100),
            randomizeButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -100)
        ])
    }
    
    private func setupInfoStackView() {
        infoStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
}

// MARK: - UIPickerViewDelegate
extension WineRandomizerViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { wines.count }
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
}

// MARK: - UIPickerViewDataSource
extension WineRandomizerViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat { 200 }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat { 200 }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var imageView: UIImageView
        if let view = view as? UIImageView {
            imageView = view
        } else {
            imageView = UIImageView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: pickerView.rowSize(forComponent: component).width,
                    height: pickerView.rowSize(forComponent: component).height
                ))
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
        }
        let wine = wines[row]
        ImageLoader.shared.displayImage(from: wine.image, in: imageView)
        return imageView
    }
}

// MARK: - UIGestureRecognizerDelegate
extension WineRandomizerViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - WineRandomizerViewModelDelegate
extension WineRandomizerViewController: WineRandomizerViewModelDelegate {
    func didFetchWines(_ wines: [Wine]) {
        self.wines = wines
        DispatchQueue.main.async {
            self.winePickerView.reloadAllComponents()
            self.randomizeWineSelection()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    func navigateToWineDetails(with wineID: Int) {
        let viewController = WineDetailsViewController(wineID: wineID)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func randomizeWineSelection() {
        guard !wines.isEmpty else {
            titleLabel.text = "No wines found"
            brandLabel.text = "for the selected filter criteria"
            return
        }
        
        let maxRow = max(wines.count - 1, 0)
        let randomRow = Int.random(in: 0...maxRow)
        winePickerView.selectRow(randomRow, inComponent: 0, animated: true)
        
        if maxRow >= 0 {
            let selectedWine = wines[randomRow]
            titleLabel.text = selectedWine.title
            brandLabel.text = "Produced by \(selectedWine.brand ?? "N/A")"
        }
    }
}
