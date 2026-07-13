# altair-slc-running-pspp-the-spss-clone-in-linux-within-windows-using-ms-wsl
Altair slc running pspp the spss clone in linux within windows using ms wsl
    %let pgm=altair-slc-running-pspp-the-spss-clone-in-linux-within-windows-using-ms-wsl;

    %stop_submission;

    Altair slc running pspp the spss clone in linux within windows using ms wsl

    Example: Run a regression height on weight using ubuntu linux.

    Too long to post, see github
    https://github.com/rogerjdeangelis/altair-slc-running-pspp-the-spss-clone-in-linux-within-windows-using-ms-wsl

    There is a gui for pspp.

    CONTENTS

      1 preparation (installing pspp in linux)
      2 windows: create slc dataset
      3 windows: convert slc dataset to spss dataset
      4 linux: run spss regression
      5 run from linux commandline
      6 drop down pspp macro
        The most recent macro is at
        https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories


    Related Repos
    -----------------------------------------------------------------------------------------------------------------------------
    https://github.com/rogerjdeangelis/altair-slc-running-ubuntu-linux-from-windows-using-ms-wsl

    https://github.com/rogerjdeangelis/utl-connecting-spss-pspp-to-postgresql-sample-problem-compute-mean-weight-by-sex
    https://github.com/rogerjdeangelis/utl-dropping-down-to-spss-using-the-pspp-free-clone-and-running-a-spss-linear-regression
    https://github.com/rogerjdeangelis/utl-using-open-source-pspp-to-convert-spss-programs-to-sas-or-other-languages
    https://github.com/rogerjdeangelis/utl-using-sas-compatible-character-and-numeric-missing-values-in-spss-pspp

    https://github.com/rogerjdeangelis/altair-slc-linux-python-su2-script-simulating-a-hydrofoil
    https://github.com/rogerjdeangelis/utl-parsing-windows-and-linux-paths-into-components-in-wps-windows-and-linux

    /*                                        _   _
    / |  _ __  _ __ ___ _ __   __ _ _ __ __ _| |_(_) ___  _ __
    | | | `_ \| `__/ _ \ `_ \ / _` | `__/ _` | __| |/ _ \| `_ \
    | | | |_) | | |  __/ |_) | (_| | | | (_| | |_| | (_) | | | |
    |_| | .__/|_|  \___| .__/ \__,_|_|  \__,_|\__|_|\___/|_| |_|
        |_|            |_|
    */
       /*--- INSTALL PSPP. A SPSS CLONE IN UBUNTU LINUX          ---*/
       /*--- FROM MEMORY MAY NOT BE CORRECT BUT SHOULD BE CLOSE  ---*/

       Open a dos command window as admin
       Type wsl

       Microsoft Windows [Version 10.0.26200.8737]
       (c) Microsoft Corporation. All rights reserved.

       C:\Windows\System32>wsl
       xlr82sas@SLC:/mnt/c/Windows/System32$

       sudo apt update
       sudo apt install pspp

       You should get

       xlr82sas@SLC:/mnt/c/Windows/System32$
       xlr82sas@SLC:/mnt/c/Windows/System32$ cd /usr/bin
       xlr82sas@SLC:/usr/bin$
       xlr82sas@SLC:/usr/bin$ls -l pspp*

       /usr/bin/pspp
       /usr/bin/pspp-convert
       /usr/bin/pspp-output
       /usr/bin/psppire
       /usr/lib

    /*___    _                   _
    |___ \  (_)_ __  _ __  _   _| |_
      __) | | | `_ \| `_ \| | | | __|
     / __/  | | | | | |_) | |_| | |_
    |_____| |_|_| |_| .__/ \__,_|\__|
                    |_|
    */

    /*--- CREATE SLC DATASET ---*/

    libname workx "d:/wpswrkx";
    libname workx sas7bdat "d:/wpswrkx";

    options validvarname=upcase;
    data workx.mathclass;
       informat
         NAME $8.
         SEX $1.
         AGE 8.
         HEIGHT 8.
         WEIGHT 8.
    ;
    input NAME SEX AGE HEIGHT WEIGHT;
    cards4;
    Alfred M 14 69 112.5
    Alice F 13 56.5 84
    Barbara F 13 65.3 98
    Carol F 14 62.8 102.5
    Henry M 14 63.5 102.5
    James M 12 57.3 83
    Jane F 12 59.8 84.5
    Janet F 15 62.5 112.5
    Jeffrey M 13 62.5 84
    John M 12 59 99.5
    Joyce F 11 51.3 50.5
    Judy F 14 64.3 90
    Louise F 12 56.3 77
    Mary F 15 66.5 112
    Philip M 16 72 150
    Robert M 12 64.8 128
    Ronald M 15 67 133
    Thomas M 11 57.5 85
    William M 15 66.5 112
    ;;;;
    run;quit;

    /**************************************************************************************************************************/
    /*  WORKX.MATHCLASS total obs=19 13JUL2026:08:20:58                                                                       */
    /* Obs   NAME       SEX    AGE    HEIGHT    WEIGHT                                                                        */
    /*                                                                                                                        */
    /*  1    Alfred      M      14     69.0      112.5                                                                        */
    /*  2    Alice       F      13     56.5       84.0                                                                        */
    /*  3    Barbara     F      13     65.3       98.0                                                                        */
    /* ...                                                                                                                    */
    /* 16    Robert      M      12     64.8      128.0                                                                        */
    /* 17    Ronald      M      15     67.0      133.0                                                                        */
    /* 18    Thomas      M      11     57.5       85.0                                                                        */
    /* 19    William     M      15     66.5      112.0                                                                        */
    /**************************************************************************************************************************/

    /*____                      _                                _       _                 _
    |___ /   ___ _ __ ___  __ _| |_ ___   ___ _ __  ___ ___   __| | __ _| |_ __ _ ___  ___| |_
      |_ \  / __| `__/ _ \/ _` | __/ _ \ / __| `_ \/ __/ __| / _` |/ _` | __/ _` / __|/ _ \ __|
     ___) || (__| | |  __/ (_| | ||  __/ \__ \ |_) \__ \__ \| (_| | (_| | || (_| \__ \  __/ |_
    |____/  \___|_|  \___|\__,_|\__\___| |___/ .__/|___/___/ \__,_|\__,_|\__\__,_|___/\___|\__|
                                             |_|
    */

    /*--- SAVE DATASET IN UBUNTU LINUX FOLDER                          ---*/

    %utlfkil("\\wsl.localhost\Ubuntu\home\xlr82sas\temp\pspp.sav");

    options validvarname=v7;
    options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
    proc r;
    export data=workx.mathclass r=mathclass;
    submit;
    library(haven)
    write_sav(mathclass,"\\\\wsl.localhost\\Ubuntu\\home\\xlr82sas\\temp\\pspp.sav");
    endsubmit;
    run;

    /*
    | | ___   __ _
    | |/ _ \ / _` |
    | | (_) | (_| |
    |_|\___/ \__, |
             |___/
    */

    1                                          Altair SLC           08:27 Monday, July 13, 2026

    NOTE: Copyright 2002-2025 World Programming, an Altair Company
    NOTE: Altair SLC 2026 (05.26.01.00.000758)
          Licensed to Roger DeAngelis
    NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

    NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas

    NOTE: AUTOEXEC processing completed

    1         %utlfkil("\\wsl.localhost\Ubuntu\home\xlr82sas\temp\pspp.sav");
    2
    3         options validvarname=v7;
    4         options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
    5         proc r;
    NOTE: Using R version 4.5.2 (2025-10-31 ucrt) from C:\Program Files\R\R-4.5.2
    6         export data=workx.mathclass r=mathclass;
    NOTE: Creating R data frame 'mathclass' from data set 'WORKX.mathclass'

    7         submit;
    8         library(haven)
    9         write_sav(mathclass,"\\\\wsl.localhost\\Ubuntu\\home\\xlr82sas\\temp\\pspp.sav");
    10        endsubmit;

    NOTE: Submitting statements to R:

    > library(haven)
    > write_sav(mathclass,"\\\\wsl.localhost\\Ubuntu\\home\\xlr82sas\\temp\\pspp.sav");

    NOTE: Processing of R statements complete

    11        run;
    NOTE: Procedure r step took :
          real time : 0.905
          cpu time  : 0.015



    NOTE: Submitted statements took :
          real time : 1.100
          cpu time  : 0.109

    /*  _                                                         _
    | || |    _ __ _   _ _ __    _ __ ___  __ _ _ __ ___  ___ ___(_) ___  _ __
    | || |_  | `__| | | | `_ \  | `__/ _ \/ _` | `__/ _ \/ __/ __| |/ _ \| `_ \
    |__   _| | |  | |_| | | | | | | |  __/ (_| | | |  __/\__ \__ \ | (_) | | | |
       |_|   |_|   \__,_|_| |_| |_|  \___|\__, |_|  \___||___/___/_|\___/|_| |_|
                                          |___/
    */

    %utlfkil(\\wsl$\Ubuntu\home\xlr82sas\temp\reg.sav);

    %slc_lxSPSSbegin;
    cards4;
    GET FILE="/home/xlr82sas/temp/pspp.sav" .
    REGRESSION
    /VARIABLES=weight height
      /DEPENDENT=height
      /METHOD=ENTER
      /SAVE PRED RESID.
    SAVE
     OUTFILE="/home/xlr82sas/temp/reg.sav" .
    GET FILE="/home/xlr82sas/temp/reg.sav".
    LIST .
    ;;;;
    %slc_lxSPSSend;

    /**************************************************************************************************************************/
    /* \\wsl$\Ubuntu\home\xlr82sas\temp\pspp.log                                                                              */
    /*                                                                                                                        */
    /* Altair SLC                                                                                                             */
    /*                    Model Summary (HEIGHT)                                                                              */
    /* +---+--------+-----------------+--------------------------+                                                            */
    /* | R |R Square|Adjusted R Square|Std. Error of the Estimate|                                                            */
    /* +---+--------+-----------------+--------------------------+                                                            */
    /* |.88|     .77|              .76|                      2.53|                                                            */
    /* +---+--------+-----------------+--------------------------+                                                            */
    /*                                                                                                                        */
    /*                     ANOVA (HEIGHT)                                                                                     */
    /* +----------+--------------+--+-----------+-----+----+                                                                  */
    /* |          |Sum of Squares|df|Mean Square|  F  |Sig.|                                                                  */
    /* +----------+--------------+--+-----------+-----+----+                                                                  */
    /* |Regression|        364.58| 1|     364.58|57.08|.000|                                                                  */
    /* |Residual  |        108.59|17|       6.39|     |    |                                                                  */
    /* |Total     |        473.16|18|           |     |    |                                                                  */
    /* +----------+--------------+--+-----------+-----+----+                                                                  */
    /*                                                                                                                        */
    /*                              Coefficients (HEIGHT)                                                                     */
    /* +----------+----------------------------+-------------------------+-----+----+                                         */
    /* |          | Unstandardized Coefficients|Standardized Coefficients|     |    |                                         */
    /* |          +-----------+----------------+-------------------------+     |    |                                         */
    /* |          |     B     |   Std. Error   |           Beta          |  t  |Sig.|                                         */
    /* +----------+-----------+----------------+-------------------------+-----+----+                                         */
    /* |(Constant)|      42.57|            2.68|                      .00|15.89|.000|                                         */
    /* |WEIGHT    |        .20|             .03|                      .88| 7.55|.000|                                         */
    /* +----------+-----------+----------------+-------------------------+-----+----+                                         */
    /*                                                                                                                        */
    /*                   Data List                                                                                            */
    /* +-------+---+-----+------+------+-----+-----+                                                                          */
    /* |  NAME |SEX| AGE |HEIGHT|WEIGHT| RES1|PRED1|                                                                          */
    /* +-------+---+-----+------+------+-----+-----+                                                                          */
    /* |Alfred |M  |14.00| 69.00|112.50| 4.20|64.80|                                                                          */
    /* |Alice  |F  |13.00| 56.50| 84.00|-2.67|59.17|                                                                          */
    /* |Barbara|F  |13.00| 65.30| 98.00| 3.36|61.94|                                                                          */
    /* |Carol  |F  |14.00| 62.80|102.50| -.03|62.83|                                                                          */
    /* |Henry  |M  |14.00| 63.50|102.50|  .67|62.83|                                                                          */
    /* |James  |M  |12.00| 57.30| 83.00|-1.67|58.97|                                                                          */
    /* |Jane   |F  |12.00| 59.80| 84.50|  .53|59.27|                                                                          */
    /* |Janet  |F  |15.00| 62.50|112.50|-2.30|64.80|                                                                          */
    /* |Jeffrey|M  |13.00| 62.50| 84.00| 3.33|59.17|                                                                          */
    /* |John   |M  |12.00| 59.00| 99.50|-3.23|62.23|                                                                          */
    /* |Joyce  |F  |11.00| 51.30| 50.50|-1.25|52.55|                                                                          */
    /* |Judy   |F  |14.00| 64.30| 90.00| 3.94|60.36|                                                                          */
    /* |Louise |F  |12.00| 56.30| 77.00|-1.49|57.79|                                                                          */
    /* |Mary   |F  |15.00| 66.50|112.00| 1.80|64.70|                                                                          */
    /* |Philip |M  |16.00| 72.00|150.00| -.21|72.21|                                                                          */
    /* |Robert |M  |12.00| 64.80|128.00|-3.06|67.86|                                                                          */
    /* |Ronald |M  |15.00| 67.00|133.00|-1.85|68.85|                                                                          */
    /* |Thomas |M  |11.00| 57.50| 85.00|-1.87|59.37|                                                                          */
    /* |William|M  |15.00| 66.50|112.00| 1.80|64.70|                                                                          */
    /* +-------+---+-----+------+------+-----+-----+                                                                          */
    /**************************************************************************************************************************/

    /*
    | | ___   __ _
    | |/ _ \ / _` |
    | | (_) | (_| |
    |_|\___/ \__, |
             |___/
    */

    /*___                                                  _ _ _
    | ___|    ___ ___  _ __ ___  _ __ ___   __ _ _ __   __| | (_)_ __   ___
    |___ \   / __/ _ \| `_ ` _ \| `_ ` _ \ / _` | `_ \ / _` | | | `_ \ / _ \
     ___) | | (_| (_) | | | | | | | | | | | (_| | | | | (_| | | | | | |  __/
    |____/   \___\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|_|_|_| |_|\___|

    */

    wsl /usr/bin/pspp /home/xlr82sas/temp/pspp.ps -o /home/xlr82sas/temp/pspp.log

    /*--- SAME OUTPUT \\wsl$\Ubuntu\home\xlr82sas\temp\pspp.log   ---*/

    /*__         _                       _                                              _      _
     / /_     __| |_ __ ___  _ __     __| | _____      ___ __   ___  __ _ _ ____      _(_) ___| |__
    | `_ \   / _` | `__/ _ \| `_ \   / _` |/ _ \ \ /\ / / `_ \ / __|/ _` | `_ \ \ /\ / / |/ __| `_ \
    | (_) | | (_| | | | (_) | |_) | | (_| | (_) \ V  V /| | | |\__ \ (_| | | | \ V  V /| | (__| | | |
     \___/   \__,_|_|  \___/| .__/   \__,_|\___/ \_/\_/ |_| |_||___/\__,_|_| |_|\_/\_/ |_|\___|_| |_|
                            |_|
    */

    data _null_;
      file "c:/wpsoto/slc_lxSPSSbegin.sas";
      input;
      put _infile_;
    cards4;
    %macro slc_lxSPSSbegin;
      %utlfkil(\\wsl$\Ubuntu\home\xlr82sas\temp\pspp.ps);
      %utlfkil(\\wsl$\Ubuntu\home\xlr82sas\temp\pspp.log);
      data _null_;
        file  "\\wsl$\Ubuntu\home\xlr82sas\temp\pspp.ps";
        input;
        put _infile_;
    %mend slc_lxSPSSbegin;
    ;;;;
    run;

    data _null_;
      file "c:/wpsoto/slc_lxSPSSend.sas";
      input;
      put _infile_;
    cards4;
    %macro slc_lxSPSSend(returnvar=N);
    /*---you need to write to the winsows clipboard fro ubuntu to return the contents to the slc ---*/
    options noxwait noxsync;
    filename rut pipe  "wsl /usr/bin/pspp /home/xlr82sas/temp/pspp.ps -o /home/xlr82sas/temp/pspp.log ";
    run;quit;
      data _null_;
        file print;
        infile rut recfm=v lrecl=32756;
        input;
        put _infile_;
        putlog _infile_;
      run;
      /*--- SEND THE OUTPUT TO THE LIST ALSO IN THE LOG ---*/
      data _null_;
       infile "\\wsl$\Ubuntu\home\xlr82sas\temp\pspp.log";
       input;
       file print;
       put _infile_;
      run;
      * use the clipboard to create macro variable;
      %if %upcase(%substr(&returnVar.,1,1)) ne N %then %do;
        filename clp clipbrd ;
        data _null_;
         length txt $200;
         infile clp;
         input;
         putlog "macro variable &returnVar = " _infile_;
         call symputx("&returnVar.",_infile_,"G");
        run;quit;
      %end;
    %mend slc_lxSPSSend;
    ;;;;
    run;

    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */
