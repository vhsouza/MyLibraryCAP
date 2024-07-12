// Imports
const cds = require("@sap/cds");

module.exports = cds.service.impl(async function () {

    const { Books, BookCopies, BookAuthors, BooksText } = this.entities;

    //*************** Books Methods

    this.after(['CREATE', 'UPDATE'], Books, async (req, next) => {
        const locale = _convertLocale(next._locale)
        await saveBookText(req, next._locale)
    });

    this.after('READ', Books, async (req, next) => {

        const BooksIds = req.map(r => r.ID)

        const locale = _convertLocale(next._locale)

        const booksTextDb = await readBooksTextByIds(BooksIds, locale)

        if (booksTextDb) {
            req.forEach((books) => {
                const bookText = booksTextDb.find(b => (b.ID == books.ID));
                if (bookText) {
                    books.Title = bookText.Title
                } else {
                    books.Title = null
                }
            })
        }

    });

    this.on("reserveBooks", async (req) => {
        console.log(req.data.booksToBeReserved.books)
    });

    //*************** BookAuthors Methods

    this.after("READ", BookAuthors, async (req, next) => {

        const authors = Array.isArray(req) ? req : [req];

        authors.forEach((author) => {
            if (author.Author) {
                author.Author.FullName = author.Author.FirstName + ' ' + author.Author.LastName
            }
        });
    });

    //*************** Books Copies Methods
    //https://cap.cloud.sap/docs/node.js/fiori for recent versions we must add the drafts at the end
    this.before(['CREATE', 'UPDATE'], 'BookCopies.drafts', async (req, next) => {

        const copiesFromDb = await readCopiesDbByKey(req.data.Book_ID, req.data.CopyID)

        const copiesAllFieldsWithChanges = getObjectNotChangedPropertiesFromDb(req.data, copiesFromDb)

        let errorObject = checkBeforeSaveBookCopies(copiesAllFieldsWithChanges)
        if (errorObject) {
            return req.error(errorObject)
        }
    });

    this.after("READ", BookCopies, async (req, next) => {

        const copies = Array.isArray(req) ? req : [req];

        copies.forEach((copy) => {
            if (copy.Status_ID == '10') {
                copy.Criticality = 3
            } else {
                copy.Criticality = 1
            }

        });
    });


    /***************************************************************** */
    /*INTERNAL METHODS*/
    /***************************************************************** */

    function getObjectNotChangedPropertiesFromDb(objectFromUI, objectFromDb) {

        let objectWithChanges = {}

        //When we are creating a new entry the object with more fields will be the object from UI
        let objectWithMoreFields = objectFromDb || objectFromUI

        for (let fieldName in objectWithMoreFields) {
            objectWithChanges[fieldName] = objectFromUI[fieldName] ?? objectFromDb[fieldName]
        }

        return objectWithChanges

    };

    function _convertLocale(locale) {
        return locale.substring(0, 2)
    };

    async function readCopiesDbByBookID(BookID) {
        return cds.run(SELECT.from(BookCopies).columns('Book_ID', 'CopyID', 'Status_ID', 'ReservedFrom', 'ReservedUntil')
            .where('Book_ID =', BookID))
    };

    async function readCopiesDbByKey(BookID, CopyID) {
        return cds.run(SELECT.one.from(BookCopies).columns('Book_ID', 'CopyID', 'Status_ID', 'ReservedFrom', 'ReservedUntil')
            .where('Book_ID =', BookID).
            and('CopyID =', CopyID))
    };

    async function readBooksTextByKey(BookID, Locale) {
        return await SELECT.one.from(BooksText).columns('ID', 'Title')
            .where('ID =', BookID).
            and('locale =', Locale)
    };

    async function readBooksTextByIds(BooksIds, Locale) {
        return await SELECT.from(BooksText).columns('ID', 'Title')
            .where('ID in', BooksIds).
            and('locale =', Locale)
    };

    async function saveBookText(books, Locale) {

        let bookTextExists = await readBooksTextByKey(books.ID, Locale)
        if (bookTextExists) {
            await UPDATE(BooksText).set({ Title: books.Title }).where({ ID: { '=': books.ID }, Locale: { '=': Locale } })
        } else {
            await INSERT.into(BooksText).entries({ ID: books.ID, locale: Locale, Title: books.Title })
        }
    };

    function checkBeforeSaveBookCopies(copy) {

        let errorObject = getErrorObject();

        if (copy.Status_ID == '20') {

            if (copy.ReservedFrom == null) {
                errorObject.message = `Reservation From is mandatory for Status "Reserved"`;
                errorObject.target = `ReservedFrom`
                return errorObject
            }

            if (new Date(copy.ReservedFrom) < new Date()) {
                errorObject.message = `Reservation From must not be in the past`;
                errorObject.target = `ReservedFrom`
                return errorObject
            }

            if (copy.ReservedUntil == null) {
                errorObject.message = `Reservation Until is mandatory for Status "Reserved"`;
                errorObject.target = `ReservedUntil`
                return errorObject
            }

            if (copy.ReservedFrom > copy.ReservedUntil) {
                errorObject.message = `Reservation From must be lower than Reservation Until`;
                errorObject.target = `ReservedFrom`
                return errorObject
            }
        }
    }

    function getErrorObject() {
        return {
            code: 500,
            message: "",
            target: ""
        }
    }

});