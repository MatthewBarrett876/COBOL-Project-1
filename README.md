# COBOL-Project-1
This is the first project in my COBOL class and Jacksonville State University.

The purpose of this program is to produce our first report with some simple math to calculate the "total starting salary" and "total current salary" fields for this fictional warehouse.

INPUT FILE - PR1F19.txt
This file contains the employee records for the warehouse. All of the records in the file have the following layout:
  1. Warehouse ID(1-4)
  2. Employee ID(5-9)
  3. Employee Position(10-11)
  4. Employee Last Name(12-21)
  5. Employee First Name(22-31)
  6. Hire Date(35-42)
  7. Starting Salary(43-50)
  8. Date of Last Pay Increase(55-62)
  9. Current Salary(63-70)
  
  The value in parentheses represents the length of fields(minding the empty spaces in the gaps).
  
  OUTPUT FILE - PRDATA.TXT
  
  I have included the output file in the repository. It is worth noting that we did not know about zero supression at the time of writing this and would be first on the list of additions i would make to this file.
  
  PRINTER SPACING CHART - CS370 Program 1 Printer Spacing Chart F19.xls
  
  This file was included with the assignment along with the problem description(CS370 Program 1 Problem Description FA19.docx). The spacing chart was crucial in determining the layout of the Output and served as a guide for the entire program.
  
  
FUNCTION BREAKDOWN (I know they are paragraphs, I call them functions becuase its easier)

10-MAIN-MODULE - This function CALLS 15-HOUSEKEEPING, 45-BUILD-REPORT, 55-BUILD-TOTAL
15-Housekeeping is called, then the input record is read in and checks for the end of the file. If there are more records the 45-build-report is called. At the end of the input file 55-build-total is called. Afterwards, the input and output files are closed, the STOP-RUN ends the program

15-HOUSEKEEPING - This function is called BY 10-MAIN-MODULE and CALLS 20-HEADER-ROUTINE
The input and output files are opened. The date is pulled from the system and kept in H1-DATE. 20-header-routine is called

20-HEADER-ROUTINE - CALLED BY 15-HOUSEKEEPING, CALLS 35-WRITE-A-LINE
This function is to write all of the headers at the beginning of the report in sequence. After calling a header the proper-spacing variable is used to manage spacing. All headers were preformated so no changes need to be made.

35-WRITE-A-LINE - CALLED BY 20-HEADER-ROUTINE, 45-BUILD-REPORT, 55-BUILD-TOTAL
This is a general use function that writes what ever is in the Report record to the output file. Uses the proper-spacing value to regulate how many blank lines are between records.

45-BUILD-REPORT - CALLED BY 10-MAIN-MODULE, CALLS 35-WRITE-A-LINE
Most of this function is moving values from the input records to the output records, then also adding them to the total values being kept for the last line of the report(START-TOTAL, CUR-TOTAL). after the detail line has been prepared, it is writen and the main-module loops again to find another record.

55-BUILD-TOTAL - CALLED BY 10-MAIN-MODULE, CALLS 35-WRITE-A-LINE
This is called when there are no further records in the input file. This moves the total values that were being added to in 45-build-report to the preformatted total-line where it is then printed using 35-write-a-line.


