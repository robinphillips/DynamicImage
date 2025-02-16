import UIKit

extension UIImageView {
    static func dynamicImage(
        image: UIImage,
        preferredWidth: CGFloat
    ) -> UIImageView {
        DynamicImageView(
            image: image,
            preferredWidth: preferredWidth
        )
    }
}
