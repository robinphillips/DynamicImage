import UIKit

final class DynamicImageView: UIImageView {
    private let preferredMaxWidth: CGFloat
    private var contentSize: UIContentSizeCategory {
        didSet {
            maxWidth?.constant = self.adjustsImageSizeForAccessibilityContentSizeCategory ?
            self.preferredMaxWidth * SizeAdjustment.size(for: contentSize) :
            self.preferredMaxWidth
        }
    }

    private var maxWidth: NSLayoutConstraint?
    private var maxHeight: NSLayoutConstraint?
    
    private var ratio: CGFloat {
        guard let image else { return 1 }
        return image.size.height / image.size.width
    }
    
    init(
        image: UIImage,
        preferredWidth: CGFloat
    ) {
        let detectorLabel = UILabel()
        detectorLabel.font = .preferredFont(forTextStyle: .body)
        detectorLabel.adjustsFontForContentSizeCategory = true

        self.contentSize = detectorLabel.traitCollection.preferredContentSizeCategory
        
        self.preferredMaxWidth = preferredWidth
        super.init(image: image)
        self.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        self.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        maxWidth = self.adjustsImageSizeForAccessibilityContentSizeCategory ?
         self.widthAnchor.constraint(lessThanOrEqualToConstant: preferredMaxWidth * SizeAdjustment.size(for: contentSize)) :
         self.widthAnchor.constraint(lessThanOrEqualToConstant: preferredMaxWidth)

        maxHeight = self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: ratio)
        
        maxWidth?.priority = UILayoutPriority(950)
        maxHeight?.priority = UILayoutPriority(950)
        
        guard let maxWidth, let maxHeight else { return }
        NSLayoutConstraint.activate(
            [
                maxWidth,
                maxHeight,
            ]
        )
        
        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: nil, queue: nil) { value in

            guard let newValue = value.userInfo?["UIContentSizeCategoryNewValueKey"] as? UIContentSizeCategory else { return }
            self.contentSize = newValue
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
