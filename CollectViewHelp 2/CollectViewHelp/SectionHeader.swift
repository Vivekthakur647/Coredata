

import UIKit

class SectionHeader: UICollectionReusableView {
	@IBOutlet private weak var titleLabel: UILabel!
	
	var title: String? {
		didSet {
			titleLabel.text = title
		}
	}
}
