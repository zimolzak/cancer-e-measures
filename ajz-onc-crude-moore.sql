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
