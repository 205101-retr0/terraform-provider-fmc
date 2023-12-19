package fmc

import (
	"context"

	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)

func dataSourceFmcAccessRules() *schema.Resource {
	return &schema.Resource{
		Description: "Data source for Access Policies in FMC\n\n" +
			"An example is shown below: \n" +
			"```hcl\n" +
			"data \"fmc_access_rules\" \"acp\" {\n" +
			"	name = \"Rule 1\"\n" +
			"	acp_name = \"ACP-1\"\n" +
			"}\n" +
			"```",
		ReadContext: dataSourceFmcAccessRulesRead,
		Schema: map[string]*schema.Schema{
			"id": {
				Type:        schema.TypeString,
				Computed:    true,
				Description: "The ID of this resource",
			},
			"acp_name": {
				Type:        schema.TypeString,
				Required:    true,
				Description: "The access policy name which this resource belongs to",
			},
			"name": {
				Type:        schema.TypeString,
				Required:    true,
				Description: "Name of the FTD accessPolicy",
			},
			"type": {
				Type:        schema.TypeString,
				Computed:    true,
				Description: "Type of this resource",
			},
		},
	}
}

func dataSourceFmcAccessRulesRead(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	c := m.(*Client)

	// Warning or errors can be collected in a slice type
	var diags diag.Diagnostics
	accessRule, err := c.GetFmcAccessRuleByName(ctx, d.Get("acp_name").(string), d.Get("name").(string))
	if err != nil {
		diags = append(diags, diag.Diagnostic{
			Severity: diag.Error,
			Summary:  "unable to get access rule",
			Detail:   err.Error(),
		})
		return diags
	}

	d.SetId(accessRule.ID)

	if err := d.Set("name", accessRule.Name); err != nil {
		diags = append(diags, diag.Diagnostic{
			Severity: diag.Error,
			Summary:  "unable to read access rule",
			Detail:   err.Error(),
		})
		return diags
	}

	if err := d.Set("type", accessRule.Type); err != nil {
		diags = append(diags, diag.Diagnostic{
			Severity: diag.Error,
			Summary:  "unable to read access rule",
			Detail:   err.Error(),
		})
		return diags
	}

	// var sourceZones []map[string]interface{}
	// for _, obj := range accessRule.Sourcezones.Objects {
	// 	sourceZone := map[string]interface{}{
	// 		"source_zone": []map[string]interface{}{
	// 			{
	// 				"id":   obj.ID,
	// 				"type": obj.Type,
	// 			},
	// 		},
	// 	}
	// 	sourceZones = append(sourceZones, sourceZone)
	// }

	// if err := d.Set("source_zones", sourceZones); err != nil {
	// 	diags = append(diags, diag.Diagnostic{
	// 		Severity: diag.Error,
	// 		Summary:  "unable to read access rule",
	// 		Detail:   err.Error(),
	// 	})
	// 	return diags
	// }

	return diags
}
