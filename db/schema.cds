using { cuid, managed  } from '@sap/cds/common';

namespace de.pim;

entity Products : managed {
    key productID: String;
    productText: localized String;
    productDescription: localized String;
    to_ProductMerkmalsAuspraegungen: Composition of many ProductMerkmalsAuspraegungen on to_ProductMerkmalsAuspraegungen.to_Product = $self;
}
@assert.unique: {inputType: [freeText,dropDown,checkBox]}
entity InputTypes : cuid, managed {
    name: String;
    freeText: Boolean;
    dropDown: Boolean;
    checkBox: Boolean;
    fieldControlCheckBox: Integer @odata.Type:'Edm.Byte';
    fieldControlDropDown: Integer @odata.Type:'Edm.Byte';
    fieldControlFreeText: Integer @odata.Type:'Edm.Byte';
}

entity Merkmale: cuid, managed {
    name: String;
    description: String;
    to_InputType: Association to one InputTypes; 
    onFilterBar: Boolean;
    to_DropDownValues: Composition of many MerkmaleDropDownValues on to_DropDownValues.to_Merkmal = $self;
}
entity MerkmaleDropDownValues: cuid, managed {
    name: String;
    description: String;
    sortOrder: Integer;
    to_Merkmal: Association to one Merkmale; 
}

// entity MerkmalsAuspraegungen: cuid,managed {
//     to_InputType: Association to one InputTypes;
//     to_Merkmal: Association to one Merkmale;
//     freeText: String;
//     dropDown: Boolean;
//     checkBox: Boolean;
// }
@assert.unique: {productMerkmal: [to_Product, to_Merkmal, to_MerkmalDropDownValue, freeText, checkBox]}
entity ProductMerkmalsAuspraegungen: cuid, managed {
    to_Product: Association to one Products;
    // to_Merkmal: Association to one Merkmale;
    // to_Merkmalsauspraegung: Association to one MerkmalsAuspraegungen;
    // to_InputType: Association to one InputTypes;
    to_Merkmal: Association to one Merkmale;
    to_MerkmalDropDownValue: Association to one MerkmaleDropDownValues;
    freeText: String;
    dropDown: Boolean;
    checkBox: Boolean;
}

view ProductMerkmalsAuspraegungenFlat as select from Products as p
    join ProductMerkmalsAuspraegungen as pc on pc.to_Product.productID = p.productID
    join MerkmaleDropDownValues as cz on cz.ID = pc.to_MerkmalDropDownValue.ID
    join Merkmale as c on c.ID = pc.to_Merkmal.ID  {
    // Select the product fields
    key p.productID as ProductID,
        p.productText as ProductDescription,
         cz.description as MerkmalsDescription,
    // Concatenate the characteristic values as a single field
    string_agg(c.description || ': ' || cz.description, ', ' order by c.description) as CharacteristicValues: String,
} group by
    p.productID,
    p.productText;



