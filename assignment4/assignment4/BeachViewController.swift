//
//  ViewController.swift
//  assignment4
//
//  Created by Daniel Del Core on 28/10/2015.
//  Copyright © 2015 Daniel Del Core. All rights reserved.
//

import UIKit

class BeachViewController: UIViewController, UIPageViewControllerDataSource {
    
    let favoriteEntityManager: FavoriteEntityManager = FavoriteEntityManager()
    var pageViewController: UIPageViewController!
    var pageTitle: NSArray!
    var model: BeachModel!
    var maxPageCount: Int = 10
    
    @IBOutlet weak var FavoriteButton: UIBarButtonItem!
    @IBAction func FavoriteButtonPressed(sender: AnyObject) {
        self.favoriteEntityManager.createFavorite(Int32(model.id), name: model.name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.model.forcastArray.count < self.maxPageCount){
            self.maxPageCount = self.model.forcastArray.count
        }
        
        self.title = self.model.name
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        let startVC = self.viewControllerAtIndex(0) as ContentViewController
        let viewControllers = NSArray(object: startVC)
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func viewControllerAtIndex(index:Int) -> ContentViewController {
        let titleCount = self.model.forcastArray.count

        if ((titleCount == 0) || (index >= self.maxPageCount)) {
            return ContentViewController()
        }

        let vc: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        vc.model = self.model.forcastArray[index]
        vc.pageIndex = index

        return vc
    }

    // Mark: - Page View Controller Data Source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int

        if ((index == 0) || (index == NSNotFound)) {
            return nil
        }

        index--

        return self.viewControllerAtIndex(index)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int

        if (index == NSNotFound) {
            return nil
        }

        index++

        if(index == maxPageCount) {
            return nil
        }

        return self.viewControllerAtIndex(index)
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.maxPageCount
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
