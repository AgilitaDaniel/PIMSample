sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'pimclassifier/test/integration/FirstJourney',
		'pimclassifier/test/integration/pages/ProductsList',
		'pimclassifier/test/integration/pages/ProductsObjectPage',
		'pimclassifier/test/integration/pages/ProductMerkmalsAuspraegungenObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductsList, ProductsObjectPage, ProductMerkmalsAuspraegungenObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('pimclassifier') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductsList: ProductsList,
					onTheProductsObjectPage: ProductsObjectPage,
					onTheProductMerkmalsAuspraegungenObjectPage: ProductMerkmalsAuspraegungenObjectPage
                }
            },
            opaJourney.run
        );
    }
);