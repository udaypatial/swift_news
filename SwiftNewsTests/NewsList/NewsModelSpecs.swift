//
//  NewsModelSpecs.swift
//  SwiftNewsTests
//
//  Created by Uday Patial on 2020-08-09.
//  Copyright © 2020 Uday Patial. All rights reserved.
//

import Quick
import Nimble
import Foundation

class NewsModelSpecs: QuickSpec {
    
    override func spec() {
        
        describe("News Model") {
            context("Decoding from json") {
                
                it("Successfully decodes if required fields are present") {
                    let correctJSON = """
                            {
                                "kind": "Listing",
                                "data": {
                                    "modhash": "",
                                    "dist": 26,
                                    "children": [
                                        {
                                            "kind": "t3",
                                            "data": {
                                                "title": "Add progress bars to your gifs! ProgressGif is now out on the App Store! (open-source, more details below)",
                                                "thumbnail": "https://b.thumbs.redditmedia.com/U716CaVPng-DmYpZvj2pwVQV9t6JcQYHhwTI6G6TsDM.jpg",
                                                "selftext": "test"
                                            }
                                        }
                                    ],
                                    "after": "t3_i6bcbb",
                                    "before": null
                                }
                            }
                        """
                    let decoder = JSONDecoder()
                    let respData = correctJSON.data(using: .utf8)!
                    expect { try decoder.decode(APIResponse<NewsArticle>.self, from: respData) }.toNot(throwError())
                }
            }
            
            context("Check for required fields") {
                
                it("throws if title is missing") {
                    let malformedJSON = """
                            {
                                "kind": "Listing",
                                "data": {
                                    "modhash": "",
                                    "dist": 26,
                                    "children": [
                                        {
                                            "kind": "t3",
                                            "data": {
                                                "thumbnail": "https://b.thumbs.redditmedia.com/U716CaVPng-DmYpZvj2pwVQV9t6JcQYHhwTI6G6TsDM.jpg",
                                                "selftext": "test"
                                            }
                                        }
                                    ],
                                    "after": "t3_i6bcbb",
                                    "before": null
                                }
                            }
                        """
                    let decoder = JSONDecoder()
                    let respData = malformedJSON.data(using: .utf8)!
                    expect { try decoder.decode(APIResponse<NewsArticle>.self, from: respData) }.to(throwError())
                }
                
                it("does not throw if any optional field is missing") {
                    let correctJSON = """
                        {
                            "kind": "Listing",
                            "data": {
                                "modhash": "",
                                "dist": 26,
                                "children": [
                                    {
                                        "kind": "t3",
                                        "data": {
                                            "title": "Add progress bars to your gifs! ProgressGif is now out on the App Store! (open-source, more details below)"
                                        }
                                    }
                                ],
                                "after": "t3_i6bcbb",
                                "before": null
                            }
                        }
                    """
                    let decoder = JSONDecoder()
                    let respData = correctJSON.data(using: .utf8)!
                    expect { try decoder.decode(APIResponse<NewsArticle>.self, from: respData) }.toNot(throwError())
                }
            }
        }
    }
}
