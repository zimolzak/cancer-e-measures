-- LUNG

SELECT TOP (200) 
[patientsid]
,[Sta3n]
      --,[OncologyPrimaryIEN],
	  ,[Stagegroupclinical] --IMPORTANT
      ,[StageGroupingajcc] --IMPORTANT
	 ,[SitegpX]
	 ,[ICDOSite]
	  ,[PrimarysiteX]
	,[Histologyicdo3X] -- last good one?

      --,[DateOfInpatientAdmission]
      --,[DateOfInpatientDischarge]
      ,[DateDX]
      --,[Palliativecare]
      --,[Palliativecarefac]
      --,[StagedByClinicalStage]
      --,[PrimarySiteIEN]
      --,[HistologyIcdo2IEN]
      ,[Histologyicdo2X]
      --,[HistologyIcdo3IEN]
      --,[GradedifferentiationidIEN]
      --,[Gradedifferentiation]
      --,[Gradepathsystem]
      --,[Gradepathvalue]
      --,[Tnmformassigned]
      --,[TumorSize]
      --,[TumorSizeextEvalCs]
      --,[TumorSizeCs]
      --,[LymphNodes]
      --,[LymphNodesCs]
      --,[RegionalLymphNodesPositive]
      --,[RegNodesEvalCs]
      --,[RegionalLymphNodesExamined]
      --,[SiteOfDistantMetastasis1]
      --,[SiteOfDistantMetastasis2]
      --,[SiteOfDistantMetastasis3]
      --,[MetsAtDxCs]
      --,[Metsatdxbone]
      --,[Metsatdxbrain]
      --,[Metsatdxliver]
      --,[Metsatdxlung]
      --,[MetsEvalCs]
      ,[SeerSummaryStage2000]
      ,[AjccStagingBasis]
      ,[ClinicalT]
      ,[ClinicalN]
      ,[ClinicalM]
      --,[AutomaticStagingOverridden]
      ,[OtherstagingsystemidIEN]
      ,[Otherstagingsystem]
	  --,[Tnmformcompleted]
      --,[PerformanceStatus]
      --,[SurgicalDxstagingProc]
      --,[SurgeryOfPrimaryR]
      --,[SurgicalDxstagingProcDate]
      --,[SurgDxstagingProcFac]
      --,[SurgDxstagingProcFacDate]
      ,[PhysiciansStage]
      --,[PhysicianStagingIEN]
      --,[PhysicianstagingX]  --doctor name
      ,[PathologicT]
      ,[PathologicN]
      ,[Pathologicm]
      ,[Stagegrouppathologic]
      --,[Stagedbypathologicstage]
      ,[Otherstagegroup]
      ,[Stagedbyotherstage]
      --,[Censustract]
      ,[Derivedajcc6t]
      ,[Derivedajcc7t]
      ,[Derivedajcc6tdescriptor]
      ,[Derivedajcc7tdescriptor]
      ,[Derivedajcc6n]
      ,[Derivedajcc7n]
      ,[Derivedajcc6ndescriptor]
      ,[Derivedajcc7ndescriptor]
      ,[Derivedajcc6m]
      ,[Derivedajcc7m]
      ,[Derivedajcc6mdescriptor]
      ,[Derivedajcc7mdescriptor]
      ,[Derivedajcc6stagegroup]
      ,[Derivedajcc7stagegroup]


  FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
  where (SitegpX like 'lung%' or ICDOSite like 'lung%' or PrimarysiteX like 'lung%')
	and not HistologyIcdo3X like 'small%' and not HistologyIcdo3X  like 'carcinoid%'


-- MUCH MORE COMPACT CODE
SELECT TOP (200) 
[patientsid],[Sta3n],[Stagegroupclinical] ,[StageGroupingajcc] ,[SitegpX],[ICDOSite],[PrimarysiteX],[Histologyicdo3X] -- last good one?
      ,[DateDX],[Histologyicdo2X],[SeerSummaryStage2000]
  FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
  where (SitegpX like 'lung%' or ICDOSite like 'lung%' or PrimarysiteX like 'lung%')
	and not HistologyIcdo3X like 'small%' and not HistologyIcdo3X  like 'carcinoid%' and not HistologyIcdo3X  like 'neuro%'

-- COUNTS

select count(*)
  FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
    where (SitegpX like 'lung%' or ICDOSite like 'lung%' or PrimarysiteX like 'lung%')
-- 71583
	and not HistologyIcdo3X like 'small%' and not HistologyIcdo3X  like 'carcinoid%' and not HistologyIcdo3X  like 'neuro%'
	--62466

-- BY CLINICAL

SELECT count(*) as n, [Stagegroupclinical] 
FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
        where (SitegpX like 'lung%' or ICDOSite like 'lung%' or PrimarysiteX like 'lung%')
	    --and not HistologyIcdo3X like 'small%' and not HistologyIcdo3X  like 'carcinoid%' and not HistologyIcdo3X  like 'neuro%'
	group by Stagegroupclinical
	order by n desc

/*

DON'T USE ME. THESE DATA INCLUDE SMALL CELL.

n	Stagegroupclinical
14566	1A
14138	4
11394	NULL
6902	3A
5364	99
4890	1B
3984	3B
2486	2B
2317	2A
1205	1A2
1054	4B
839	4A
829	1
409	88
301	1A1
237	OC
182	2
162	3
137	0
121	3C
37	4C
18	0C
3	0IS
2	1C
2	2A2
1	4A2
1	3C1
1	1B2
1	1S
*/

-- BY AJCC INCLUDING SMALL CELL

SELECT count(*) as n, Stagegroupingajcc 
FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
    where SitegpX like 'lung%' or ICDOSite like 'lung%' or PrimarysiteX like 'lung%'
	group by Stagegroupingajcc
	order by n desc

/*
n	Stagegroupingajcc
22712	I
16199	IV
11706	III
11012	NULL
6271	II
3055	Unk/Uns
407	NA
221	0

I and II = 28,983
0 I II  = 29204
III and IV = 27,905

Ratio 1.05:1
Or late/total = 0.489

Null unk na = 14474
57109 staged. Tot 71583. Checks out perfectly.
*/

-- BY AJCC EXCLUDE SMALL CELL
-- GOOD STUFF NEXT STATEMENT

SELECT count(*) as n, Stagegroupingajcc 
FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
		where (SitegpX like 'lung%' or ICDOSite like 'lung%' or PrimarysiteX like 'lung%')
		and not HistologyIcdo3X like 'small%' and not HistologyIcdo3X  like 'carcinoid%' and not HistologyIcdo3X  like 'neuro%'	
		group by Stagegroupingajcc
	order by n desc

/*

n	Stagegroupingajcc
21749	I
12729	IV
10144	III
8877	NULL
5852	II
2645	Unk/Uns
258	NA
212	0

*/

-- EARLY

SELECT count(*) 
FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
		where (SitegpX like 'lung%' or ICDOSite like 'lung%' or PrimarysiteX like 'lung%')
		and not HistologyIcdo3X like 'small%' and not HistologyIcdo3X  like 'carcinoid%' and not HistologyIcdo3X  like 'neuro%'	
		and (Stagegroupingajcc = 'I' or Stagegroupingajcc = 'II' or Stagegroupingajcc = '0')
--27813

--LATE

SELECT count(*) 
FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
		where (SitegpX like 'lung%' or ICDOSite like 'lung%' or PrimarysiteX like 'lung%')
		and not HistologyIcdo3X like 'small%' and not HistologyIcdo3X  like 'carcinoid%' and not HistologyIcdo3X  like 'neuro%'	
		and (Stagegroupingajcc = 'III' or Stagegroupingajcc = 'IV')
--22873




-------- COLON --------

SELECT TOP (200) 
[patientsid],[Sta3n],[Stagegroupclinical] ,[StageGroupingajcc] ,[SitegpX],[ICDOSite],[PrimarysiteX],[Histologyicdo3X] -- last good one?
      ,[DateDX],[Histologyicdo2X],[SeerSummaryStage2000]
  FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
  where (SitegpX like 'colo%' or ICDOSite like 'colo%' or PrimarysiteX like 'colo%')
	--and not HistologyIcdo3X like 'small%' and not HistologyIcdo3X  like 'carcinoid%' and not HistologyIcdo3X  like 'neuro%'

select count(*) as n, [Histologyicdo3X]
from [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
where (SitegpX like 'colo%' or ICDOSite like 'colo%' or PrimarysiteX like 'colo%')
group by Histologyicdo3X
order by n desc
-- 128 rows
/*
23383	ADENOCARCINOMA, NOS
1869	MUCINOUS ADENOCARCINOMA
1784	ADENOCARCINOMA ADENOMATOUS IN POLYP
1763	ADENOCARCINOMA IN TUBULOVILLOUS ADENOMA
1192	ADENOCA IN SITU IN TUBULOVILLOUS ADENOMA
1127	ADENOCARCINOMA IN SITU IN ADENOMATOUS POLYP
840	ADENOCARCINOMA IN SITU, NOS
806	CARCINOMA IN SITU, NOS
458	CARCINOID TUMOR, NOS
420	ADENOCARCINOMA IN VILLOUS ADENOMA
369	NULL
336	CARCINOMA, NOS
271	MUCIN-PRODUCING ADENOCARCINOMA
260	SIGNET RING CELL CARCINOMA
242	NEOPLASM, MALIGNANT
218	ADENOCARCINOMA IN SITU IN VILLOUS ADENOMA
211	NEUROENDOCRINE CARCINOMA, NOS
89	ATYPICAL ADENOMA
88	GOBLET CELL CARCINOID
79	MALIGNANT LYMPHOMA, LRGE B-CELL, DIFFUSE, NOS
57	CARCINOID TUMOR OF UNCERTAIN MALIG POTENTIAL
52	MANTLE CELL LYMPHOMA
46	ADENOCARCINOMA WITH MIXED SUBTYPES
45	MARGINAL ZONE B-CELL LYMPHOMA, NOS
39	MEDULLARY CARCINOMA, NOS                    ***  1%
33	TUBULAR ADENOCARCINOMA IN SITU              ***  <1%
32	VILLOUS ADENOMA, NOS
32	TUMOR CELLS, MALIGNANT
31	TUBULAR ADENOCARCINOMA
28	COMPOSITE CARCINOID
28	GASTROINTESTINAL STROMAL SARCOMA
28	ADENOMA, NOS
*/

-- bad ones:

/*
458	CARCINOID TUMOR, NOS
211	NEUROENDOCRINE CARCINOMA, NOS
89	ATYPICAL ADENOMA
88	GOBLET CELL CARCINOID
79	MALIGNANT LYMPHOMA, LRGE B-CELL, DIFFUSE, NOS
57	CARCINOID TUMOR OF UNCERTAIN MALIG POTENTIAL
52	MANTLE CELL LYMPHOMA
45	MARGINAL ZONE B-CELL LYMPHOMA, NOS
32	VILLOUS ADENOMA, NOS
28	COMPOSITE CARCINOID
28	GASTROINTESTINAL STROMAL SARCOMA
28	ADENOMA, NOS
*/

--false pos examples
SELECT TOP (200) 
[patientsid],[Sta3n],[Stagegroupclinical] ,[StageGroupingajcc] ,[SitegpX],[ICDOSite],[PrimarysiteX],[Histologyicdo3X] -- last good one?
      ,[DateDX],[Histologyicdo2X],[SeerSummaryStage2000]
  FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
  where (SitegpX like 'colo%' or ICDOSite like 'colo%' or PrimarysiteX like 'colo%')
  and Histologyicdo3X like 'carcinoid%'

SELECT count(*)
  FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
  where (SitegpX like 'colo%' or ICDOSite like 'colo%' or PrimarysiteX like 'colo%')
--36705

SELECT count(*)
  FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
  where (SitegpX like 'colo%' or ICDOSite like 'colo%' or PrimarysiteX like 'colo%')
  and not (Histologyicdo3X like 'carcinoid%' or 
  Histologyicdo3X like 'neuro%' or 
  Histologyicdo3X like 'atypical adenom%' or 
  Histologyicdo3X like 'goblet cell carcinoi%' or 
  Histologyicdo3X like 'malignant lymp%' or 
  Histologyicdo3X like 'mantle%' or 
  Histologyicdo3X like 'marginal%' or 
  Histologyicdo3X like 'villous adenom%' or 
  Histologyicdo3X like 'composite carcinoi%' or 
  Histologyicdo3X like 'gastrointestinal strom%' or 
  Histologyicdo3X like 'adenoma%')
  --35089

select count(*) as n, [Histologyicdo3X]
  FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
  where (SitegpX like 'colo%' or ICDOSite like 'colo%' or PrimarysiteX like 'colo%')
  and not (Histologyicdo3X like 'carcinoid%' or 
  Histologyicdo3X like 'neuro%' or 
  Histologyicdo3X like 'atypical adenom%' or 
  Histologyicdo3X like 'goblet cell carcinoi%' or 
  Histologyicdo3X like 'malignant lymp%' or 
  Histologyicdo3X like 'mantle%' or 
  Histologyicdo3X like 'marginal%' or 
  Histologyicdo3X like 'villous adenom%' or 
  Histologyicdo3X like 'composite carcinoi%' or 
  Histologyicdo3X like 'gastrointestinal strom%' or 
  Histologyicdo3X like 'adenoma%')
group by Histologyicdo3X
order by n desc
-- 104 rows

-- double percent
select count(*) as n, [Histologyicdo3X]
  FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
  where (SitegpX like 'colo%' or ICDOSite like 'colo%' or PrimarysiteX like 'colo%')
  and not (Histologyicdo3X like '%carcinoid%' or 
  Histologyicdo3X like '%neuro%' or 
  Histologyicdo3X like '%adenoma%' or 
  Histologyicdo3X like '%lymph%' or 
  Histologyicdo3X like 'gastrointestinal strom%' or
  Histologyicdo3X like '%sarcoma%')
group by Histologyicdo3X
order by n desc
-- 66 rows, performs OK. 




/* DONE REFINING WHERE CLAUSE */

select TOP (200) 
[patientsid],[Sta3n],[Stagegroupclinical] ,[StageGroupingajcc] ,[SitegpX],[ICDOSite],[PrimarysiteX],[Histologyicdo3X] -- last good one?
      ,[DateDX],[Histologyicdo2X],[SeerSummaryStage2000]
  FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
  where (SitegpX like 'colo%' or ICDOSite like 'colo%' or PrimarysiteX like 'colo%')
  and not (Histologyicdo3X like '%carcinoid%' or 
  Histologyicdo3X like '%neuro%' or 
  Histologyicdo3X like '%adenoma%' or 
  Histologyicdo3X like '%lymph%' or 
  Histologyicdo3X like 'gastrointestinal strom%' or
  Histologyicdo3X like '%sarcoma%')

-- GOOD STUFF NEXT STATEMENT

select count(*) as n, [StageGroupingajcc] 
  FROM [ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5]
  where (SitegpX like 'colo%' or ICDOSite like 'colo%' or PrimarysiteX like 'colo%')
  and not (Histologyicdo3X like '%carcinoid%' or 
  Histologyicdo3X like '%neuro%' or 
  Histologyicdo3X like '%adenoma%' or 
  Histologyicdo3X like '%lymph%' or 
  Histologyicdo3X like 'gastrointestinal strom%' or
  Histologyicdo3X like '%sarcoma%')
group by StageGroupingajcc
order by n desc

/*
n	StageGroupingajcc
6781	II
6699	I
5897	III
2790	IV
2469	NULL
1999	Unk/Uns
1738	0
28	NA
*/









/************************ LOOK AT ICD CODES ************************/

-- YOU CAN SKIP THIS INITIAL EXPLORATION AND GO DO WHERE IT SAYS "--RUN"

-- Expect C18 colon, C19 rectosig, C20 rectum
select top 10 
icd10sid, icdien, sta3n, ICD10Code
from CDWWork.dim.ICD10
where ICD10Code like 'c18%'

select count(*)
from CDWWork.dim.ICD10
where ICD10Code like 'c18%' --1300
or icd10code like 'c19%' or ICD10Code like 'c20%' --1560 for all 3 codes

--lung
-- C34.0 main bronch, .1 upper, .2 middle, 3 lower, 8 other, 90 unspec
-- really can just do C34*.
select top 100
icd10sid, icdien, sta3n, ICD10Code
from CDWWork.dim.ICD10
where ICD10Code like 'c34%'

select count(*)
from CDWWork.dim.ICD10
where ICD10Code like 'c34%' --2080
and Sta3n = 580 -- 16

select * from CDWWork.dim.ICD10 where ICD10Code like 'c34%' and Sta3n = 580

-- temp tables

drop table #ajz_lungca_outpats

select top 100
patientsid, VisitDateTime, PrimarySecondary, ICD10Code
into #ajz_lungca_outpats
from ORD_Singh_202001030D.src.Outpat_VDiagnosis as outpa
inner join
cdwwork.dim.icd10 as icd
on icd.icd10sid = outpa.icd10sid
where outpa.sta3n=580 and outpa.ICD10SID > 0 and icd.ICD10Code like 'c34%'

select count(*) as N into #ajz_deleteme
from ORD_Singh_202001030D.src.Outpat_VDiagnosis as outpa
inner join
cdwwork.dim.icd10 as icd
on icd.icd10sid = outpa.icd10sid
where outpa.sta3n=580 and outpa.ICD10SID > 0 and icd.ICD10Code like 'c34%'

-- 26996 diagnoses in HOU for lung CA, in unk. no. of pts.

--tempdb.dbp.#blah

select * from #ajz_deleteme
select * from #ajz_lungca_outpats
select distinct patientsid from #ajz_lungca_outpats -- SELECT TOP 10 visits but 8 PatientSID. Or 100:50.

-- join with registry

select distinct outpa.patientsid, outpa.PrimarySecondary, outpa.ICD10Code
	,reg.[Stagegroupclinical] ,reg.[StageGroupingajcc] ,reg.[SitegpX],reg.[ICDOSite],reg.[PrimarysiteX],reg.[Histologyicdo3X] 
      ,reg.[DateDX],reg.[Histologyicdo2X],reg.[SeerSummaryStage2000]
	  --drop visitDateTime
from #ajz_lungca_outpats as outpa
left join
[ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5] as reg
on outpa.PatientSID = reg.PatientSID
order by patientsid

--narrow down more.
select distinct outpa.patientsid, outpa.ICD10Code
	,reg.datedx
	,reg.[Stagegroupclinical] ,reg.[StageGroupingajcc] ,reg.[SitegpX],reg.[ICDOSite],reg.[PrimarysiteX],reg.[Histologyicdo3X] 
      ,reg.[SeerSummaryStage2000]
from #ajz_lungca_outpats as outpa
left join
[ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5] as reg
on outpa.PatientSID = reg.PatientSID
order by patientsid, DateDX
--insight: people may be in there with more than 1 datedx.

--narrower. 
select distinct outpa.patientsid 
	,reg.[SitegpX],reg.[ICDOSite] --reg.[PrimarysiteX] --reg.[Histologyicdo3X] is too granular. So is reg.[SeerSummaryStage2000]
	, (case when reg.SitegpX like 'lung%' then 'Y' else NULL end) as is_lung
from #ajz_lungca_outpats as outpa
left join
[ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5] as reg
on outpa.PatientSID = reg.PatientSID
order by patientsid
--If include histologyICDO3X:  14 rows instead of 19
-- Drop histology and seersummary: 12 rows
-- drop primarySiteX: 11 rows

/* That was nice. Now increase the number in the temp table. */

-- 100 outpat dx --> 65 rows. (?)



-- GOOD STUFF NEXT STATEMENTS
--RUN
drop table #ajz_lungca_sidonly

select distinct top 10000 --10000 = 5 sec = 1544 patientSID
patientsid
into #ajz_lungca_sidonly
from ORD_Singh_202001030D.src.Outpat_VDiagnosis as outpa
inner join
cdwwork.dim.icd10 as icd
on icd.icd10sid = outpa.icd10sid
where outpa.sta3n=580 and outpa.ICD10SID > 0 and icd.ICD10Code like 'c34%'

--RUN
drop table #ajz_icd_reg

select distinct lung.patientsid ,reg.[SitegpX],reg.[ICDOSite] 
into #ajz_icd_reg
from #ajz_lungca_sidonly as lung
left join
[ORD_Singh_202001030D].[Src].[Oncology_Oncology_Primary_165_5] as reg
on lung.PatientSID = reg.PatientSID
order by patientsid -- 1931 rows

select top 10 * from #ajz_icd_reg

select distinct patientsid from #ajz_icd_reg
where SitegpX like 'lung%'

-- 96/100  ! Surprisingly most are in registry under LUNG.
-- or 1176 / 1931, when we used 10,000 as our base param.
-- 60.9%
-- Bear in mind, this is anyone with ONE OR MORE visit for lung cancer, using OUTPATIENT VISITS ONLY.
-- Not even the stringent criterion of TWO OR MORE visits with ICD tag for lung cancer.
