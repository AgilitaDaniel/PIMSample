const cds = require('@sap/cds');

module.exports = cds.service.impl(async function() {

    const { Products, ProductMerkmalsAuspraegungen, MerkmaleDropDownValues } = this.entities;

    // Add a before handler for the 'READ' event of the Products entity
    // this.before('READ', Products, async (req) => {
    //     console.log('Before reading Products entity');

    //     // Check if there's already a WHERE clause
    //     if (req.query.SELECT && req.query.SELECT.where) {
    //         // Append the condition for cars with "Manual" transmission
    //         // req.query.where(`and exists (
    //         //     select 1 from ${ProductMerkmalsAuspraegungen} as pma
    //         //     inner join ${MerkmaleDropDownValues} as mdv on pma.to_MerkmalDropDownValue_ID = mdv.ID
    //         //     where pma.to_Product_productID = Products.productID
    //         //       and pma.to_Merkmal.name = 'Transmission'
    //         //       and mdv.name = 'Manual'
    //         // )`);
    //     } else {
    //         // If there's no WHERE clause, add the condition
    //         req.query.where(`exists (
    //             select 1 from ${ProductMerkmalsAuspraegungen.name} as pma
    //             inner join ${MerkmaleDropDownValues.name} as mdv on pma.to_MerkmalDropDownValue_ID = mdv.ID
    //             where pma.to_Product_productID = Products.productID
    //               and pma.to_Merkmal_ID = '84e815df-8c9f-47d3-867b-9a6239ae9e13'
    //               and mdv.ID = 'dc50d25f-3e72-4d73-8265-dc62d8bf8935'
    //         )`);
    //     }

    //     console.log('Modified query with manual transmission filter:', req.query);
    // });
});
