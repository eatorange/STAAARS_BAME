   * ******************************************************************** *
   * ******************************************************************** *
   *                                                                      *
   *               your_round_name                                        *
   *               MASTER DO_FILE                                         *
   *                                                                      *
   * ******************************************************************** *
   * ******************************************************************** *

       /*
       ** PURPOSE:      Write intro to survey round here

       ** OUTLINE:      PART 0: Standardize settings and install packages
                        PART 1: Prepare folder path globals
                        PART 2: Run the master dofiles for each high-level task

       ** IDS VAR:      list_ID_var_here         //Uniquely identifies households (update for your project)

       ** NOTES:

       ** WRITTEN BY:   names_of_contributors

       ** Last date modified: 13 Aug 2020
       */

*iefolder*0*StandardSettings****************************************************
*iefolder will not work properly if the line above is edited

   * ******************************************************************** *
   *
   *       PART 0:  INSTALL PACKAGES AND STANDARDIZE SETTINGS
   *
   *           - Install packages needed to run all dofiles called
   *            by this master dofile.
   *           - Use ieboilstart to harmonize settings across users
   *
   * ******************************************************************** *

*iefolder*0*End_StandardSettings************************************************
*iefolder will not work properly if the line above is edited

   *Install all packages that this project requires:
   *(Note that this never updates outdated versions of already installed commands, to update commands use adoupdate)
   local user_commands ietoolkit       //Fill this list will all user-written commands this project requires
   foreach command of local user_commands {
       cap which `command'
       if _rc == 111 {
           ssc install `command'
       }
   }

   *Standardize settings accross users
   ieboilstart, version(12.1)          //Set the version number to the oldest version used by anyone in the project team
   `r(version)'                        //This line is needed to actually set the version from the command above

*iefolder*1*FolderGlobals*******************************************************
*iefolder will not work properly if the line above is edited

   * ******************************************************************** *
   *
   *       PART 1:  PREPARING FOLDER PATH GLOBALS
   *
   *           - Set the global box to point to the project folder
   *            on each collaborator's computer.
   *           - Set other locals that point to other folders of interest.
   *
   * ******************************************************************** *

   * Users
   * -----------

   * Root folder globals
   * ---------------------
   
   * Add local folder name of each collaborator.
   * `c(username)' is the system macro of STATA which has username
   * To find collaborator's user name, type -di "`c(username)'"- in STATA

   if "`c(username)'"== "Seungmin Lee" {	//	Min, office PC
       global projectfolder "E:\GitHub\US_Food_Dynamics"
   }

   if "`c(username)'"== "xxx" {	//	Min, personal LAPTOP
       global projectfolder "..."
   }
   
   if "`c(username)'"== "xxx" {	//	Liz
       global projectfolder "..."
   }
   
   if "`c(username)'"== "xxx" {	//	Lizzie
       global projectfolder "..."
   }


* These lines are used to test that the name is not already used (do not edit manually)

   * Project folder globals
   * ---------------------

   global dataWorkFolder         "$projectfolder/DataWork"

*iefolder*1*FolderGlobals*master************************************************
*iefolder will not work properly if the line above is edited

   global mastData               "$dataWorkFolder/MasterData" 

*iefolder*1*FolderGlobals*encrypted*********************************************
*iefolder will not work properly if the line above is edited

   global encryptFolder          "$dataWorkFolder/EncryptedData" 

*iefolder*1*FolderGlobals*Consommation******************************************
*iefolder will not work properly if the line above is edited


   *Encrypted round sub-folder globals
   global Consommation           "$dataWorkFolder/Consommation" 

   *Encrypted round sub-folder globals
   global Consommation_encrypt   "$encryptFolder/Round Consommation Encrypted" 
   global Consommation_dtRaw     "$Consommation_encrypt/Raw Identified Data" 
   global Consommation_doImp     "$Consommation_encrypt/Dofiles Import" 
   global Consommation_HFC       "$Consommation_encrypt/High Frequency Checks" 

   *DataSets sub-folder globals
   global Consommation_dt        "$Consommation/DataSets" 
   global Consommation_dtDeID    "$Consommation_dt/Deidentified" 
   global Consommation_dtInt     "$Consommation_dt/Intermediate" 
   global Consommation_dtFin     "$Consommation_dt/Final" 

   *Dofile sub-folder globals
   global Consommation_do        "$Consommation/Dofiles" 
   global Consommation_doCln     "$Consommation_do/Cleaning" 
   global Consommation_doCon     "$Consommation_do/Construct" 
   global Consommation_doAnl     "$Consommation_do/Analysis" 

   *Output sub-folder globals
   global Consommation_out       "$Consommation/Output" 
   global Consommation_outRaw    "$Consommation_out/Raw" 
   global Consommation_outFin    "$Consommation_out/Final" 

   *Questionnaire sub-folder globals
   global Consommation_prld      "$Consommation_quest/PreloadData" 
   global Consommation_doc       "$Consommation_quest/Questionnaire Documentation" 

*iefolder*1*End_FolderGlobals***************************************************
*iefolder will not work properly if the line above is edited


*iefolder*2*StandardGlobals*****************************************************
*iefolder will not work properly if the line above is edited

   * Set all non-folder path globals that are constant accross
   * the project. Examples are conversion rates used in unit
   * standardization, different sets of control variables,
   * adofile paths etc.

   do "$dataWorkFolder/global_setup.do" 


*iefolder*2*End_StandardGlobals*************************************************
*iefolder will not work properly if the line above is edited


*iefolder*3*RunDofiles**********************************************************
*iefolder will not work properly if the line above is edited

   * ******************************************************************** *
   *
   *       PART 3: - RUN DOFILES CALLED BY THIS MASTER DOFILE
   *
   *           - A task master dofile has been created for each high-
   *            level task (cleaning, construct, analysis). By 
   *            running all of them all data work associated with the 
   *            Consommation should be replicated, including output of 
   *            tables, graphs, etc.
   *           - Feel free to add to this list if you have other high-
   *            level tasks relevant to your project.
   *
   * ******************************************************************** *

   **Set the locals corresponding to the tasks you want
   * run to 1. To not run a task, set the local to 0.
   local importDo       0
   local cleaningDo     0
   local constructDo    0
   local analysisDo     0

   if (`importDo' == 1) { // Change the local above to run or not to run this file
       do "$Consommation_doImp/Consommation_import_MasterDofile.do" 
   }

   if (`cleaningDo' == 1) { // Change the local above to run or not to run this file
       do "$Consommation_do/Consommation_cleaning_MasterDofile.do" 
   }

   if (`constructDo' == 1) { // Change the local above to run or not to run this file
       do "$Consommation_do/Consommation_construct_MasterDofile.do" 
   }

   if (`analysisDo' == 1) { // Change the local above to run or not to run this file
       do "$Consommation_do/Consommation_analysis_MasterDofile.do" 
   }

*iefolder*3*End_RunDofiles******************************************************
*iefolder will not work properly if the line above is edited

