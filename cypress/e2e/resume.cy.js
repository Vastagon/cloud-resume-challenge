/// <reference types="cypress" />

describe("My awesome website", () => {
    beforeEach(() => {
        cy.visit("https://testresumevastagon.z13.web.core.windows.net/")
    })

    it("Has my name as the title", () => {
        cy.get("h2").should("contain.text", "Jacob")
    })

    it("Visit Count exists", () => {
        cy.get("[id=visit-count]").should("have.length", 1)
    })

    it("Correctly shows the visit count of the website", () => {
        const temp = document.getElementById("visit-count")
        cy.get("[id=visit-count]").invoke("text").then((text) => {
            expect(text.length).to.be.at.least(12)
        })
    })
})