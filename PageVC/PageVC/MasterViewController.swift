import UIKit

class MasterViewController: UIViewController {

    @IBOutlet weak var navigationView: UIView!
    
    let pageVC = PageViewController()
    
    let colors = [UIColor.yellow, UIColor.cyan, UIColor.green,UIColor.yellow, UIColor.cyan, UIColor.green,UIColor.yellow, UIColor.cyan, UIColor.green,UIColor.yellow, UIColor.cyan, UIColor.green]
    var pages =  [UIViewController]()
    var currentViewControllerIndex = 0
    
    override func viewDidLoad() {
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        super.viewDidLoad()
        configurePageViewController()
    }

    @IBAction func goToPreviousRaceTrack(_ sender: Any) {
        var index: Int = currentViewControllerIndex
    }

    @IBAction func goToNextRaceTrack(_ sender: Any) {
         print("Tapped!")
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
            "navView": navigationView!
        ]
        
        var allConstraints = [NSLayoutConstraint]()
        
        let allViewConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-88-[pageView]-|",
            options: [],
            metrics: nil,
            views: views
        )
        
        allConstraints += allViewConstraints
                
        let pageViewConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-16-[pageView]-16-|",
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
