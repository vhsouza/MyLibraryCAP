sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'my/library/booksreport/test/integration/FirstJourney',
		'my/library/booksreport/test/integration/pages/CV_BooksReportList',
		'my/library/booksreport/test/integration/pages/CV_BooksReportObjectPage'
    ],
    function(JourneyRunner, opaJourney, CV_BooksReportList, CV_BooksReportObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('my/library/booksreport') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheCV_BooksReportList: CV_BooksReportList,
					onTheCV_BooksReportObjectPage: CV_BooksReportObjectPage
                }
            },
            opaJourney.run
        );
    }
);