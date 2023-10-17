sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'booksLrp/test/integration/FirstJourney',
		'booksLrp/test/integration/pages/BooksList',
		'booksLrp/test/integration/pages/BooksObjectPage',
		'booksLrp/test/integration/pages/Books_BookCopiesObjectPage'
    ],
    function(JourneyRunner, opaJourney, BooksList, BooksObjectPage, Books_BookCopiesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('booksLrp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheBooksList: BooksList,
					onTheBooksObjectPage: BooksObjectPage,
					onTheBooks_BookCopiesObjectPage: Books_BookCopiesObjectPage
                }
            },
            opaJourney.run
        );
    }
);