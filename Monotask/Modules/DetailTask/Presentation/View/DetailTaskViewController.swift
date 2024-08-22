//
//  DetailTaskViewController.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import Foundation
import UIKit

protocol DetailTaskViewControllerDelegate {
    func didDeleteButtonTapped(task: TaskModel)
    func didCloseButtonTapped()
    func didEditTaskbuttonTapped()
}

class DetailTaskViewController: UIViewController {
    
    private var taskNameLabel: UILabel!
    private var subtaskCollectionView: UICollectionView!
    private let deleteButton = DeleteButton()
    private let closeButton = CloseButton()
    private let editButton = EditButton()
    private var horizontalStackView = UIStackView()
    
    private let task: TaskModel
    var delegate: DetailTaskViewControllerDelegate?
    
    init(task: TaskModel) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHorizontalStackView()
        setupTaskNameLabel()
        setupEditButton()
        setupSubtasksCollectionView()
    }
    
    private func setupHorizontalStackView() {
        let spacer = createHorizontalSpacer()
        setupCloseButton()
        setupDeleteButton()
        
        horizontalStackView = UIStackView(arrangedSubviews: [deleteButton, spacer, closeButton])
        horizontalStackView.axis = .horizontal
        
        view.addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 31),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -31),
            horizontalStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupTaskNameLabel() {
        taskNameLabel = UILabel()
        let underlinedAttribute = NSAttributedString(string: task.taskName,
                                                  attributes: [
                                                    .font: UIFont.oswaldLargeTitle,
                                                    .underlineStyle: NSUnderlineStyle.single.rawValue
                                                  ])
        taskNameLabel.attributedText = underlinedAttribute
        taskNameLabel.text = task.taskName
        taskNameLabel.numberOfLines = 0
        taskNameLabel.textColor = .black
        taskNameLabel.textAlignment = .center
        
        view.addSubview(taskNameLabel)
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 50),
            taskNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 31),
            taskNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -31)

        ])
    }
    
    private func setupEditButton() {
        editButton.addTarget(self, action: #selector(editTaskButtonTapped), for: .touchUpInside)
        
        view.addSubview(editButton)
        NSLayoutConstraint.activate([
            editButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editButton.heightAnchor.constraint(equalToConstant: 53),
            editButton.widthAnchor.constraint(equalToConstant: 137)
        ])
    }
    
    private  func setupDeleteButton() {
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            deleteButton.widthAnchor.constraint(equalToConstant: 44),
            deleteButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupSubtasksCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        subtaskCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        subtaskCollectionView.register(SubtaskCell.self, forCellWithReuseIdentifier: "SubtaskCell")
        subtaskCollectionView.backgroundColor = .white
        subtaskCollectionView.dataSource = self
        subtaskCollectionView.delegate = self
        
        view.addSubview(subtaskCollectionView)
        subtaskCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtaskCollectionView.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 10),
            subtaskCollectionView.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor),
            subtaskCollectionView.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor),
            subtaskCollectionView.bottomAnchor.constraint(equalTo: editButton.topAnchor, constant: -10)
        ])
    }
    
    private func createHorizontalSpacer() -> UIView {
        let spacer = UIView()
        // maximum width constraint
        let spacerWidthConstraint = spacer.widthAnchor.constraint(equalToConstant: .greatestFiniteMagnitude) // or some very high constant
        spacerWidthConstraint.priority = .defaultLow // ensures it will not "overgrow"
        spacerWidthConstraint.isActive = true
        return spacer
    }
}

// MARK: - Button Actions
extension DetailTaskViewController {
    @objc private func editTaskButtonTapped() {
        delegate?.didEditTaskbuttonTapped()
    }
    
    @objc private func closeButtonTapped() {
        delegate?.didCloseButtonTapped()
    }
    
    @objc private func deleteButtonTapped() {
        delegate?.didDeleteButtonTapped(task: task)
    }
}


// MARK: - UICollectionViewDataSource
extension DetailTaskViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return task.subtasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubtaskCell", for: indexPath) as! SubtaskCell
        cell.configure(with: task.subtasks[indexPath.item])
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension DetailTaskViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 30)
    }
}

class SubtaskCell: UICollectionViewCell {
    
    private let subtaskLabel: UILabel = {
        let label = UILabel()
        label.font = .oswaldTitle3
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(subtaskLabel)
        
        // Subtask Label Constraints
        NSLayoutConstraint.activate([
            subtaskLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with task: String) {
        subtaskLabel.text = "• \(task)"
    }
}


class SubtaskLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel() {
        translatesAutoresizingMaskIntoConstraints = false
        font = .oswaldTitle3
        textColor = .black
    }
}

class EditButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .black
        tintColor = .white
    
        titleLabel?.font = .oswaldTitle2
        setTitleColor(.lightGray, for: .highlighted)
        setTitle("Edit  Task", for: .normal)
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
        let iconImage = UIImage(systemName: "pencil", withConfiguration: configuration)
        setImage(iconImage, for: .normal)
        
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 0)
    
        layer.cornerRadius = 30
    }
}

#warning("TODO: Refactor this circle button so that it resubles")
class DeleteButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .black
        tintColor = .white
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold, scale: .default)
        let iconImage = UIImage(systemName: "trash", withConfiguration: configuration)
        setImage(iconImage, for: .normal)
    
        layer.cornerRadius = 22
        clipsToBounds = true
    }
}

class CloseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .black
        tintColor = .white
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold, scale: .default)
        let iconImage = UIImage(systemName: "xmark", withConfiguration: configuration)
        setImage(iconImage, for: .normal)
    
        layer.cornerRadius = 22
        clipsToBounds = true
    }
}
