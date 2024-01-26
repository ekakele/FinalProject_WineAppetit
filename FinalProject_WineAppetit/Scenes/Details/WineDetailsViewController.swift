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
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20) //bottom = space under bottle
        //                        stackView.backgroundColor = .orange
        return stackView
    }()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.AppDefaultImage.wineImage
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
        distribution: .equalCentering
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
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        temporaryConfiguration()
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
        setupInfographicStackView()
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
    
    private func setupInfographicStackView() {
        //TODO: - to be used after fetching data (func createInfographicLabels())
        createInfographicLabel(text: "750 ml", addToStack: volumeInfographicStackView)
        createInfographicLabel(text: "14%", addToStack: degreeInfographicStackView)
        createInfographicLabel(text: "2021", addToStack: yearInfographicStackView)
    }
    
    
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //TODO: - to be used after fetching data
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
    //TODO: - to be used after fetching data
    //2 - დროებითი თვალსაჩინოებისთვის
    //    private func createInfographicLabels() {
    //        createInfographicLabel(text: "750 ml", addToStack: volumeInfographicStackView)
    //        createInfographicLabel(text: "14%", addToStack: degreeInfographicStackView)
    //        createInfographicLabel(text: "2021", addToStack: yearInfographicStackView)
    //    }
    
    //TODO: - to be used after fetching data
    private func createDescriptionStackView(title: String, detail: String) {
        let stackView = UIStackView()
        stackView.spacing = 40 //spacing in the row between columns
        stackView.alignment = .leading
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0) //padding of the column
        
        
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
        
        lowerStackView.addArrangedSubview(stackView)
        //        lowerStackView.addArrangedSubview(organolepticIconStackView)
        //        lowerStackView.addArrangedSubview(organolepticLabelStackView)
        //        lowerStackView.addArrangedSubview(addButton)
        
    }
    
    //TODO: - to be used after handling data
    //2 - დროებითი თვალსაჩინოებისთვის
    func setupDetailsStackView() {
        createDescriptionStackView(title: "Technology:", detail: "Qvevri")
        createDescriptionStackView(title: "Grape:", detail: "Saperavi")
        createDescriptionStackView(title: "Origin:", detail: "Khashmi")
        createDescriptionStackView(title: "Region:", detail: "Kakheti")
    }
    
    //TODO: - to be used after handling data
    //1
    func createOrganolepticInfoLabel(text: String, addToStack stackView: UIStackView) {
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
    
    //TODO: - to be used after handling data
    //2 - დროებითი თვალსაჩინოებისთვის
    private func createOrganolepticInfoLabels() {
        createOrganolepticInfoLabel(text: "Purplish", addToStack: organolepticLabelStackView)
        createOrganolepticInfoLabel(text: "Cherry \nPlum", addToStack: organolepticLabelStackView)
        createOrganolepticInfoLabel(text: "Cherry \nPlum", addToStack: organolepticLabelStackView)
    }
    
    func temporaryConfiguration() {
        mainTitleLabel.text = "Title"
        categoryLabel.text = "Red"
        subcategoryLabel.text = "Dry"
        brandLabel.text = "Badagoni"
        
        setupDetailsStackView()
        createOrganolepticInfoLabels()
        //        createInfographicLabels()
    }
}
