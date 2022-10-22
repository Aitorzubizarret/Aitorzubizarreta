//
//  BlogViewModelTests.swift
//  aitorzubizarretTests
//
//  Created by Aitor Zubizarreta on 20/10/22.
//

import XCTest
@testable import aitorzubizarret

final class BlogViewModelTests: XCTestCase {
    
    private var sut: BlogViewModel! // System Under Test
    private var apiManager: MockAPIManager!
    
    override func setUpWithError() throws {
        // Mock APIManager
        apiManager = MockAPIManager(mockPostSections: [],
                                    mockCVFile: CVFile(pdf: ""),
                                    mockPhotos: [],
                                    mockBlogPosts: [],
                                    mockApps: [])
        sut = BlogViewModel(apiManager: apiManager)
        
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
    
}
