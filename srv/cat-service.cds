using my.Library as Library from '../db/schema';

@path: 'service/Library'
service CatalogService {
    entity Books          as projection on Library.Books;
    entity Authors        as projection on Library.Authors;
    entity BookAuthors    as projection on Library.Books.Authors;
    entity BookCopies     as projection on Library.Books.Copies
    entity BookCopyStatus as projection on Library.BookCopyStatus
    ;
};
