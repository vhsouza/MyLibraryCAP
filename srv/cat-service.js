// Imports
const cds = require("@sap/cds");

module.exports = cds.service.impl(async function () {

    const { Books, BookCopies, BookAuthors, Authors } = this.entities;

    this.after("READ", BookAuthors, async (req, next) => {

        const authors = Array.isArray(req) ? req : [req];

        authors.forEach((author) => {
            if (author.Author) {
                author.Author.FullName = author.Author.FirstName + ' ' + author.Author.LastName
            }
        });
    });

    this.before("PATCH", BookCopies, async (req, next) => {

        const copiesFromDb = await readCopiesDbByKey(req.data.Book_ID, req.data.CopyID)

        const copiesAllFieldsWithChanges = getObjectNotChangedPropertiesFromDb(req.data, copiesFromDb)

        let errorObject = checkBeforeSaveBookCopies(copiesAllFieldsWithChanges)
        if (errorObject) {
            return req.error(errorObject)
        }

    });

    function getObjectNotChangedPropertiesFromDb(objectFromUI, objectFromDb) {

        let objectWithChanges = {}

        //When we are creating a new entry the object with more fields will be the object from UI
        let objectWithMoreFields = objectFromDb || objectFromUI

        for (let fieldName in objectWithMoreFields) {
            objectWithChanges[fieldName] = objectFromUI[fieldName] ?? objectFromDb[fieldName]
        }

        return objectWithChanges

    };

    function readCopiesDbByKey(BookID, CopyID) {
        return SELECT.one.from(BookCopies).columns('Book_ID', 'CopyID', 'Status_ID', 'ReservedFrom', 'ReservedUntil')
            .where('Book_ID =', BookID).
            and('CopyID =', CopyID)
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