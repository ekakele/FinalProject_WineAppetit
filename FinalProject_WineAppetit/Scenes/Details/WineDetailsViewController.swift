//
//  WineDetailsViewController.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 26.01.24.
//

import UIKit

final class WineDetailsViewController: UIViewController {
    //MARK: - Properties
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [upperStackView, lowerStackView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var upperStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemImageView, infoStackView])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        return stackView
    }()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        return imageView
    }()
    
    private lazy var infoStackView = ShortInfoStackView(
        arrangedSubviews: [mainTitleLabel, categoryStackView, brandLabel, infographicStackView],
        stackAlignment: .top,
        stackSpacing: 10
    )
    
    private let mainTitleLabel = CustomLabel(
        textColor: .label,
        font: Constants.AppFont.primaryTitle,
        numberOfLines: 3
    )
    
    private lazy var categoryStackView = ShortInfoStackView(
        arrangedSubviews: [categoryLabel, subcategoryLabel],
        axis: .horizontal,
        distribution: .equalCentering,
        stackSpacing: 6
    )
    
    private let categoryLabel = CustomLabel(
        textColor: Constants.AppColor.categoryText,
        font: Constants.AppFont.primaryInfo,
        numberOfLines: 1
    )
    
    private let subcategoryLabel = CustomLabel(
        textColor: Constants.AppColor.categoryText,
        font: Constants.AppFont.primaryInfo,
        numberOfLines: 1
    )
    
    private let brandLabel = CustomLabel(
        textColor: .label,
        font: Constants.AppFont.primaryInfo,
        numberOfLines: 1
    )
    
    private lazy var infographicStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [volumeInfographicStackView, degreeInfographicStackView, yearInfographicStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .top
        stackView.distribution = .equalCentering
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        return stackView
    }()
    
    private let volumeInfographicStackView = IconLabelStackView()
    private let degreeInfographicStackView = IconLabelStackView()
    private let yearInfographicStackView = IconLabelStackView()
    
    private let flaskIconImageView = InfographicIcon(systemName: "flask")
    private let thermometerIconImageView =  InfographicIcon(systemName: "thermometer.medium")
    private let calendarIconImageView =  InfographicIcon(systemName: "calendar.badge.clock")
    
    private let lowerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 40, bottom: 0, right: 40)
        stackView.backgroundColor = Constants.AppColor.detailsBackground
        stackView.layer.cornerRadius = 50
        stackView.layer.masksToBounds = true
        return stackView
    }()
    
    private let organolepticLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        return stackView
    }()
    
    private let organolepticIconStackView = OrganolepticIconStackView()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to My Wine Library", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = Constants.AppColor.buttonBackground
        button.layer.cornerRadius = 26
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private var viewModel: WineDetailsViewModel
    
    //MARK: - Inits
    init(wineID: Int) {
        viewModel = DefaultWineDetailsViewModel(wineID: wineID)
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        
        setupNavigationBar()
        setupUI()
    }
    
    //MARK: - Private Methods
    private func setupNavigationBar() {
        navigationItem.title = "Wine Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        if #available(iOS 17.0, *) {
            navigationItem.largeTitleDisplayMode = .inline
        } else {
            navigationItem.largeTitleDisplayMode = .automatic
        }
    }
    
    private func setupUI() {
        setupBackground()
        addSubviews()
        setupUpperLowerStackViewConstraints()
        setupMainStackViewConstraints()
    }
    
    private func setupBackground() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        volumeInfographicStackView.addArrangedSubview(flaskIconImageView)
        degreeInfographicStackView.addArrangedSubview(thermometerIconImageView)
        yearInfographicStackView.addArrangedSubview(calendarIconImageView)
        
        lowerStackView.addArrangedSubview(organolepticIconStackView)
        lowerStackView.addArrangedSubview(organolepticLabelStackView)
        lowerStackView.addArrangedSubview(addButton)
        
        view.addSubview(mainStackView)
    }
    
    private func setupButton() {
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: lowerStackView.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: lowerStackView.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: lowerStackView.bottomAnchor, constant: -50)
        ])
    }
    
    private func setupUpperLowerStackViewConstraints() {
        lowerStackView.setCustomSpacing(20, after: organolepticLabelStackView)
        
        NSLayoutConstraint.activate([
            lowerStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 8),
            lowerStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -8),
            
            upperStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor)
        ])
    }
    
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createInfographicLabel(text: String, addToStack stackView: UIStackView) {
        let label = UILabel()
        label.clipsToBounds = true
        label.text = text
        label.numberOfLines = 1
        label.textColor = .label
        label.font = Constants.AppFont.secondaryIconText
        label.textAlignment = .center
        
        stackView.addArrangedSubview(label)
    }
    
    private func createDescriptionStackView(title: String, detail: String) {
        let stackView = UIStackView()
        stackView.spacing = 40
        stackView.alignment = .leading
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .label
        titleLabel.font = Constants.AppFont.primarySubtitle
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let detailLabel = UILabel()
        detailLabel.text = detail
        detailLabel.textColor = .label
        titleLabel.font = Constants.AppFont.primarySubInfo
        detailLabel.numberOfLines = 2
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(detailLabel)
        
        lowerStackView.insertArrangedSubview(stackView, at: 0)
    }
    
    private func createOrganolepticInfoLabel(text: String, addToStack stackView: UIStackView) {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 4
        label.textColor = .white
        label.font = Constants.AppFont.primaryIconText
        label.textAlignment = .center
        label.backgroundColor = Constants.AppColor.iconBackground
        label.clipsToBounds = true
        label.layer.cornerRadius = 14
        label.heightAnchor.constraint(equalToConstant: 84).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        stackView.addArrangedSubview(label)
    }
}

extension WineDetailsViewController: WineDetailsViewModelDelegate {
    func wineDetailsFetched(_ wine: WineDetails) {
        Task {
            //Setup short info
            mainTitleLabel.text = wine.title
            categoryLabel.text = wine.categoriesList.first
            subcategoryLabel.text = wine.categoriesList[1]
            brandLabel.text = wine.brand
            
            //Setup infographics
            createInfographicLabel(
                text: wine.volume ?? Constants.AppTextInfo.notApplicable,
                addToStack: volumeInfographicStackView
            )
            createInfographicLabel(
                text: wine.alcohol ?? Constants.AppTextInfo.notApplicable,
                addToStack: degreeInfographicStackView
            )
            createInfographicLabel(
                text: wine.vintageYear ?? Constants.AppTextInfo.notApplicable,
                addToStack: yearInfographicStackView
            )
            
            //Setup description
            createDescriptionStackView(
                title: "Technology:",
                detail: wine.technology ?? Constants.AppTextInfo.notApplicable
            )
            createDescriptionStackView(
                title: "Grape:",
                detail: wine.grape ?? Constants.AppTextInfo.notApplicable
            )
            createDescriptionStackView(
                title: "Region:",
                detail: wine.region ?? Constants.AppTextInfo.notApplicable
            )
            
            //Setup organoleptic info
            createOrganolepticInfoLabel(
                text: wine.color ?? Constants.AppTextInfo.notApplicable,
                addToStack: organolepticLabelStackView
            )
            createOrganolepticInfoLabel(
                text: wine.aroma?.joined(separator: "\n") ?? Constants.AppTextInfo.notApplicable,
                addToStack: organolepticLabelStackView
            )
            createOrganolepticInfoLabel(
                text: wine.taste?.joined(separator: "\n") ?? Constants.AppTextInfo.notApplicable,
                addToStack: organolepticLabelStackView
            )
        }
    }
    
    func showError(_ error: Error) {
        print(error)
    }
    
    func wineImageFetched(_ image: UIImage) {
        Task {
            itemImageView.image = image
        }
    }
}
