# Instructions
https://onedrive.live.com/view.aspx?resid=9607C15F7C0726F8!517&ithint=file%2cdocx&app=Word&authkey=!AGzrgncHjqo34kQ

# Decode this URL
$Url = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("JwBoAHQAdABwAHMAOgAvAC8AdwB3AHcALgBkAHIAbwBwAGIAbwB4AC4AYwBvAG0ALwBzAC8AcAB0AHEAZQA4AHIAYQB0AGsAdQByAGEAdQBuAHQALwByAGEAbgBkAG8AbQAuAHQAeAB0AD8AZABsAD0AMAAnAA==")).Replace(" ","")
# $Url = 'https://www.dropbox.com/s/ptqe8ratkuraunt/random.txt?dl=0'

# 1) Make an object that contains the first 50 numbers of the Fibonacci Sequence
Function Get-Fib
{
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $True)]
		[int]$Limit
	)

	$i = 0
    $Current = $Previous = 1
	while ($i -lt $Limit)
	{
           $Current
		   $Current,$Previous = ($Current + $Previous),$Current
		   
		   $i++
	}
}

# 2) Using the random.txt file
# find the number that is CLOSEST to the random number
# and output that to a text file.
Function Get-FibDiff
{
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $True)]
		[int]$Number
	)

	$Objs = @()
	$Fibs = Get-Fib 50
	ForEach ( $Fib in $Fibs )
	{
		Remove-Variable Calc -ErrorAction SilentlyContinue

		$Calc = [math]::abs($Fib - $Number)
		$Objs += [PSCustomObject]@{
			'Number'	= $Fib 
			'Diff'		= $Calc
		}
	}

	$Diff = $Objs.Diff | Sort-Object -Descending | Select-Object -Last 1
	$Final = ($Objs | Where-Object { $_.Diff -eq $Diff }).Number
	Write-Output $Final
}

# 3) Email the code and text file with the closest numbers
# to xxxxxx@outlook.com with your name in the subject line
Function Get-FibNum
{
	Param(
		[Parameter(Mandatory = $True)]
		$Randoms
	)

	$Objs = @()
	ForEach ( $Random in $Randoms )
	{
		$Objs += [PSCustomObject]@{
			'Random'	= $Random
			'Fib'		= Get-FibDiff -Number $Random
		}
	}

	Write-Output $Objs
}

# Answer
$Randoms = Get-Content -Path random.txt
Get-FibNum -Randoms $Randoms | Out-File C:\fib.txt