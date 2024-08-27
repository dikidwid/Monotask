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
    private let deleteButton: CircularButton = CircularButton(iconName: "trash")
    private let closeButton: CircularButton = CircularButton(iconName: "xmark")
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
        setupCloseButton()
        setupDeleteButton()
        setupTaskNameLabel()
        setupEditButton()
        setupSubtasksCollectionView()
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
            taskNameLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 30),
            taskNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            taskNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)

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
        
        view.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            deleteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            deleteButton.widthAnchor.constraint(equalToConstant: 44),
            deleteButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupSubtasksCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
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
        
        // Get the subtask for the current index
        let subtask = task.subtasks[indexPath.item]
        
        // Configure a temporary UILabel to calculate its height
        let label = UILabel()
        label.numberOfLines = 0 // Allow the label to have multiple lines
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = subtask
        
        // Calculate the height of the label based on its content
        let maxSize = CGSize(width: collectionView.frame.width / 1.5, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = label.sizeThatFits(maxSize)
        
        // Return the size of the cell, including some padding
        return CGSize(width: collectionView.frame.width, height: labelSize.height + 16) // Adding padding for top and bottom
    }
}
