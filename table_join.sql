SELECT c."country", c."code", c."region", c."income", c."year", c."che_gdp(%)", c."hk_gdl(%)", c."che_pc_usd", c."che", c."gdp_pc_usd", c."che_usd",
a."Sex", a."Age_group_code", a."Age_Group", a."Number", a."Age_Stnd_Per_100k", a."Death_rate_per_100k"

INTO ExpMortJoin

FROM expenditures c 
INNER JOIN clean_infectious_disease a ON c."country" = a."Country_Name"
;

SELECT * FROM ExpMortJoin;

