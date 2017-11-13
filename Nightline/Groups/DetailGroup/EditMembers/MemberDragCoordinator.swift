//
//  MemberDragCoordinator.swift
//  Nightline
//
//  Created by cedric moreaux on 10/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

class MemberDragCoordinator {
    var source = EditMembersViewController.cv.members
    var sourceIndexPaths = [IndexPath]()
    var sourceIndexes: [Int] {
        get {
            return sourceIndexPaths.map { $0.item }
        }
    }
    var destination = EditMembersViewController.cv.members
    var destinationIndexPaths: [IndexPath]?
    var destinationIndexes: [Int] {
        get {
            return sourceIndexPaths.map { $0.item }
        }
    }
    var dragCompleted = false
    var isReordering: Bool {
        get {
            return source == destination
        }
    }
    var user = User()

    init(source: EditMembersViewController.cv) {
        self.source = source
    }

    func dragItemForMemberAt(indexPath: IndexPath) -> UIDragItem {
        sourceIndexPaths.append(indexPath)
        return UIDragItem(itemProvider: NSItemProvider())
    }

    func calculateDestinationIndexPaths(from indexPath: IndexPath, count: Int) {
        let indexes = Array(indexPath.item..<(indexPath.item + count))
        destinationIndexPaths = indexes.map { IndexPath(item: $0, section: 0)}
    }
}
