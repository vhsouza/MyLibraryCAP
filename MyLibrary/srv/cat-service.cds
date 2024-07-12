using my.Library as Library from '../db/schema';
using CV_BOOKSREPORT2 from '../db/schema';
using CV_BOOKSREPORT from '../db/schema';
using CV_AVAILABLEBOOKSFORRESERVATION from '../db/schema';

@path: 'service/Library'
service CatalogService {

    @requires: 'support'
    @odata.draft.enabled
    entity Books                           as projection on Library.Books;

    entity Authors                         as projection on Library.Authors;
    entity BookAuthors                     as projection on Library.Books.Authors;
    entity BookCopies                      as projection on Library.Books.Copies;
    entity BookCopyStatus                  as projection on Library.BookCopyStatus;
    entity BooksText                       as projection on Library.Books.texts;

    @requires: 'support'
    @readonly
    entity CV_BooksReport2                 as projection on CV_BOOKSREPORT2;

    @requires: 'authenticated-user'
    @readonly
    entity CV_BooksReport                  as projection on CV_BOOKSREPORT;


    @readonly
    entity CV_BooksAvailableForReservation as projection on CV_AVAILABLEBOOKSFORRESERVATION;

    type reserveBooksParam : {
        books : array of reserveBookParam;
    };

    type reserveBookParam  : {
        bookId         : Books:ID;
        requestedCopies : Integer;
    };

    action reserveBooks(booksToBeReserved : reserveBooksParam) returns {
        reserveId : Integer
    }

};
