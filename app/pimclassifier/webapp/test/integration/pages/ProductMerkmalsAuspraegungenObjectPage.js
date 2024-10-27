sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'pimclassifier',
            componentId: 'ProductMerkmalsAuspraegungenObjectPage',
            contextPath: '/Products/to_ProductMerkmalsAuspraegungen'
        },
        CustomPageDefinitions
    );
});