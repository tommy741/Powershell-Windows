strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")


Set colPrinters =  objWMIService.ExecQuery _
    ("Select * From Win32_Printer Where Caption = 'Printer X' AND PrinterStatus = '7'")
For Each objPrinter in colPrinters
    objPrinter.Delete_
Next


Set colPrinters =  objWMIService.ExecQuery _
    ("Select * From Win32_Printer Where Caption LIKE '%Smart Label%'")
For Each objPrinter in colPrinters
    objPrinter.RenamePrinter("Printer X")
Next