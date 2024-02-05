//
//  WineRandomizerViewController.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 04.02.24.
//

import UIKit

class WineRandomizerViewController: UIViewController {
    // MARK: - Properties
    private lazy var mainStackView = ShortInfoStackView(
        arrangedSubviews: [infoStackView, winePickerView, randomizerButton],
        distribution: .fill,
        stackSpacing: 10
    )
    
    private lazy var infoStackView = ShortInfoStackView(
        arrangedSubviews: [titleLabel, brandLabel],
        distribution: .fill,
        stackAlignment: .center,
        stackSpacing: 6
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
//        pickerView.backgroundColor = .orange.withAlphaComponent(0.5)
        return pickerView
    }()
    
    private let randomizerButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.setTitle("Randomize", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 18
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.backgroundColor = .red.withAlphaComponent(0.6)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        return button
    }()
    
    private let viewModel = WineListViewModel()
    private var wines: [Wine] = []
    private var pickerViewTapRecognizer = UITapGestureRecognizer()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupPickerViewTapRecognizer()
        setupViewModel()
        setupWinePickerView()
        setupUI()
        setupButtonAction()
    }
    
    // MARK: - Private Methods
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
    
    private func setupButtonAction() {
        randomizerButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.spinSlots()
            }),
            for: .touchUpInside
        )
    }
    
    private func spinSlots() {
        let maxRow = max(wines.count - 1, 0)
        let randomRow = Int.random(in: 0...maxRow)
        winePickerView.selectRow(randomRow, inComponent: 0, animated: true)
        
        if maxRow >= 0 {
            let selectedWine = wines[randomRow]
            titleLabel.text = selectedWine.title
            brandLabel.text = "Produced by \(selectedWine.brand ?? "N/A")"
        }
    }
    
    private func setupWinePickerView() {
        winePickerView.delegate = self
        winePickerView.dataSource = self
        winePickerView.addGestureRecognizer(pickerViewTapRecognizer)
    }
    
    private func setupUI() {
        setupBackground()
        addSubviews()
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
    
    private func setupButtonConstraints() {
        NSLayoutConstraint.activate([
            randomizerButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 100),
            randomizerButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -100)
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

// MARK: - WineListViewModelDelegate
extension WineRandomizerViewController: WineListViewModelDelegate {
    func winesFetched(_ wines: [Wine]) {
        self.wines = wines
        DispatchQueue.main.async {
            self.winePickerView.reloadAllComponents()
        }
    }
    
    func showError(_ error: Error) {
        print(error)
    }
    
    func navigateToWineDetails(with wineID: Int) {
        let viewController = WineDetailsViewController(wineID: wineID)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
