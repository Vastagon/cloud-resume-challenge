/// <reference types="cypress" />

describe("My awesome website", () => {
    beforeEach(() => {
        cy.visit("https://vastagon.azureedge.net/")
    })

    it("Has my name as the title", () => {
        cy.get("h1").should("contain.text", "Jacob")
    })
})