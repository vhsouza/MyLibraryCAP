sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'my.library.booksreport',
            componentId: 'CV_BooksReportList',
            entitySet: 'CV_BooksReport'
        },
        CustomPageDefinitions
    );
});