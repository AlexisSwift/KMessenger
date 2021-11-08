import UIKit

// swiftlint:disable final_class
/// VisualEffectView is a dynamic background blur view.
open class VisualEffectView: UIVisualEffectView {

    /// Returns the instance of UIBlurEffect.
    /// Hidden API
    private let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()

    /**
        Tint color.
     
        The default value is nil.
    */
    open var colorTint: UIColor? {
        get { return _value(forKey: "colorTint") as? UIColor }
        set { _setValue(newValue, forKey: "colorTint") }
    }

    /**
        Tint color alpha.
        The default value is 0.0.
     */
    open var colorTintAlpha: CGFloat {
        get { return _value(forKey: "colorTintAlpha") as! CGFloat }
        set { _setValue(newValue, forKey: "colorTintAlpha") }
    }

    /**
     Blur radius.
     
     The default value is 0.0.
     */
    open var blurRadius: CGFloat {
        get { return _value(forKey: "blurRadius") as! CGFloat }
        set { _setValue(newValue, forKey: "blurRadius") }
    }

    /**
     Scale factor.
     
     The scale factor determines how content in the view is mapped from the logical coordinate space (measured in points) to the device coordinate space (measured in pixels).
     
     The default value is 1.0.
     */
    open var scale: CGFloat {
        get { return _value(forKey: "scale") as! CGFloat }
        set { _setValue(newValue, forKey: "scale") }
    }

    // MARK: - Initialization

    override public init(effect: UIVisualEffect?) {
        super.init(effect: effect)

        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    open func show() {
        self.effect = nil
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.effect = self?.blurEffect
        }
    }

    open func hide(completion: @escaping () -> Void) {
        UIView.animate(
            withDuration: 0.5,
            animations: { [weak self] in
                self?.effect = nil
            },
            completion: { isFinish in
                guard isFinish else { return }
                completion()
            }
        )
    }

    private func commonInit() {
        scale = 1
    }

    // MARK: - Helpers

    /// Returns the value for the key on the blurEffect.
    private func _value(forKey key: String) -> Any? {
        return blurEffect.value(forKeyPath: key)
    }

    /// Sets the value for the key on the blurEffect.
    private func _setValue(_ value: Any?, forKey key: String) {
        blurEffect.setValue(value, forKeyPath: key)
    }
}
