// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import Foundation
import SnapKit

class ChatTableHeaderView: UIView {
    enum State {
        case none
        case friendTyping
        case fauxOfflineMessagingEnabled
    }

    var state = State.none {
        didSet {
            didUpdateState()
        }
    }

    fileprivate var label: UILabel!
    fileprivate var labelZeroHeightConstraint: Constraint!

    init() {
        super.init(frame: CGRect.zero)

        createViews()
        installConstraints()
        didUpdateState()
    }

    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ChatTableHeaderView {
    func createViews() {
        label = UILabel()
        label.numberOfLines = 0
        addSubview(label)
    }

    func installConstraints() {
        label.snp.makeConstraints {
            $0.edges.equalTo(self)
            labelZeroHeightConstraint = $0.height.equalTo(0).constraint
        }
    }

    func didUpdateState() {
        switch state {
            case .none:
                labelZeroHeightConstraint.activate()
            case .friendTyping:
                labelZeroHeightConstraint.deactivate()
                label.text = "Friend is typing"
            case .fauxOfflineMessagingEnabled:
                labelZeroHeightConstraint.deactivate()
                label.text = "There are pending offline messages. They will be send when both you and friend are online."
        }
    }
}
