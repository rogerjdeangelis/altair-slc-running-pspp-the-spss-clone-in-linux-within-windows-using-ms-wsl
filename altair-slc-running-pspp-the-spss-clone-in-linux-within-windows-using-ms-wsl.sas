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

For drop down to linux pspp(spss) mAcro see.



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

/*___                        _                                _       _                 _
|___ \    ___ _ __ ___  __ _| |_ ___   ___ _ __  ___ ___   __| | __ _| |_ __ _ ___  ___| |_
  __) |  / __| `__/ _ \/ _` | __/ _ \ / __| `_ \/ __/ __| / _` |/ _` | __/ _` / __|/ _ \ __|
 / __/  | (__| | |  __/ (_| | ||  __/ \__ \ |_) \__ \__ \| (_| | (_| | || (_| \__ \  __/ |_
|_____|  \___|_|  \___|\__,_|\__\___| |___/ .__/|___/___/ \__,_|\__,_|\__\__,_|___/\___|\__|
                                          |_|
*/

/*--- SAVE DATASET IN UBUNTU LINUX FOLDER                          ---*/

%utlfkil("\\wsl.localhost\Ubuntu\home\xlr82sas\temp\pspp.sav");

options validvarname=v7;
options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
proc r;
export data=workx.mathclass r=mathclass
submit;
library(haven)
str(mathclass);
write_sav(have,"\\\\wsl.localhost\\Ubuntu\\home\\xlr82sas\\temp\\pspp.sav");
;;;;
%slc_rend;


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


/usr/bin/pspp /home/xlr82sas/temp/pspp.ps -o /home/xlr82sas/temp/pspp.lst



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





data _null_;
 file "\\wsl.localhost\Ubuntu\home\xlr82sas\temp\pspp.ps";
 input;
 put _infile_;
cards4;
GET FILE="/home/xlr82sas/temp/pspp.sav" .
REGRESSION
/VARIABLES=weight height
  /DEPENDENT=height
  /METHOD=ENTER
  /SAVE PRED RESID.
SAVE
 OUTFILE="/home/xlr82sas/temp/reg.sav" .
DUMP-SAV -d "/home/xlr82sas/temp/reg.sav" .
;;;;
run;








Altair slc running ubuntu linux from windows using ms wsl


WSL is not just useful but highly valuable for serious Linux and Python development on Windows 11.
It effectively solves the "Linux-first" problem that has historically plagued
Windows-based  developers and data scientists. Much better that dual boot.
Especially useful for larger linux enviroment applicatons, not to mention r and python.

Too long to post here, see github
https://github.com/rogerjdeangelis/altair-slc-running-ubuntu-linux-from-windows-using-ms-wsl
             _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|

c:/temp/lx_pgm.log

===========================================
Hello from Ubuntu Linux Running in Win 11!
===========================================
Current user: [userid]
Current directory: /mnt/c/utl
Date and time: Tue Jun  9 09:22:33 MST 2026
Hostname: SLC
===========================================

CONTENTS

  1  Preparation
  2  Macro drop down to ubuntu
  3  Non macro ubuntu
  4  Drop down macros on end

Note SLC drop downs are availble for

   1 powershell
   2 python (does not use 'proc python')
   3 cran r (does not use 'proc r')
   4 ms r
   5 spss(pspp clone)
   6 matlib
   7 perl

 Related
   8 odbc mysql
   9 odbc sqlserver

FYI:
  Drop downs can be created for any app that has a CLI?
/*
/ |  _ __  _ __ ___ _ __
| | | `_ \| `__/ _ \ `_ \
| | | |_) | | |  __/ |_) |
|_| | .__/|_|  \___| .__/
    |_|            |_|
*/

How to install wsl (part of windows 11)

Install Linux(Ubuntu))
Open powershell or dos command in admin mode and type

wsl --install

Note: wsl install wsl2.
Installing Linux(ubuntu) can take 20 minutes, but it is fully automatic.


You don't need to search for a separate installer for WSL 2; the easiest way is to install it
directly from the command line on your Windows machine.

Here is a simplified, step-by-step guide to get you started:

Step 1: Install WSL from the Command Line
-----------------------------------------

This
 is the quickest method for Windows 10 (version 2004 and later) and Windows 11.

1.  Open
    **PowerShell** or **Windows Command Prompt** as an **Administrator** (right-click the Start button
    and select "Windows Terminal (Admin)" or "PowerShell (Admin)").
2.  Type the following command
    and press **Enter**:
```bash
   wsl --install
```
3.  **Restart** your computer when
    prompted. This single command automatically enables all the necessary Windows features, installs
    the WSL 2 Linux kernel, and sets WSL 2 as your default version.

Step 2: Install Ubuntu (or Your Preferred Linux Distribution)
-------------------------------------------------------------

    After your computer restarts, the installation will continue automatically. A
    terminal window will open, and you'll be prompted to complete the setup of your Linux distribution.

1.  When the terminal opens, you'll be asked to **create a User Account** and **Password**
    for your new Linux installation. This username and password can be different from your Windows
    login.
2.  Once the process is finished, you will be automatically logged into your new Linux
    environment.

If the distribution doesn't launch automatically, you can find it by searching
 your **Windows Start Menu** for the name of the distribution you installed (e.g., "Ubuntu") .


Step 3: Verify Your Installation
--------------------------------

   To confirm everything is working correctly, open your
   installed Linux distribution (e.g., Ubuntu) from the Start Menu, or run `wsl` in PowerShell.


   You should see a command prompt for your new Linux system. You can then update the package list for
   your distribution with the following command:

   bash
   sudo apt update && sudo apt upgrade

   You'll need to enter the Linux user password you set up earlier to run `sudo`
   commands.

Step 4: Create directories using windows explorer(truly a marvel) or Linux terminal
-----------------------------------------------------------------------------------

 I Windows (use fle explorer to view, create or modify ubuntu files)

   1  open file explorer
   2  under 'This PC' in left pane you should see a penguin icon
      click on it to see your ubuntu file system

      to see your home files navigate to
        linux/ubuntu/home/[your userid]

      create directories temp and examples

 II  ubuntu view, create or modify linux files

      You need to open a command window and typ

      C:\Windows\System32>wsl

         Welcome to Ubuntu 26.04 LTS (GNU/Linux 6.6.114.1-microsoft-standard-WSL2 x86_64)

          * Documentation:  https://docs.ubuntu.com
          * Management:     https://landscape.canonical.com
          * Support:        https://ubuntu.com/pro

          System information as of Tue Jun  9 08:38:55 MST 2026

           System load:  0.0                 Processes:             37
           Usage of /:   0.2% of 1006.85GB   Users logged in:       0
           Memory usage: 0%                  IPv4 address for eth0: 172.26.64.74
           Swap usage:   0%

          * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
            just raised the bar for easy, resilient and secure K8s cluster deployment.

            https://ubuntu.com/engage/secure-kubernetes-at-the-edge

         This message is shown once a day. To disable it please create the
         /home/[your userid]/.hushlogin file.


      [userid]@SLC:/mnt/c/Windows/System32$ cd /home/[userid]
      [userid]@SLC:~$ pwd

      /home/[userid]

      [userid]@SLC:mkdir temp
      [userid]@SLC:mkdir examp les
      [userid]@SLC:ls -l

      drwxr-xr-x 2 [userid] [userid] 4096 Jun  9 08:26 examples
      drwxr-xr-x 2 [userid] [userid] 4096 Jun  9 08:35 temp

 III or with slc

     /*--- create folder, examples' that ubuntu can access ---*/
     data _null_;
       length new $255.;
       new=dcreate('examples','\\wsl$/Ubuntu/home/[userid]');
         if new= '' then put 'Folder creation failed.';
         else put 'Folder created at:'  new;
       new=dcreate('temp','\\wsl$/Ubuntu/home/[userid]');
         if new= '' then put 'Folder creation failed.';
         else put 'Folder created at:'  new;
     run;

     x "dir \\wsl$\Ubuntu\home\[userid]";

     /**************************************************************************************************************************/
     /* Directory of \\wsl$\Ubuntu\home\[userid]                                                                               */
     /*                                                                                                                        */
     /*  6/07/2026  04:14 PM               807 .profile                                                                        */
     /*  6/08/2026  08:26 AM    <DIR>          .landscape                                                                      */
     /*  6/08/2026  10:39 AM             4,241 .bashrc                                                                         */
     /*  6/07/2026  04:15 PM    <DIR>          .cache                                                                          */
     /*  6/08/2026  12:29 PM             3,560 .bash_history                                                                   */
     /*  6/08/2026  08:26 AM                 0 .motd_shown                                                                     */
     /*  6/07/2026  04:15 PM    <DIR>          .config                                                                         */
     /*                                                                                                                        */
     /*  6/08/2026  12:56 PM    <DIR>          examples                                                                        */
     /*                                                                                                                        */
     /*  6/08/2026  12:56 PM    <DIR>          ..                                                                              */
     /*  6/07/2026  04:14 PM               220 .bash_logout                                                                    */
     /**************************************************************************************************************************/

/*___        _                       _                            _                 _
|___ \    __| |_ __ ___  _ __     __| | _____      ___ __   _   _| |__  _   _ _ __ | |_ _   _
  __) |  / _` | `__/ _ \| `_ \   / _` |/ _ \ \ /\ / / `_ \ | | | | `_ \| | | | `_ \| __| | | |
 / __/  | (_| | | | (_) | |_) | | (_| | (_) \ V  V /| | | || |_| | |_) | |_| | | | | |_| |_| |
|_____|  \__,_|_|  \___/| .__/   \__,_|\___/ \_/\_/ |_| |_| \__,_|_.__/ \__,_|_| |_|\__|\__,_|
                        |_|
SEE MACROS ON END OR IN
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories
*/

%slc_lxbegin;
cards4;
#!/bin/bash
echo "========================================="
echo "Hello from Ubuntu Linux Running in Win 11!"
echo "========================================="
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Date and time: $(date)"
echo "Hostname: $(hostname)"
echo "========================================="
;;;;
%slc_lxend;

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

1 print panel
2 log c:/temp/lx_pgm.log


/**************************************************************************************************************************/
/*   =========================================                                                                            */
/*  Hello from Ubuntu Linux Running in Win 11!                                                                            */
/*  =========================================                                                                             */
/*  Current user: [userid]                                                                                                */
/*  Current directory: /mnt/c/utl                                                                                         */
/*  Date and time: Tue Jun  9 09:22:33 MST 2026                                                                           */
/*  Hostname: SLC                                                                                                         */
/*  =========================================                                                                             */
/**************************************************************************************************************************/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

1                                          Altair SLC          10:52 Tuesday, June  9, 2026

NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2026 (05.26.01.00.000758)
      Licensed to Roger DeAngelis
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line
1       +  ï»¿ods _all_ close;
           ^
ERROR: Expected a statement keyword : found "?"

NOTE: AUTOEXEC processing completed

1         %slc_lxbegin;
The file c:/temp/lx_pgm.sh does not exist
The file c:/temp/lx_pgm.log does not exist
2         cards4;

NOTE: The file '\\wsl$\Ubuntu\home\[userid]\temp\lx_pgm.sh' is:
      Filename='\\wsl$\Ubuntu\home\[userid]\temp\lx_pgm.sh',
      File size (bytes)=0,
      Create Time=10:52:09 Jun 09 2026,
      Last Accessed=10:52:09 Jun 09 2026,
      Last Modified=10:52:37 Jun 09 2026,
      Lrecl=32767, Recfm=V

NOTE: 9 records were written to file '\\wsl$\Ubuntu\home\[userid]\temp\lx_pgm.sh'
      The minimum record length was 80
      The maximum record length was 80
NOTE: The data step took :
      real time : 0.018
      cpu time  : 0.000


3         #!/bin/bash
4         echo "========================================="
5         echo "Hello from Ubuntu Linux Running in Win 11!"
6         echo "========================================="
7         echo "Current user: $(whoami)"
8         echo "Current directory: $(pwd)"
9         echo "Date and time: $(date)"
10        echo "Hostname: $(hostname)"
11        echo "========================================="
12        ;;;;
13        %slc_lxend;

NOTE: The infile rut is:
      Unnamed Pipe Access Device,
      Process=wsl bash /home/[userid]/temp/lx_pgm.sh,
      Lrecl=32756, Recfm=V

=========================================
Hello from Ubuntu Linux Running in Win 11!
=========================================
Current user: [userid]
Current directory: /mnt/c/Program Files/IDM Computer Solutions/UltraEdit
Date and time: Tue Jun  9 10:52:37 MST 2026
Hostname: SLC
=========================================
NOTE: 8 records were written to file PRINT

NOTE: 8 records were read from file rut
      The minimum record length was 14
      The maximum record length was 73
NOTE: The data step took :
      real time : 0.654
      cpu time  : 0.046


NOTE: Line generated by the invoked macro "SLC_LXEND"
13      +                                     put _infile_; */                                                                                                                                               run;quit;
                                                                                                                                                                                                                 ^
ERROR: The statement "quit" is unknown in this context

NOTE: DATA step was not executed because of errors detected
NOTE: The data step took :
      real time : 0.000
      cpu time  : 0.000


14
15
ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 1.178
      cpu time  : 0.281


/*--- THIS WORKS ---*/

%utlfkil(\\wsl$\Ubuntu\home\[userid]\examples\hello.sh);
%utlfkil(d:/linux/hello.txt);

/* Create the script (already done, but ensure no BOM or special chars) */
data _null_;
  file "\\wsl$\Ubuntu\home\[userid]\examples\hello.sh";
  input;
  put _infile_;
cards4;
#!/bin/bash
echo "========================================="
echo "Hello from Ubuntu Linux!"
echo "========================================="
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Date and time: $(date)"
echo "Hostname: $(hostname)"
echo "========================================="
;;;;
run;

/* Make executable */
data _null_;
  call system('wsl chmod +x /home/[userid]/examples/hello.sh');
run;

filename pyp pipe "wsl bash /home/[userid]/examples/hello.sh";
data _null_;
  infile pyp;
  input;
  putlog _infile_;
  file "d:/linux/hello.txt";
  put _infile_;
run;

/* Display results */
data _null_;
  infile "d:/linux/hello.txt";
  input;
  put _infile_;
run;

/*____                                                             _                 _
|___ /   _ __   ___  _ __    _ __ ___   __ _  ___ _ __ ___   _   _| |__  _   _ _ __ | |_ _   _
  |_ \  | `_ \ / _ \| `_ \  | `_ ` _ \ / _` |/ __| `__/ _ \ | | | | `_ \| | | | `_ \| __| | | |
 ___) | | | | | (_) | | | | | | | | | | (_| | (__| | | (_) || |_| | |_) | |_| | | | | |_| |_| |
|____/  |_| |_|\___/|_| |_| |_| |_| |_|\__,_|\___|_|  \___/  \__,_|_.__/ \__,_|_| |_|\__|\__,_|
*/

%utlfkil(\\wsl$\Ubuntu\home\[userid]\examples\hello.sh);
%utlfkil(d:/linux/hello.txt);

/* Create the script (already done, but ensure no BOM or special chars) */
data _null_;
  file "\\wsl$\Ubuntu\home\[userid]\examples\hello.sh";
  input;
  put _infile_;
cards4;
#!/bin/bash
echo "========================================="
echo "Hello from Ubuntu Linux!"
echo "========================================="
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Date and time: $(date)"
echo "Hostname: $(hostname)"
echo "========================================="
;;;;
run;

/* Make executable */
data _null_;
  call system('wsl chmod +x /home/[userid]/examples/hello.sh');
run;

filename pyp pipe "wsl bash /home/[userid]/examples/hello.sh";
data _null_;
  infile pyp;
  input;
  putlog _infile_;
  file "d:/linux/hello.txt";
  put _infile_;
run;

/* Display results */
data _null_;
  infile "d:/linux/hello.txt";
  file print;
  input;
  put _infile_;
run;

/**************************************************************************************************************************/
/*  Altair SLC                                                                                                            */
/* =========================================                                                                              */
/* Hello from Ubuntu Linux!                                                                                               */
/* =========================================                                                                              */
/* Current user: [userid]                                                                                                 */
/* Current directory: /mnt/c/Program Files/IDM Computer Solutions/UltraEdit                                               */
/* Date and time: Tue Jun  9 11:07:32 MST 2026                                                                            */
/* Hostname: SLC                                                                                                          */
/* =========================================                                                                              */
/**************************************************************************************************************************/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

1                                          Altair SLC          11:07 Tuesday, June  9, 2026

NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2026 (05.26.01.00.000758)
      Licensed to Roger DeAngelis
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line
1       +  ï»¿ods _all_ close;
           ^
ERROR: Expected a statement keyword : found "?"

NOTE: AUTOEXEC processing completed

1          %utlfkil(\\wsl$\Ubuntu\home\[userid]\examples\hello.sh);
2         %utlfkil(d:/linux/hello.txt);
3
4         /* Create the script (already done, but ensure no BOM or special chars) */
5         data _null_;
6           file "\\wsl$\Ubuntu\home\[userid]\examples\hello.sh";
7           input;
8           put _infile_;
9         cards4;

NOTE: The file '\\wsl$\Ubuntu\home\[userid]\examples\hello.sh' is:
      Filename='\\wsl$\Ubuntu\home\[userid]\examples\hello.sh',
      File size (bytes)=0,
      Create Time=11:07:32 Jun 09 2026,
      Last Accessed=11:07:32 Jun 09 2026,
      Last Modified=11:07:32 Jun 09 2026,
      Lrecl=32767, Recfm=V

NOTE: 9 records were written to file '\\wsl$\Ubuntu\home\[userid]\examples\hello.sh'
      The minimum record length was 80
      The maximum record length was 80
NOTE: The data step took :
      real time : 0.000
      cpu time  : 0.000


10        #!/bin/bash
11        echo "========================================="
12        echo "Hello from Ubuntu Linux!"
13        echo "========================================="
14        echo "Current user: $(whoami)"
15        echo "Current directory: $(pwd)"
16        echo "Date and time: $(date)"
17        echo "Hostname: $(hostname)"
18        echo "========================================="
19        ;;;;
20        run;
21
22        /* Make executable */
23        data _null_;
24          call system('wsl chmod +x /home/[userid]/examples/hello.sh');
25        run;

NOTE: The data step took :
      real time : 0.458
      cpu time  : 0.031


26
27        filename pyp pipe "wsl bash /home/[userid]/examples/hello.sh";
28        data _null_;
29          infile pyp;
30          input;
31          putlog _infile_;
32          file "d:/linux/hello.txt";
33          put _infile_;
34        run;

NOTE: The infile pyp is:
      Unnamed Pipe Access Device,
      Process=wsl bash /home/[userid]/examples/hello.sh,
      Lrecl=32767, Recfm=V

NOTE: The file 'd:\linux\hello.txt' is:
      Filename='d:\linux\hello.txt',
      Owner Name=SLC\suzie,
      File size (bytes)=0,
      Create Time=16:29:33 Jun 08 2026,
      Last Accessed=11:07:32 Jun 09 2026,
      Last Modified=11:07:32 Jun 09 2026,
      Lrecl=32767, Recfm=V

=========================================
Hello from Ubuntu Linux!
=========================================
Current user: [userid]
Current directory: /mnt/c/Program Files/IDM Computer Solutions/UltraEdit
Date and time: Tue Jun  9 11:07:32 MST 2026
Hostname: SLC
=========================================
NOTE: 8 records were read from file pyp
      The minimum record length was 14
      The maximum record length was 73
NOTE: 8 records were written to file 'd:\linux\hello.txt'
      The minimum record length was 14
      The maximum record length was 73
NOTE: The data step took :
      real time : 0.479
      cpu time  : 0.015


35
36        /* Display results */
37        data _null_;
38          infile "d:/linux/hello.txt";
39          file print;
40          input;
41          put _infile_;
42        run;

NOTE: The infile 'd:\linux\hello.txt' is:
      Filename='d:\linux\hello.txt',
      Owner Name=SLC\suzie,
      File size (bytes)=321,
      Create Time=16:29:33 Jun 08 2026,
      Last Accessed=11:07:33 Jun 09 2026,
      Last Modified=11:07:33 Jun 09 2026,
      Lrecl=32767, Recfm=V

NOTE: 8 records were read from file 'd:\linux\hello.txt'
      The minimum record length was 14
      The maximum record length was 73
NOTE: 8 records were written to file PRINT

NOTE: The data step took :
      real time : 0.031
      cpu time  : 0.031


43
ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 1.238
      cpu time  : 0.234

/*  _         _                       _
| || |     __| |_ __ ___  _ __     __| | _____      ___ __   _ __ ___   __ _  ___ _ __ ___  ___
| || |_   / _` | `__/ _ \| `_ \   / _` |/ _ \ \ /\ / / `_ \ | `_ ` _ \ / _` |/ __| `__/ _ \/ __|
|__   _| | (_| | | | (_) | |_) | | (_| | (_) \ V  V /| | | || | | | | | (_| | (__| | | (_) \__ \
   |_|    \__,_|_|  \___/| .__/   \__,_|\___/ \_/\_/ |_| |_||_| |_| |_|\__,_|\___|_|  \___/|___/
                         |_|
*/

/*--- change wpsoto to your autocall folder ---*/
/*--- change [userid] to your userid        ---*/

data _null_;
  file "c:/wpsoto/slc_lxbegin.sas";
  input;
  put _infile_;
cards4;
%macro slc_lxbegin;
  %utlfkil(c:/temp/lx_pgm.sh);
  %utlfkil(c:/temp/lx_pgm.log);
  data _null_;
    file  "\\wsl$\Ubuntu/home/[userid]/temp/lx_pgm.sh";
    input;
    put _infile_;
%mend slc_lxbegin;
;;;;
run;

data _null_;
  file "c:/wpsoto/slc_lxend.sas";
  input;
  put _infile_;
cards4;
%macro slc_lxend(returnvar=N);
/*---you need to write to the winsows clipboard fro ubuntu to return the contents to the slc ---*/
options noxwait noxsync;
filename rut pipe  "wsl bash /home/[userid]/temp/lx_pgm.sh";
run;quit;
  data _null_;
    file print;
    infile rut recfm=v lrecl=32756;
    input;
    put _infile_;
    putlog _infile_;
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
data _null_;
  infile rut;
  input;
  file "c:/temp/lx_pgm.log";
  put _infile_; */
run;quit;
%mend slc_lxend;
;;;;
run;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/





https://github.com/rogerjdeangelis/utl-dropping-down-to-spss-using-the-pspp-free-clone-and-running-a-spss-linear-regression



/.
/usr
/usr/bin
/usr/bin/pspp
/usr/bin/pspp-convert
/usr/bin/pspp-output
/usr/bin/psppire
/usr/lib
/usr/lib/x86_64-linux-gnu
/usr/lib/x86_64-linux-gnu/pspp
/usr/lib/x86_64-linux-gnu/pspp/libpspp-2.0.1.so
/usr/lib/x86_64-linux-gnu/pspp/libpspp-core-2.0.1.so



options validvarname=upcase;
libname workx sas7bdat "d:/wpswrkx";
data workx.class;
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

%utlfkil(d:/sav/pspp.sav);

%slc_rbegin;
cards4;
library(haven);
have<-read_sas(
 "d:/wpswrkx/class.sas7bdat");
str(have);
have
write_sav(have,"\\\\wsl.localhost\\Ubuntu\\home\\xlr82sas\\temp\\pspp.sav");
;;;;
%slc_rend;

data _null_;
 file "\\wsl.localhost\Ubuntu\home\xlr82sas\temp\pspp.ps";
 input;
 put _infile_;
cards4;
GET FILE="/home/xlr82sas/temp/pspp.sav" .
REGRESSION
/VARIABLES=weight height
  /DEPENDENT=height
  /METHOD=ENTER
  /SAVE PRED RESID.
SAVE
 OUTFILE="/home/xlr82sas/temp/reg.sav" .
;;;;
run;


/usr/bin/pspp /home/xlr82sas/temp/pspp.ps -o /home/xlr82sas/temp/pspp.lst



data _null_;
  file "c:/wpsoto/slc_lxSPSSbegin.sas";
  input;
  put _infile_;
cards4;
%macro slc_lxSPSSbegin;
  %utlfkil(\\wsl$\Ubuntu\home\xlr82sas\temp/pspp.ps);
  %utlfkil(\\wsl$\Ubuntu\home\xlr82sas\temp/pspp.log);
  data _null_;
    file  "\\wsl$\Ubuntu\home\xlr82sas\temp/pspp.ps";
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

%utlfkil(\\wsl$\Ubuntu\home\xlr82sas\temp/reg.sav);

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
;;;;
%slc_lxSPSSend;






























































%utlfkil(d:\sav\wantout.sav);

%slx_psppbeginx;
parmcards4;
GET FILE="\\wsl.localhost\Ubuntu\home\xlr82sas\temp\pspp.sav" .
REGRESSION
/VARIABLES=weight height
  /DEPENDENT=height
  /METHOD=ENTER
  /SAVE PRED RESID.
SAVE
 OUTFILE="d:\sav\wantout.sav".
;;;;
%xlc_psppendx;



data _null_;
 file "\\wsl.localhost\Ubuntu\home\xlr82sas\temp\pspp.ps";
 input;
 put _infile_;
cards4;
GET FILE="/home/xlr82sas/temp/pspp.sav" .
REGRESSION
/VARIABLES=weight height
  /DEPENDENT=height
  /METHOD=ENTER
  /SAVE PRED RESID.
SAVE
 OUTFILE="/home/xlr82sas/temp/reg.sav" .
;;;;
run;

%utlfkil(c:/temp/ps_pgm.ps);



wsl /usr/bin/pspp /home/xlr82sas/temp/pspp.ps -o /home/xlr82sas/temp/pspp.lst;
wsl /usr/bin/pspp /home/xlr82sas/temp/pspp.ps -o /home/xlr82sas/temp/pspp.lst;


xlr82sas@SLC:/$ /usr/bin/pspp
PSPP is free software and you are welcome to distribute copies of it
under certain conditions; type "show copying." to see the conditions.
There is ABSOLUTELY NO WARRANTY for PSPP; type "show warranty." for details.
GNU pspp 2.0.1
PSPP>

xlr82sas@SLC:~/temp$ ls -l
total 28
-rwxr-xr-x 1 xlr82sas xlr82sas  243 Jul  8 08:21 lx_pgm.sh
-rw-r--r-- 1 xlr82sas xlr82sas   73 Jul  8 08:39 lxpv_pgm.log
-rw-r--r-- 1 xlr82sas xlr82sas 4756 Jul  8 08:39 lxpv_pgm.py
-rw-r--r-- 1 xlr82sas xlr82sas  211 Jul 11 13:46 pspp.log
-rw-r--r-- 1 xlr82sas xlr82sas  224 Jul 12 08:44 pspp.lst
-rw-r--r-- 1 xlr82sas xlr82sas  656 Jul 11 13:54 pspp.ps
xlr82sas@SLC:~/temp$

Note both files exist

xlr82sas@SLC:~/temp$ ls -l
total 32
-rw-r--r-- 1 xlr82sas xlr82sas  656 Jul 12 08:51 pspp.ps
-rw-r--r-- 1 xlr82sas xlr82sas 1241 Jul 12 09:00 pspp.sav

/usr/bin/pspp /home/xlr82sas/temp/pspp.ps -o /home/xlr82sas/temp/pspp.lst

error: An error occurred while opening `\home\xlr82sas\temp\pspp.sav': No such
file or directory.

/home/xlr82sas/temp/pspp.ps:2: error: Stopping syntax file processing here to
avoid a cascade of dependent command failures.

error: An error occurred while opening `\home\xlr82sas\temp\pspp.sav': No such file or directory.
/home/xlr82sas/temp/pspp.ps:2: error: Stopping syntax file processing here to avoid a cascade of dependent command failures.















  -o output-file













data _null_;
  file "c:/wpsoto/slc_lxspssbegin.sas";
  input;
  put _infile_;
cards4;
%macro slc_lxspssbegin;
  %utlfkil(c:/temp/lxspss_pgm.sh);
  %utlfkil(c:/temp/lxspss_pgm.log);
  data _null_;
    file  "\\wsl$\Ubuntu/home/[userid]/temp/lxspss_pgm.sh";
    input;
    put _infile_;
%mend slc_lxspssbegin;
;;;;
run;

data _null_;
  file "c:/wpsoto/slc_lxspssend.sas";
  input;
  put _infile_;
cards4;
%macro slc_lxspssend(returnvar=N);
/*---you need to write to the winsows clipboard fro ubuntu to return the contents to the slc ---*/
options noxwait noxsync;
filename rut pipe  "wsl bash /usr/bin/pspp ";
filename rut pipe  "wsl bash \usr\bin\pspp ";
run;quit;
  data _null_;
    file print;
    infile rut recfm=v lrecl=32756;
    input;
    put _infile_;
    putlog _infile_;
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
data _null_;
  infile rut;
  input;
  file "c:/temp/lxspss_pgm.log";
  put _infile_; */
run;quit;
%mend slc_lxspssend;
;;;;
run;
