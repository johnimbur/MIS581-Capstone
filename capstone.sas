/************* attributes ****************
 * year
 * id_
 * marital
 * childs
 * age
 * cohort
 * educ_rank
 * sex_rank
 * race_rank
 * hhrace_rank
 * mobile16_rank
 * mobile16_flag
 * hompop
 * class_
 * class_rank
 * polviews
 * polviews_rank
 * polviews_flag
 * relig
 * denom
 * other
 * religion
 * fund
 * fund_rank
 * fund16_rank
 * fund_differential
 * religious_strength_total
 * religious_strength_count
 * religious_strength_avg
 * religious_strength_index
 * blm_total
 * blm_count
 * blm_avg
 * blm_index
 */

DATA MYDATA;
INFILE '/folders/myfolders/sasuser.v94/gss_2018.csv' dlm=',' MISSOVER DSD lrecl=32767 firstobs=2;

INPUT year
	id_
	marital $
	childs
	age
	cohort
	educ_rank
	sex_rank
	race_rank
	hhrace_rank
	mobile16_rank
	mobile16_flag
	hompop
	class_rank
	class_flag
	polviews $
	polviews_rank
	polviews_flag
	relig $
	denom $
	other $
	religion $
	fund $
	fund_rank
	fund16_rank
	fund_differential
	religious_strength_total
	religious_strength_count
	religious_strength_avg
	religious_strength_index
	blm_total
	blm_count
	blm_avg
	blm_index;
RUN;

proc SQL;
create table AGG_POL_REL_BLM_GSS as
select COUNT(ID_) as NUM_SURVEYS
, FUND as FUND
, POLVIEWS as POLVIEWS
, AVG(blm_index) as AVG_blm_index
, AVG(religious_strength_index) as AVG_religious_strength_index
, POLVIEWS_RANK as POLVIEWS_RANK
, FUND_RANK as FUND_RANK
, SUM(religious_strength_total) as SUM_religious_strength_total
, SUM(religious_strength_count) as SUM_religious_strength_count
, AVG(religious_strength_avg) as AVG_religious_strength_avg
, SUM(blm_total) as SUM_blm_total
, SUM(blm_count) as SUM_blm_count
, AVG(blm_avg) as AVG_blm_avg
from WORK.MYDATA
WHERE POLVIEWS_RANK > 0
GROUP BY FUND_RANK, POLVIEWS_RANK, FUND, POLVIEWS;
run;

proc export 
  data=WORK.AGG_POL_REL_BLM_GSS 
  dbms=xlsx 
  outfile="/folders/myfolders/sasuser.v94/agg_pol_rel_gss.xlsx" 
  replace;
run;

ods noproctitle;
ods graphics / imagemap=on TIPMAX=1000;

/******************* full data ***************************/
proc means data=WORK.MYDATA chartype n mean std min max vardef=df;
	var POLVIEWS_RANK FUND_RANK BLM_INDEX religious_strength_index;
run;

title 'Number of 2018 respondants grouped by political sentiment and religious affinity';
proc sgplot data=work.mydata;
  vbar polviews_rank / response=id_ stat=freq group=fund_rank nostatlabel
         groupdisplay=cluster;
  xaxis display=(nolabel);
  yaxis grid;
  run;
  
proc corr data=WORK.MYDATA PLOTS(MAXPOINTS=20000)=matrix;
	var POLVIEWS_RANK FUND_RANK BLM_INDEX religious_strength_index;
run;

TITLE 'DISTRIBUTION OF RACIAL EQUITY BLM_INDEX (Overall)';
 PROC UNIVARIATE DATA = WORK.MYDATA NOPRINT;
HISTOGRAM BLM_INDEX / NORMAL;
RUN;

proc corr data=WORK.MYDATA PLOTS(MAXPOINTS=20000)=matrix;
	var POLVIEWS_RANK FUND_RANK BLM_INDEX religious_strength_index;
	WHERE fund_rank = 0;
run;

TITLE 'DISTRIBUTION OF RACIAL EQUITY BLM_INDEX (No Specified Religion)';
 PROC UNIVARIATE DATA = WORK.MYDATA NOPRINT;
HISTOGRAM BLM_INDEX / NORMAL;
WHERE fund_rank=0;
RUN;

proc corr data=WORK.MYDATA PLOTS(MAXPOINTS=20000)=matrix ;
	var POLVIEWS_RANK FUND_RANK BLM_INDEX religious_strength_index;
	WHERE fund_rank = 1;
run;

TITLE 'DISTRIBUTION OF RACIAL EQUITY BLM_INDEX (Religious Liberal)';
 PROC UNIVARIATE DATA = WORK.MYDATA NOPRINT;
HISTOGRAM BLM_INDEX / NORMAL;
WHERE fund_rank=1;
RUN;

proc corr data=WORK.MYDATA PLOTS(MAXPOINTS=20000)=matrix ;
	var POLVIEWS_RANK FUND_RANK BLM_INDEX religious_strength_index;
	WHERE fund_rank = 2;
run;

TITLE 'DISTRIBUTION OF RACIAL EQUITY BLM_INDEX (Religious Moderate)';
 PROC UNIVARIATE DATA = WORK.MYDATA NOPRINT;
HISTOGRAM BLM_INDEX / NORMAL;
WHERE fund_rank=2;
RUN;

proc corr data=WORK.MYDATA PLOTS(MAXPOINTS=20000)=matrix ;
	var POLVIEWS_RANK FUND_RANK BLM_INDEX religious_strength_index;
	WHERE fund_rank = 3;
run;

TITLE 'DISTRIBUTION OF RACIAL EQUITY BLM_INDEX (Religious Fundamentalist)';
 PROC UNIVARIATE DATA = WORK.MYDATA NOPRINT;
HISTOGRAM BLM_INDEX / NORMAL;
WHERE fund_rank=3;
RUN;



/******************* full data ***************************/
TITLE 'AGGREGATE MEAN, STD DEVIATION, MIN, MAX  (Overall)';
proc means data=WORK.AGG_POL_REL_BLM_GSS chartype n mean std min max vardef=df;
	var POLVIEWS_RANK FUND_RANK AVG_BLM_INDEX AVG_religious_strength_index;
run;

TITLE 'MATRIX FOR AGGREGATE MEANS OF RACIAL EQUITY INDEX AND RELIGIOSITY INDEX (Overall)';
proc corr data=WORK.AGG_POL_REL_BLM_GSS PLOTS(MAXPOINTS=20000)=matrix;
	var POLVIEWS_RANK FUND_RANK AVG_BLM_INDEX AVG_religious_strength_index;
run;

TITLE 'MATRIX FOR AGGREGATE MEANS OF RACIAL EQUITY INDEX AND RELIGIOSITY INDEX (No Specified Religion)';
proc corr data=WORK.AGG_POL_REL_BLM_GSS PLOTS(MAXPOINTS=20000)=matrix;
	var POLVIEWS_RANK FUND_RANK AVG_BLM_INDEX AVG_religious_strength_index;
	WHERE fund_rank = 0;
run;

TITLE 'MATRIX FOR AGGREGATE MEANS OF RACIAL EQUITY INDEX AND RELIGIOSITY INDEX (Religious Liberal)';
proc corr data=WORK.AGG_POL_REL_BLM_GSS PLOTS(MAXPOINTS=20000)=matrix;
	var POLVIEWS_RANK FUND_RANK AVG_BLM_INDEX AVG_religious_strength_index;
	WHERE fund_rank = 1;
run;

TITLE 'MATRIX FOR AGGREGATE MEANS OF RACIAL EQUITY INDEX AND RELIGIOSITY INDEX (Religious Moderate)';
proc corr data=WORK.AGG_POL_REL_BLM_GSS PLOTS(MAXPOINTS=20000)=matrix;
	var POLVIEWS_RANK FUND_RANK AVG_BLM_INDEX AVG_religious_strength_index;
	WHERE fund_rank = 2;
run;

TITLE 'MATRIX FOR AGGREGATE MEANS OF RACIAL EQUITY INDEX AND RELIGIOSITY INDEX (Religious Fundamentalist)';
proc corr data=WORK.AGG_POL_REL_BLM_GSS PLOTS(MAXPOINTS=20000)=matrix;
	var POLVIEWS_RANK FUND_RANK AVG_BLM_INDEX AVG_religious_strength_index;
	WHERE fund_rank = 3;
run;

quit;
