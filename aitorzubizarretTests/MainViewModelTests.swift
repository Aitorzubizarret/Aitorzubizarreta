//
//  MainViewModelTests.swift
//  aitorzubizarretTests
//
//  Created by Aitor Zubizarreta on 15/10/22.
//

import XCTest
@testable import aitorzubizarret

final class MainViewModelTests: XCTestCase {
    
    private var sut: MainViewModel! // System Under Test
    private var apiManager: MockAPIManager!
    
    override func setUpWithError() throws {
        // Mock APIManager
        apiManager = MockAPIManager(mockPostSections: [],
                                    mockCVFile: CVFile(pdf: ""),
                                    mockPhotos: [],
                                    mockBlogPosts: [],
                                    mockApps: [])
        sut = MainViewModel(apiManager: apiManager)
        
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        apiManager = nil
        
        try super.tearDownWithError()
    }
    
    func testSortBlogPostsArray_ByDate() {
        // Given.
        let blogPost1: BlogPost = BlogPost(title: "Blog Post 1", date: "2022-09-14T20:08:00+0200", tags: [], descriptions: [])
        let blogPost2: BlogPost = BlogPost(title: "Blog Post 2", date: "2022-11-14T20:08:00+0200", tags: [], descriptions: [])
        let blogPost3: BlogPost = BlogPost(title: "Blog Post 3", date: "2022-10-14T20:08:00+0200", tags: [], descriptions: [])
        let blogPosts: [BlogPost] = [blogPost1, blogPost2, blogPost3]
        
        // When.
        let sortedBlogPostsByDate = sut.sortBlogPostByDate(allBlogPosts: blogPosts)
        
        // Then.
        XCTAssertEqual(sortedBlogPostsByDate[0].title, "Blog Post 2")
        XCTAssertEqual(sortedBlogPostsByDate[1].title, "Blog Post 3")
        XCTAssertEqual(sortedBlogPostsByDate[2].title, "Blog Post 1")
    }
    
    func testFilterBlogPostsArray_ByQuantity_Four() {
        // Given.
        let blogPost1: BlogPost = BlogPost(title: "Blog Post 1", date: "", tags: [], descriptions: [])
        let blogPost2: BlogPost = BlogPost(title: "Blog Post 2", date: "", tags: [], descriptions: [])
        let blogPost3: BlogPost = BlogPost(title: "Blog Post 3", date: "", tags: [], descriptions: [])
        let blogPost4: BlogPost = BlogPost(title: "Blog Post 4", date: "", tags: [], descriptions: [])
        let blogPosts: [BlogPost] = [blogPost1, blogPost2, blogPost3, blogPost4]
        
        // When.
        let fourBlogPosts = sut.filterArrayByQuantity(elements: blogPosts, quantity: 4)
        
        // Then.
        XCTAssertEqual(fourBlogPosts.count, 4)
    }
    
    func testFilterBlogPostsArray_ByQuantity_LessThanFour() {
        // Given.
        let blogPost1: BlogPost = BlogPost(title: "Blog Post 1", date: "", tags: [], descriptions: [])
        let blogPost2: BlogPost = BlogPost(title: "Blog Post 2", date: "", tags: [], descriptions: [])
        let blogPost3: BlogPost = BlogPost(title: "Blog Post 3", date: "", tags: [], descriptions: [])
        let blogPosts: [BlogPost] = [blogPost1, blogPost2, blogPost3]
        
        // When.
        let lessThanFourBlogPosts = sut.filterArrayByQuantity(elements: blogPosts, quantity: 4)
        
        // Then.
        XCTAssertEqual(lessThanFourBlogPosts.count, 3)
    }
    
    func testFilterBlogPostsArray_ByQuantity_MoreThanFour() {
        // Given.
        let blogPost1: BlogPost = BlogPost(title: "Blog Post 1", date: "", tags: [], descriptions: [])
        let blogPost2: BlogPost = BlogPost(title: "Blog Post 2", date: "", tags: [], descriptions: [])
        let blogPost3: BlogPost = BlogPost(title: "Blog Post 3", date: "", tags: [], descriptions: [])
        let blogPost4: BlogPost = BlogPost(title: "Blog Post 4", date: "", tags: [], descriptions: [])
        let blogPost5: BlogPost = BlogPost(title: "Blog Post 5", date: "", tags: [], descriptions: [])
        let blogPosts: [BlogPost] = [blogPost1, blogPost2, blogPost3, blogPost4, blogPost5]
        
        // When.
        let moreThanFourBlogPosts = sut.filterArrayByQuantity(elements: blogPosts, quantity: 4)
        
        // Then.
        XCTAssertEqual(moreThanFourBlogPosts.count, 4)
    }
    
    func testFilterAppsArray_ByQuantity_Three() {
        // Given.
        let app1: App = App(title: "Title 1", description: "Description 1", appStoreProductId: "ProductId 1")
        let app2: App = App(title: "Title 2", description: "Description 2", appStoreProductId: "ProductId 2")
        let app3: App = App(title: "Title 3", description: "Description 3", appStoreProductId: "ProductId 3")
        let apps: [App] = [app1, app2, app3]
        
        // When.
        let threeApps = sut.filterArrayByQuantity(elements: apps, quantity: 3)
        
        // Then.
        XCTAssertEqual(threeApps.count, 3)
    }
    
    func testFilterAppsArray_ByQuantity_LessThanThree() {
        // Given.
        let app1: App = App(title: "Title 1", description: "Description 1", appStoreProductId: "ProductId 1")
        let app2: App = App(title: "Title 2", description: "Description 2", appStoreProductId: "ProductId 2")
        let apps: [App] = [app1, app2]
        
        // When.
        let lessThanthreeApps = sut.filterArrayByQuantity(elements: apps, quantity: 3)
        
        // Then.
        XCTAssertEqual(lessThanthreeApps.count, 2)
    }
    
    func testFilterAppsArray_ByQuantity_MoreThanThree() {
        // Given.
        let app1: App = App(title: "Title 1", description: "Description 1", appStoreProductId: "ProductId 1")
        let app2: App = App(title: "Title 2", description: "Description 2", appStoreProductId: "ProductId 2")
        let app3: App = App(title: "Title 3", description: "Description 3", appStoreProductId: "ProductId 3")
        let app4: App = App(title: "Title 4", description: "Description 4", appStoreProductId: "ProductId 4")
        let apps: [App] = [app1, app2, app3, app4]
        
        // When.
        let moreThanthreeApps = sut.filterArrayByQuantity(elements: apps, quantity: 3)
        
        // Then.
        XCTAssertEqual(moreThanthreeApps.count, 3)
    }
    
}
