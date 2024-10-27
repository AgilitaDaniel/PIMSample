using pimService as service from '../../srv/pim';
using from '../../db/schema';

annotate service.Products with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'productID',
                Value : productID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'productText',
                Value : productText,
            },
            {
                $Type : 'UI.DataField',
                Label : 'productDescription',
                Value : productDescription,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Produktmerkmale}',
            ID : 'i18nProduktmerkmale',
            Target : 'to_ProductMerkmalsAuspraegungen/@UI.LineItem#i18nProduktmerkmale',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'productID',
            Value : productID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'productText',
            Value : productText,
        },
        {
            $Type : 'UI.DataField',
            Label : 'productDescription',
            Value : productDescription,
        },
    ],
    UI.SelectionFields : [
        to_MMAsList.pmma,
    ],
);

annotate service.ProductMerkmalsAuspraegungen with @(
    UI.LineItem #i18nProduktmerkmale : [
        {
            $Type : 'UI.DataField',
            Value : to_Merkmal_ID,
            Label : 'to_Merkmal_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : to_MerkmalDropDownValue_ID,
            Label : 'to_MerkmalDropDownValue_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : freeText,
            Label : 'freeText',
        },
        {
            $Type : 'UI.DataField',
            Value : checkBox,
            Label : 'checkBox',
        },
    ]
);

annotate service.ProductMerkmalsAuspraegungen with {

};


annotate service.ProductMerkmalsAuspraegungen with {
    to_Merkmal @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Merkmale',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : to_Merkmal_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description',
                },
            ],
            Label : '{i18n>Merkmal}',
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : to_Merkmal.name,
    )};

annotate service.Merkmale with {
    ID @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextOnly,
    }
};

annotate service.ProductMerkmalsAuspraegungen with {
    to_MerkmalDropDownValue @(
        Common.Text : to_MerkmalDropDownValue.name,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'MerkmaleDropDownValues',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : to_MerkmalDropDownValue_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description',
                },
                // Use this parameter to filter based on the selected Merkmal
                {
                    $Type : 'Common.ValueListParameterIn',
                    LocalDataProperty : to_Merkmal_ID,  // The property in ProductMerkmalsAuspraegungen
                    ValueListProperty : 'to_Merkmal_ID'  // The property in MerkmaleDropDownValues to match
                }
            ],
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.MerkmaleDropDownValues with {
    ID @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextOnly,
    }
};

// annotate service.ProductMerkmalsAuspraegungen {
//     freeText @Common.FieldControl : !['{to_M} ? 3 : 0'];   // 3 -> Editable, 0 -> Hidden
//     checkBox @Common.FieldControl : !['{to_InputType.checkBox} ? 3 : 0'];   // 3 -> Editable, 0 -> Hidden
//     to_MerkmalDropDownValue_ID @Common.FieldControl : !['{to_InputType.dropDown} ? 3 : 0'];  // 3 -> Editable, 0 -> Hidden
// };
annotate service.AllMMAs with {
    pmma @(
        Common.Label : 'to_MMAsList/pmma',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'PossibleMMAs',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : pmma,
                    ValueListProperty : 'pmma',
                },
            ],
            Label : '{i18n>Allmmas}',
        },
        Common.ValueListWithFixedValues : false,
    )
};

