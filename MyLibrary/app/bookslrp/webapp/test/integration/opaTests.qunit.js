sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'bookslrp/test/integration/FirstJourney',
		'bookslrp/test/integration/pages/BooksList',
		'bookslrp/test/integration/pages/BooksObjectPage',
		'bookslrp/test/integration/pages/BookCopiesObjectPage'
    ],
    function(JourneyRunner, opaJourney, BooksList, BooksObjectPage, BookCopiesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('bookslrp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheBooksList: BooksList,
					onTheBooksObjectPage: BooksObjectPage,
					onTheBookCopiesObjectPage: BookCopiesObjectPage
                }
            },
            opaJourney.run
        );
    }
);