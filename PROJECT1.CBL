       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROJECT1.
       AUTHOR. M BARRETT.
      ***************************************************************
      * This program is designed to read in details about the
      * employees of Drakea, Ltd. and produce a salary report based
      * on the values inside of the file PR1FA19.txt
      ********
      * INPUT:
      *     The employee file contains the following records:
      *       1. Warehouse ID
      *       2. Employee ID
      *       3. Employee Position
      *       4. Employee Last Name
      *       5. Employee First Name
      *       6. Hire Date
      *       7. Starting Salary
      *       8. Date of Last Pay Increase
      *       9. Current Salary
      * *******
      * OUTPUT:
      *     This information will be formated into a report with
      *     individual employees on each line, with a sum total
      *     of starting salary and current salary present at the
      *     bottoms of their respective columns
      ***************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. PC.
       OBJECT-COMPUTER. PC.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT DATA-FILE
               ASSIGN TO 'PR1FA19.TXT'
               ORGANIZATION IS LINE SEQUENTIAL.
            SELECT REPORT-FILE
               ASSIGN TO PRINTER 'PRDATA.TXT'.
       
       DATA DIVISION.
       FILE SECTION.

       FD DATA-FILE
          RECORD CONTAINS 70 CHARACTERS.

       01 IN-EMPLOYEE-RECORD.
          05 WAREHOUSE-ID    PIC X(4).
          05 EMPLOYEE-ID     PIC X(5).
          05 EMPOLYEE-POS    PIC X(2).
          05 EMP-LAST        PIC X(10).
          05 EMP-FIRST       PIC X(10).
          05 FILLER          PIC X(3).
          05 HIRE-DATE       PIC S9(8).
          05 START-SAL       PIC 999999V99.
          05 FILLER-2        PIC X(4).
          05 LAST-INC        PIC S9(8).
          05 CUR-SAL         PIC 999999V99.
        
       FD REPORT-FILE
          RECORD CONTAINS 80 CHARACTERS.
       
       01 REPORT-RECORD   PIC X(80).

       WORKING-STORAGE SECTION.
        
       01  WS-WORK-AREAS.
           05 ARE-THERE-MORE-RECORDS PIC X(3) VALUE 'YES'.

       01 TOTAL-FIELDS.
           05  START-TOTAL    PIC S999999V99.
           05  CUR-TOTAL      PIC S999999V99.

       01 REPORT-FIELDS.
          05  PROPER-SPACING    PIC S9      VALUE +1.
          05  BLANK-FILLER      PIC X(80)   VALUE SPACES.

      *********     OUTPUT AREA     **********************************
       01 HEADING-ONE.
          05 H1-DATE          PIC 9999/99/99.
          05                  PIC X(22)   VALUE '    MAB'.
          05                  PIC X(35)   VALUE 'DRAKEA, LTD'.
          05                  PIC X(8)    VALUE 'PAGE 01 '.
  
       01 HEADING-TWO.
          05                  PIC X(32)   VALUE SPACES.
          05                  PIC X(13)   VALUE 'SALARY REPORT'.
          05                  PIC X(31)   VALUE SPACES.

       01 HEADING-THREE.
          05                  PIC X(3)    VALUE SPACES.
          05                  PIC X(12)   VALUE 'WAREHOUSE'.
          05                  PIC X(12)   VALUE 'EMPLOYEE'.
          05                  PIC X(13)   VALUE 'EMPLOYEE'.
          05                  PIC X(16)   VALUE 'STARTING'.
          05                  PIC X(12)   VALUE 'LAST'.
          05                  PIC X(11)   VALUE 'CURRENT'.

       01 HEADING-FOUR.
          05                  PIC X(6)    VALUE SPACES.
          05                  PIC X(12)   VALUE 'ID'.
          05                  PIC X(8)    VALUE 'ID'.
          05                  PIC X(16)   VALUE 'LAST NAME'.
          05                  PIC X(12)   VALUE 'SALARY'.
          05                  PIC X(14)   VALUE 'INCREASE'.
          05                  PIC X(11)   VALUE 'SALARY'.

       01 DETAIL-LINE.
          05                  PIC X(5)    VALUE SPACES.
          05 DL-WHOUSE-ID     PIC X(11).
          05 DL-EMP-ID        PIC X(10).
          05 DL-EMP-LAST      PIC X(13).
          05 DL-START-SAL     PIC $999999.99.
          05                  PIC X(3)    VALUE SPACES.
          05 DL-LAST-INC      PIC 99/99/9999.
          05                  PIC X(3)    VALUE SPACES.
          05 DL-CURR-SAL      PIC $999999.99.

       01 TOTAL-LINE.
          05                  PIC X(31)   VALUE SPACES.
          05                  PIC X(8)    VALUE 'TOTAL:  '.
          05                  PIC X       VALUE '$'.
          05 DL-TOTL-SRT      PIC 999999.99.
          05                  PIC X(16)   VALUE SPACES.
          05                  PIC X       VALUE '$'.
          05 DL-TOTL-CUR      PIC 999999.99.

       PROCEDURE DIVISION.

       10-MAIN-MODULE.
         
         PERFORM 15-HOUSEKEEPING
         PERFORM UNTIL ARE-THERE-MORE-RECORDS = 'NO '
           READ DATA-FILE
             AT END
               MOVE 'NO ' TO ARE-THERE-MORE-RECORDS
             NOT AT END
               PERFORM 45-BUILD-REPORT
           END-READ
         END-PERFORM
         PERFORM 55-BUILD-TOTAL
         CLOSE DATA-FILE
               REPORT-FILE
         STOP RUN
         .

       15-HOUSEKEEPING.
         OPEN INPUT  DATA-FILE
              OUTPUT  REPORT-FILE
         ACCEPT H1-DATE FROM DATE YYYYMMDD
         PERFORM 20-HEADER-ROUTINE
         .
       20-HEADER-ROUTINE.
         WRITE REPORT-RECORD FROM HEADING-ONE
            AFTER ADVANCING PAGE
         MOVE 2 TO PROPER-SPACING
         MOVE HEADING-TWO TO REPORT-RECORD
         PERFORM 35-WRITE-A-LINE
         MOVE 3 TO PROPER-SPACING
         MOVE HEADING-THREE TO REPORT-RECORD
         PERFORM 35-WRITE-A-LINE
         MOVE 1 TO PROPER-SPACING
         MOVE HEADING-FOUR TO REPORT-RECORD
         PERFORM 35-WRITE-A-LINE
         .

       35-WRITE-A-LINE.
          WRITE REPORT-RECORD
              AFTER ADVANCING PROPER-SPACING
          .

       45-BUILD-REPORT.
          MOVE WAREHOUSE-ID TO DL-WHOUSE-ID
          MOVE EMPLOYEE-ID TO DL-EMP-ID
          MOVE EMP-LAST TO DL-EMP-LAST
          MOVE START-SAL TO DL-START-SAL
          ADD START-SAL TO START-TOTAL
          MOVE LAST-INC TO DL-LAST-INC
          MOVE CUR-SAL TO DL-CURR-SAL
          ADD CUR-SAL TO CUR-TOTAL
          MOVE DETAIL-LINE TO REPORT-RECORD
          MOVE 1 TO PROPER-SPACING
          PERFORM 35-WRITE-A-LINE
          .
       
       55-BUILD-TOTAL.
          MOVE START-TOTAL TO DL-TOTL-SRT
          MOVE CUR-TOTAL TO DL-TOTL-CUR
          MOVE TOTAL-LINE TO REPORT-RECORD
          PERFORM 35-WRITE-A-LINE
          .
       

       
           

