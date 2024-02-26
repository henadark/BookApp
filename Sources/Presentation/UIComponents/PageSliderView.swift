import UIKit
import SwiftUI

internal struct PageSliderView
    <Collections, CellContent>
    : UIViewControllerRepresentable
    where
    Collections : RandomAccessCollection,
    Collections.Index == Int,
    Collections.Element : RandomAccessCollection,
    Collections.Element.Index == Int,
    Collections.Element.Element : Identifiable,
    CellContent : View
{

    internal typealias ContentForData = (Collections.Element.Element) -> CellContent
    internal typealias ScrollDirection = UICollectionView.ScrollDirection

    // MARK: Stored Properties

    fileprivate let collections: Collections
    fileprivate let contentForData: ContentForData
    fileprivate let autoScrollTimeInterval: TimeInterval
    private let pageIndicatorTintColor: UIColor
    private let currentPageIndicatorTintColor: UIColor

    // MARK: Init

    internal init(
        collections: Collections,
        autoScroll timeInterval: TimeInterval,
        pageIndicatorTintColor: UIColor,
        currentPageIndicatorTintColor: UIColor,
        contentForData: @escaping ContentForData
    ) {
        self.collections = collections
        self.autoScrollTimeInterval = timeInterval
        self.pageIndicatorTintColor = pageIndicatorTintColor
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        self.contentForData = contentForData
    }

    /*
     Convenience init for a single-section CollectionView
     */
    internal init<Collection>(
        collection: Collection,
        autoScroll timeInterval: TimeInterval = 3.0,
        pageIndicatorTintColor: Color,
        currentPageIndicatorTintColor: Color,
        contentForData: @escaping ContentForData
    ) where Collections == [Collection] {
        self.init(
            collections: [collection],
            autoScroll: timeInterval,
            pageIndicatorTintColor: UIColor(pageIndicatorTintColor),
            currentPageIndicatorTintColor: UIColor(currentPageIndicatorTintColor),
            contentForData: contentForData
        )
    }

    // MARK: UIViewControllerRepresentable

    internal func makeCoordinator() -> Coordinator {
        return Coordinator(view: self)
    }

    internal func makeUIViewController(context: Context) -> ViewController {
        let coordinator = context.coordinator
        let viewController = ViewController(delegate: coordinator, scrollDirection: .horizontal)

//        let isScrollDisabled = (collections.first?.count ?? 0) < 2
//        viewController.collectionView.isUserInteractionEnabled = !isScrollDisabled
//        if let collection = collections.first {
//            viewController.pageControl.numberOfPages = collection.count
//            viewController.pageControl.isHidden = isScrollDisabled
//        }
        viewController.pageControl.pageIndicatorTintColor = pageIndicatorTintColor
        viewController.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        updateUI(for: viewController)

        coordinator.viewController = viewController
        return viewController
    }

    internal func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        context.coordinator.view = self
        uiViewController.layout.scrollDirection = .horizontal
        updateUI(for: uiViewController)
        uiViewController.collectionView.reloadData()
        context.coordinator.refreshTimer()
    }

    private func updateUI(for viewController: ViewController/*, with coordinator: Coordinator*/) {
        let isScrollDisabled = (collections.first?.count ?? 0) < 2
        viewController.collectionView.isUserInteractionEnabled = !isScrollDisabled
        if let collection = collections.first {
            viewController.pageControl.numberOfPages = collection.count
            viewController.pageControl.isHidden = isScrollDisabled
        }
    }
}

extension PageSliderView {

    fileprivate static var cellReuseIdentifier: String { "HostedCollectionViewCell" }
}

extension PageSliderView {

    internal final class ViewController : UIViewController {

        // MARK: Stored Properties

        fileprivate let layout: UICollectionViewFlowLayout
        fileprivate let collectionView: UICollectionView
        fileprivate let pageControl: UIPageControl

        // MARK: Init

        internal init(delegate: UICollectionViewDelegate & UICollectionViewDataSource, scrollDirection: ScrollDirection) {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = scrollDirection
            self.layout = layout

            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = nil
            collectionView.register(HostedCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
            collectionView.dataSource = delegate
            collectionView.delegate = delegate
            collectionView.isPagingEnabled = true
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            self.collectionView = collectionView

            self.pageControl = UIPageControl()
            self.pageControl.backgroundStyle = .minimal
            self.pageControl.allowsContinuousInteraction = false
            self.pageControl.translatesAutoresizingMaskIntoConstraints = false

            super.init(nibName: nil, bundle: nil)
        }

        internal required init?(coder: NSCoder) {
            fatalError("In no way is this class related to an interface builder file.")
        }

        // MARK: Life Cycle

        internal override func loadView() {
            self.view = buildView()
        }

        // MARK: Helpers

        private func buildView() -> UIView {
            let container = UIView()
            container.backgroundColor = .clear

            container.addSubview(collectionView)
            collectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
            collectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
            collectionView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true

            container.addSubview(pageControl)
            pageControl.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
            pageControl.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8).isActive = true

            return container
        }
    }
}

extension PageSliderView {

    internal final class Coordinator: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

        // MARK: Stored Properties

        fileprivate var view: PageSliderView
        fileprivate var viewController: ViewController?

        private let buffer = 3
        private var totalElements: Int = 0
        private var currentIndexPath = IndexPath(item: 0, section: 0)

        private var timer: Timer?

        // MARK: Init

        internal init(view: PageSliderView) {
            self.view = view
            super.init()

            startTimer()
        }

        deinit {
            stopTimer()
        }

        // MARK: Timer

        private func startTimer() {

            guard (view.collections.first?.count ?? 0) > 1 else { return }

            timer = Timer.scheduledTimer(withTimeInterval: view.autoScrollTimeInterval, repeats: true) { [weak self] timer in

                guard let self = self else { return }

                let indexPath = IndexPath(item: self.currentIndexPath.item + 1, section: 0)
                self.viewController?.collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
            }
        }

        private func stopTimer() {
            timer?.invalidate()
            timer = nil
        }

        fileprivate func refreshTimer() {
            stopTimer()
            startTimer()
        }

        // MARK: UICollectionViewDataSource

        internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            totalElements = view.collections[section].count > 0 ? buffer + view.collections[section].count : 0
            print(totalElements)
            return totalElements
        }

        internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard 
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? HostedCollectionViewCell
            else { return UICollectionViewCell() }

            let currentCell = indexPath.row % self.view.collections[indexPath.section].count
            let data = self.view.collections[indexPath.section][currentCell]
            let content = self.view.contentForData(data)
            cell.provide(content)

            return cell
        }

        internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            let cell = cell as! HostedCollectionViewCell
            cell.attach(to: self.viewController!)
            currentIndexPath = indexPath
        }

        internal func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            let cell = cell as! HostedCollectionViewCell
            cell.detach()
        }

        // MARK: UICollectionViewDelegateFlowLayout

        internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }

        internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }

        internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }

        // MARK: UIScrollViewDelegate

        internal func scrollViewDidScroll(_ scrollView: UIScrollView) {

            guard let collectionView = viewController?.collectionView else { return }

            let itemSize = collectionView.contentSize.width / CGFloat(totalElements)
            let models = self.view.collections[0]

            if scrollView.contentOffset.x > itemSize*CGFloat(models.count){
                collectionView.contentOffset.x -= itemSize*CGFloat(models.count)
            }
            if scrollView.contentOffset.x < 0  {
                collectionView.contentOffset.x += itemSize*CGFloat(models.count)
            }

            // Determine the current Index and update pageIndicator
            let currentIndex = Int(round(Double(collectionView.contentOffset.x) / Double(itemSize))) % models.count
            viewController?.pageControl.currentPage = currentIndex
        }

        internal func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            stopTimer()
        }

        internal func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            startTimer()
        }
    }
}

private extension PageSliderView {

    final class HostedCollectionViewCell : UICollectionViewCell {

        var viewController: UIHostingController<CellContent>?

        func provide(_ content: CellContent) {
            if let viewController = self.viewController {
                viewController.rootView = content
            } else {
                let hostingController = UIHostingController(rootView: content)
                hostingController.view.backgroundColor = nil
                self.viewController = hostingController
            }
        }

        func attach(to parentController: UIViewController) {
            let hostedController = self.viewController!
            let hostedView = hostedController.view!
            let contentView = self.contentView

            parentController.addChild(hostedController)

            hostedView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(hostedView)
            hostedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            hostedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            hostedView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            hostedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

            hostedController.didMove(toParent: parentController)
        }

        func detach() {
            let hostedController = self.viewController!
            guard hostedController.parent != nil else { return }
            let hostedView = hostedController.view!

            hostedController.willMove(toParent: nil)
            hostedView.removeFromSuperview()
            hostedController.removeFromParent()
        }
    }
}
