DROP TABLE IF EXISTS expenditures;
CREATE TABLE "expenditures" (
	"country" Varchar,
	"code" Varchar,
	"region" Varchar,
	"income" Varchar,
	"year" Int,
	"che_gdp(%)" Float,
	"hk_gdl(%)" Float,
	"che_pc_usd" Varchar,
	"che" Varchar,
	"gdp_pc_usd" Varchar,
	"che_usd" Varchar
);

DROP TABLE IF EXISTS "clean_infectious_disease";
CREATE TABLE "clean_infectious_disease"(
	 "Region_Code" Varchar,
	"Region_Name" Varchar,
	"Country_Code" Varchar,
	"Country_Name" Varchar,
	"Year" Int,
	"Sex" Varchar,
	"Age_group_code" Varchar,
	"Age_Group" Varchar,
	"Number" Float,
	"Percent_of_Total" Float,
	"Age_Stnd_Per_100k" Float,
	"Death_rate_per_100k" Float

);

SELECT * FROM expenditures;

SELECT * FROM clean_infectious_disease;