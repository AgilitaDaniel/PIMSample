using { de.pim as my } from '../db/schema';

service pimService {

    annotate my.Products with @odata.draft.enabled;
    entity Products as select from my.Products mixin {
       to_MMAsList: Association to many AllMMAs on to_MMAsList.to_Product.productID = $self.productID 
    } into {
      *,
      to_MMAsList
    };
    entity Merkmale as projection on my.Merkmale;
    entity MerkmaleDropDownValues as projection on my.MerkmaleDropDownValues;
    @cds.redirection.target
    entity ProductMerkmalsAuspraegungen as projection on my.ProductMerkmalsAuspraegungen;
    entity InputTypes as projection on my.InputTypes;

    entity AllMMAs as select from ProductMerkmalsAuspraegungen {
      key to_Merkmal.name as Merkmal,
      key to_MerkmalDropDownValue.name as DropDownValue,
      to_Merkmal.to_InputType,
      to_Product,
      concat(to_Merkmal.name, concat(' - ', to_MerkmalDropDownValue.name )) as pmma: String
    } where to_Merkmal.to_InputType.dropDown = true group by to_Merkmal.name, to_MerkmalDropDownValue.name, to_Product, to_Merkmal.to_InputType;

    entity PossibleMMAs as select from my.ProductMerkmalsAuspraegungen {
          key to_Merkmal.name as Merkmal,
          key to_MerkmalDropDownValue.name as DropDownValue,
          to_Merkmal.to_InputType,
          concat(to_Merkmal.name, concat( ' - ', to_MerkmalDropDownValue.name) ) as pmma: String
    } where to_Merkmal.to_InputType.dropDown = true group by to_Merkmal.name, to_Merkmal.to_InputType, to_MerkmalDropDownValue.name;
    annotate ProductMerkmalsAuspraegungen with @(Common.SideEffects: {
  SourceProperties: [to_Merkmal_ID],
  TargetProperties: ['to_MerkmalDropDownValue_ID','freeText','checkBox', 'to_Merkmal_ID'] //to_Merkmal_ID looks weird here but enforces fieldcontrol reload
}) {
        to_MerkmalDropDownValue @Common.FieldControl  : to_Merkmal.to_InputType.fieldControlDropDown;
        freeText @Common.FieldControl  : to_Merkmal.to_InputType.fieldControlFreeText;
        checkBox @Common.FieldControl  : to_Merkmal.to_InputType.fieldControlCheckBox;
    };
}


