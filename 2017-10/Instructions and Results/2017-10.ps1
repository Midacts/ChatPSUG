# Instructions
https://onedrive.live.com/view.aspx?resid=9607C15F7C0726F8!517&ithint=file%2cdocx&app=Word&authkey=!AGzrgncHjqo34kQ

# Decode this URL
$Url = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("JwBoAHQAdABwAHMAOgAvAC8AdwB3AHcALgBkAHIAbwBwAGIAbwB4AC4AYwBvAG0ALwBzAC8AcAB0AHEAZQA4AHIAYQB0AGsAdQByAGEAdQBuAHQALwByAGEAbgBkAG8AbQAuAHQAeAB0AD8AZABsAD0AMAAnAA==")).Replace(" ","")
# $Url = 'https://www.dropbox.com/s/ptqe8ratkuraunt/random.txt?dl=0'

# 1) Make an object that contains the
# first 50 numbers of the Fibonacci Sequence
$FibonacciNumbers = New-FibonacciNumber -Limit 50

# 2) Using the random.txt file
# find the number that is CLOSEST to the random number
# and output that to a text file.
$RandomNumbers = Get-Content -Path "random.txt"
Invoke-FibonacciNumberList -RandomNumbers $RandomNumbers -FibonacciNumberLimit 50 | Export-Csv -Path "C:\Results.csv" -NoTypeInformation

# 3) Email the code and text file with the closest numbers
# to xxxxxx@outlook.com with your name in the subject line
$MailParams = @{
	'To'			= "xxxxxx@outlook.com"
	'From'			= "midactsmystery at gmail dot com"
	'Subject'		= "ChatPSUG October 2017 - John McCarthy"
	'Body'			= "Attached are the outputs of the "
	'Attachments'	= "$PSScriptRoot\*"
	'SmtpServer'	= 'smtp.gmail.com'
}
Send-MailMessage @MailParams