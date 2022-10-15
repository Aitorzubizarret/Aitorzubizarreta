//
//  MainViewModelTests.swift
//  aitorzubizarretTests
//
//  Created by Aitor Zubizarreta on 15/10/22.
//

import XCTest
import Combine
@testable import aitorzubizarret

final class MainViewModelTests: XCTestCase {
    
    private var sut: MainViewModel! // System Under Test
    private var apiManager: MockAPIManager!
    private var subscriptions = Set<AnyCancellable>()
    
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
        subscriptions = []
        
        try super.tearDownWithError()
    }

    func testFetchApps_LessThanThree() {
        // Given.
        let app1: App = App(title: "Title 1", description: "Description 1", appStoreProductId: "ProductId 1")
        let app2: App = App(title: "Title 2", description: "Description 2", appStoreProductId: "ProductId 2")
        let mockApps: [App] = [app1, app2]
        apiManager = MockAPIManager(mockPostSections: [],
                                    mockCVFile: CVFile(pdf: ""),
                                    mockPhotos: [],
                                    mockBlogPosts: [],
                                    mockApps: mockApps)
        sut = MainViewModel(apiManager: apiManager)
        
        // When.
        sut.fetch3Apps()
        
        // Then.
        let ex = XCTestExpectation()
        sut.apps.sink { error in
        } receiveValue: { apps in
            if apps.count == 2 {
                ex.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [ex], timeout: 10)
    }
    
    func testFetchApps_MoreThanThree() {
        // Given.
        let app1: App = App(title: "Title 1", description: "Description 1", appStoreProductId: "ProductId 1")
        let app2: App = App(title: "Title 2", description: "Description 2", appStoreProductId: "ProductId 2")
        let app3: App = App(title: "Title 3", description: "Description 3", appStoreProductId: "ProductId 3")
        let app4: App = App(title: "Title 4", description: "Description 4", appStoreProductId: "ProductId 4")
        let mockApps: [App] = [app1, app2, app3, app4]
        apiManager = MockAPIManager(mockPostSections: [],
                                    mockCVFile: CVFile(pdf: ""),
                                    mockPhotos: [],
                                    mockBlogPosts: [],
                                    mockApps: mockApps)
        sut = MainViewModel(apiManager: apiManager)
        
        // When.
        sut.fetch3Apps()
        
        // Then.
        let ex = XCTestExpectation()
        sut.apps.sink { error in
        } receiveValue: { apps in
            if apps.count == 3 {
                ex.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [ex], timeout: 10)
    }
    
    func testFetchApps_ExactThree() {
        // Given.
        let app1: App = App(title: "Title 1", description: "Description 1", appStoreProductId: "ProductId 1")
        let app2: App = App(title: "Title 2", description: "Description 2", appStoreProductId: "ProductId 2")
        let app3: App = App(title: "Title 3", description: "Description 3", appStoreProductId: "ProductId 3")
        let mockApps: [App] = [app1, app2, app3]
        apiManager = MockAPIManager(mockPostSections: [],
                                    mockCVFile: CVFile(pdf: ""),
                                    mockPhotos: [],
                                    mockBlogPosts: [],
                                    mockApps: mockApps)
        sut = MainViewModel(apiManager: apiManager)
        
        // When.
        sut.fetch3Apps()
        
        // Then.
        let ex = XCTestExpectation()
        sut.apps.sink { error in
        } receiveValue: { apps in
            if apps.count == 3 {
                ex.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [ex], timeout: 10)
    }
    
    func testFetchBlogPosts_LessThanFour() {
        // Given.
        let blogPost1: BlogPost = BlogPost(title: "Blog Post 1", date: "", tags: [], descriptions: [])
        let blogPost2: BlogPost = BlogPost(title: "Blog Post 2", date: "", tags: [], descriptions: [])
        let blogPost3: BlogPost = BlogPost(title: "Blog Post 3", date: "", tags: [], descriptions: [])
        let blogPosts: [BlogPost] = [blogPost1, blogPost2, blogPost3]
        apiManager = MockAPIManager(mockPostSections: [],
                                    mockCVFile: CVFile(pdf: ""),
                                    mockPhotos: [],
                                    mockBlogPosts: blogPosts,
                                    mockApps: [])
        sut = MainViewModel(apiManager: apiManager)
        
        // When.
        sut.fetch4BlogPosts()
        
        // Then.
        let ex1 = XCTestExpectation()
        sut.blogPosts.sink { error in
        } receiveValue: { blogPosts in
            if blogPosts.count == 3 {
                ex1.fulfill()
            }
        }.store(in: &subscriptions)
        
        let ex2 = XCTestExpectation()
        sut.blogPostsCount.sink { error in
        } receiveValue: { blogPostsCount in
            if blogPostsCount == 3 {
                ex2.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [ex1, ex2], timeout: 10)
    }
    
    func testFetchBlogPosts_MoreThanFour() {
        // Given.
        let blogPost1: BlogPost = BlogPost(title: "Blog Post 1", date: "", tags: [], descriptions: [])
        let blogPost2: BlogPost = BlogPost(title: "Blog Post 2", date: "", tags: [], descriptions: [])
        let blogPost3: BlogPost = BlogPost(title: "Blog Post 3", date: "", tags: [], descriptions: [])
        let blogPost4: BlogPost = BlogPost(title: "Blog Post 4", date: "", tags: [], descriptions: [])
        let blogPost5: BlogPost = BlogPost(title: "Blog Post 5", date: "", tags: [], descriptions: [])
        let blogPosts: [BlogPost] = [blogPost1, blogPost2, blogPost3, blogPost4, blogPost5]
        apiManager = MockAPIManager(mockPostSections: [],
                                    mockCVFile: CVFile(pdf: ""),
                                    mockPhotos: [],
                                    mockBlogPosts: blogPosts,
                                    mockApps: [])
        sut = MainViewModel(apiManager: apiManager)
        
        // When.
        sut.fetch4BlogPosts()
        
        // Then.
        let ex1 = XCTestExpectation()
        sut.blogPosts.sink { error in
        } receiveValue: { blogPosts in
            if blogPosts.count == 4 {
                ex1.fulfill()
            }
        }.store(in: &subscriptions)
        
        let ex2 = XCTestExpectation()
        sut.blogPostsCount.sink { error in
        } receiveValue: { blogPostsCount in
            if blogPostsCount == 5 {
                ex2.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [ex1, ex2], timeout: 10)
    }
    
    func testFetchBlogPosts_ExactFour() {
        // Given.
        let blogPost1: BlogPost = BlogPost(title: "Blog Post 1", date: "", tags: [], descriptions: [])
        let blogPost2: BlogPost = BlogPost(title: "Blog Post 2", date: "", tags: [], descriptions: [])
        let blogPost3: BlogPost = BlogPost(title: "Blog Post 3", date: "", tags: [], descriptions: [])
        let blogPost4: BlogPost = BlogPost(title: "Blog Post 4", date: "", tags: [], descriptions: [])
        let blogPosts: [BlogPost] = [blogPost1, blogPost2, blogPost3, blogPost4]
        apiManager = MockAPIManager(mockPostSections: [],
                                    mockCVFile: CVFile(pdf: ""),
                                    mockPhotos: [],
                                    mockBlogPosts: blogPosts,
                                    mockApps: [])
        sut = MainViewModel(apiManager: apiManager)
        
        // When.
        sut.fetch4BlogPosts()
        
        // Then.
        let ex1 = XCTestExpectation()
        sut.blogPosts.sink { error in
        } receiveValue: { blogPosts in
            if blogPosts.count == 4 {
                ex1.fulfill()
            }
        }.store(in: &subscriptions)
        
        let ex2 = XCTestExpectation()
        sut.blogPostsCount.sink { error in
        } receiveValue: { blogPostsCount in
            if blogPostsCount == 4 {
                ex2.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [ex1, ex2], timeout: 10)
    }
    
}
