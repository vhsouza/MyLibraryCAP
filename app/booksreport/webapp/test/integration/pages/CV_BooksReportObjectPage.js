sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'my.library.booksreport',
            componentId: 'CV_BooksReportObjectPage',
            entitySet: 'CV_BooksReport'
        },
        CustomPageDefinitions
    );
});