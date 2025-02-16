import UIKit

class ViewController: UIViewController {
    let stack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let label = setUpLabel("Hello, World!")
        let imageView = setUpImage()
        let label2 = setUpLabel("This is a nice stack")
        let spacer = setUpSpacer()
        
        setUpStack()
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(label2)
        stack.addArrangedSubview(spacer)
    }
    
    func setUpImage() -> UIImageView {
        let imageView: UIImageView = UIImageView.dynamicImage(
            image: .sky,
            preferredWidth: 240
        )
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.orange.cgColor
        imageView.layer.borderWidth = 2
        imageView.backgroundColor = .orange.withAlphaComponent(0.1)
        
        return imageView
    }
    
    func setUpSpacer() -> UIView {
        let spacer = UIView()
        spacer.backgroundColor = .green
        spacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        spacer.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        spacer.layer.borderColor = UIColor.systemPink.cgColor
        spacer.layer.borderWidth = 2
        spacer.backgroundColor = .orange.withAlphaComponent(0.1)
        
        spacer.invalidateIntrinsicContentSize()
        return spacer
    }
    
    func configureImageConstraints(imageView: UIImageView) {
        NSLayoutConstraint.activate(
            [
                imageView.trailingAnchor.constraint(equalTo: stack.layoutMarginsGuide.trailingAnchor, constant: -16),
                imageView.bottomAnchor.constraint(equalTo:stack.layoutMarginsGuide.bottomAnchor, constant: 16)
            ]
        )
        
    }
    
    func setUpLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = (text)
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.borderWidth = 2
        label.backgroundColor = .blue.withAlphaComponent(0.1)
        label.numberOfLines = 0
        return label
    }
    
    func setUpStack() {
        view.addSubview(stack)
        
        stack.axis = .vertical
        stack.alignment = .top
        stack.backgroundColor = .secondarySystemBackground
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.borderColor = UIColor.red.cgColor
        stack.layer.borderWidth = 2
        
        NSLayoutConstraint.activate(
            [
                stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ]
        )
    }
}

#Preview {
    ViewController()
}
