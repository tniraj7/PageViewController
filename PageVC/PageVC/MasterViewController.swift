import UIKit

class MasterViewController: UIViewController {

    var navigationView = UIView()
    
    var leftButton: UIButton = {
        let btn = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: UIImage.SymbolWeight(rawValue: 30)!)
        let image = UIImage(systemName: "chevron.left.circle", withConfiguration: config)
        btn.setImage(image, for: .normal)
        btn.tintColor = .systemBlue
        return btn
    }()
    
    var rightButton: UIButton = {
        let btn = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: UIImage.SymbolWeight(rawValue: 30)!)
        let image = UIImage(systemName: "chevron.right.circle", withConfiguration: config)
         btn.setImage(image, for: .normal)
        btn.tintColor = .systemBlue
        return btn
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2020/30/01"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .largeTitle), size: 20)
        return label
    }()
    
    let pageVC = PageViewController()
    
    let colors = [UIColor.yellow, UIColor.cyan, UIColor.green,UIColor.yellow, UIColor.cyan, UIColor.green,UIColor.yellow, UIColor.cyan, UIColor.green,UIColor.yellow, UIColor.cyan, UIColor.green]
    var pages =  [UIViewController]()
    var currentViewControllerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
    }

    @IBAction func goToPreviousRaceTrack(_ sender: Any) {
        var index: Int = currentViewControllerIndex
    }

    @IBAction func goToNextRaceTrack(_ sender: Any) {
         print("Tapped!")
    }
    
    private func configureNavigationView() {
        self.view.addSubview(navigationView)
        navigationView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configurePageViewController() {
        
        pageVC.dataSource = self
        pageVC.delegate = self
        
        self.addChild(pageVC)
        self.view.addSubview(pageVC.view)
        pageVC.didMove(toParent: self)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        let views : [String: Any] = [
            "pageView": pageVC.view!,
            "navView": navigationView
        ]
        
        var allConstraints = [NSLayoutConstraint]()
        
        let navViewConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[navView]|",
            options: [],
            metrics: nil,
            views: views)
        
         allConstraints += navViewConstraints
        
        let allViewConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-88-[pageView]-|",
            options: [],
            metrics: nil,
            views: views
        )
        
        allConstraints += allViewConstraints
                
        let pageViewConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[pageView]|",
            options: [],
            metrics: nil,
            views: views
        )
        
        allConstraints += pageViewConstraints

        NSLayoutConstraint.activate(allConstraints)
        
        
        guard let startVC = detailViewControllerAt(index: currentViewControllerIndex) else {
            return
        }
        
        pageVC.setViewControllers(
            [startVC],
            direction: .forward,
            animated: true
        )
    }
    
    private func detailViewControllerAt(index: Int) -> DataViewController? {
        
        if index >= colors.count || colors.count == 0 {
            return nil
        }
        
        let dataViewController  = DataViewController()
        dataViewController.index = index
        dataViewController.color = colors[index]
        return dataViewController
    }
}

extension MasterViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? DataViewController
        guard var currentIndex = dataViewController?.index else { return nil}
        currentViewControllerIndex = currentIndex
        if currentIndex == 0 { return nil}
        currentIndex -= 1
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let dataViewController = viewController as? DataViewController
        guard var currentIndex = dataViewController?.index else { return nil}
        if currentIndex == colors.count { return nil }
         currentIndex += 1
        currentViewControllerIndex = currentIndex
        return detailViewControllerAt(index: currentIndex)
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        colors.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
}
