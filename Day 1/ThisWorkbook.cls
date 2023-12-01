VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisWorkbook"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub Day1()

Dim r As Integer, cv

    For r = 1 To 1000
        digits = FindDigits(r)
        Sheets("Sheet1").Cells(r, 3).Value = digits
        Sheets("Sheet1").Cells(r, 4).Value = CInt(Left(digits, 1) & Right(digits, 1))
        cv = cv + CInt(Left(digits, 1) & Right(digits, 1))
    Next r
    Debug.Print cv
    
End Sub

Function FindDigits(r As Integer) As String

Dim s, digits As String

    s = Sheets("Sheet1").Cells(r, 1)
    For i = 1 To Len(s)
        c = Mid(s, i, 1)
        If InStr("0123456789", c) > 0 Then
            digits = digits & c
        Else
            If Mid(s, i, 3) = "one" Then digits = digits & "1"
            If Mid(s, i, 3) = "two" Then digits = digits & "2"
            If Mid(s, i, 5) = "three" Then digits = digits & "3"
            If Mid(s, i, 4) = "four" Then digits = digits & "4"
            If Mid(s, i, 4) = "five" Then digits = digits & "5"
            If Mid(s, i, 3) = "six" Then digits = digits & "6"
            If Mid(s, i, 5) = "seven" Then digits = digits & "7"
            If Mid(s, i, 5) = "eight" Then digits = digits & "8"
            If Mid(s, i, 4) = "nine" Then digits = digits & "9"
        End If
    Next i
    
    FindDigits = digits
    
End Function
