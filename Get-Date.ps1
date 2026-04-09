# Get the current date and time
$currentDate = Get-Date

# Display the current date and time
Write-Output "Current Date and Time: $currentDate"

# Format the date to display only the date part
$formattedDate = $currentDate.ToString("yyyy-MM-dd")
Write-Output "Formatted Date: $formattedDate"

# Add 5 days to the current date
$futureDate = $currentDate.AddDays(5)
Write-Output "Date after 5 days: $futureDate"

# Subtract 3 days from the current date
$pastDate = $currentDate.AddDays(-3)
Write-Output "Date 3 days ago: $pastDate"

# Get the current time only
$currentTime = $currentDate.ToString("HH:mm:ss")
Write-Output "Current Time: $currentTime"

# Get the day of the week
$dayOfWeek = $currentDate.DayOfWeek
Write-Output "Day of the Week: $dayOfWeek"

# Get the day of the year
$dayOfYear = $currentDate.DayOfYear
Write-Output "Day of the Year: $dayOfYear"

# Get the current month
$currentMonth = $currentDate.Month
Write-Output "Current Month: $currentMonth"

# Get the current year
$currentYear = $currentDate.Year
Write-Output "Current Year: $currentYear"

# Get the number of days in the current month
$daysInMonth = [DateTime]::DaysInMonth($currentDate.Year, $currentDate.Month)
Write-Output "Days in Current Month: $daysInMonth"
# Another way to get the number of days in the current month
$daysInMonth = (Get-Date -Day 1).AddMonths(1).AddDays(-1).Day
Write-Output "Days in Current Month: $daysInMonth"

# Get the start of the week (assuming week starts on Monday)
$startOfWeek = $currentDate.AddDays(-($currentDate.DayOfWeek.value__ - 1))
Write-Output "Start of the Week: $startOfWeek"

# Get the end of the week (assuming week ends on Sunday)
$endOfWeek = $startOfWeek.AddDays(6)
Write-Output "End of the Week: $endOfWeek"

#get-date using -Format parameter
# Get the current date and time in short date format
$shortDate = Get-Date -Format "d"
Write-Output "Short Date: $shortDate"

# Get the current date and time in long date format
$longDate = Get-Date -Format "D"
Write-Output "Long Date: $longDate"

# Get the current date and time in full date format
$fullDate = Get-Date -Format "F"
Write-Output "Full Date: $fullDate"

# Get the current date and time in Universal Time (UTC)
$currentDateUTC = Get-Date -Format "u"
Write-Output "Current Date and Time in UTC: $currentDateUTC"

# Get the current date and time in sortable format
$sortableDate = Get-Date -Format "s"
Write-Output "Sortable Date and Time: $sortableDate"

# Get the current date and time in round-trip format
$roundTripDate = Get-Date -Format "o"
Write-Output "Round-Trip Date and Time: $roundTripDate"

# Get the current date and time in RFC1123 format
$rfc1123Date = Get-Date -Format "r"
Write-Output "RFC1123 Date and Time: $rfc1123Date"

# Get the current date and time in Universal Sortable format
$universalSortableDate = Get-Date -Format "u"
Write-Output "Universal Sortable Date and Time: $universalSortableDate"

# Get the current date and time in year month day format
$yearMonthDayDate = Get-Date -Format "yyyyMMdd"
Write-Output "Year Month Day Date: $yearMonthDayDate"

# Get the current date and time in custom format
$customDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Output "Custom Date and Time: $customDate"


#Get-Date using -UFormat parameter
# Get the current date and time in Unix format
$unixDate = Get-Date -UFormat "%s"
Write-Output "Unix Date and Time: $unixDate"

# Get the current year in Unix format
$unixYear = Get-Date -UFormat "%Y"
Write-Output "Unix Year: $unixYear"

# Get the current month in Unix format
$unixMonth = Get-Date -UFormat "%m"
Write-Output "Unix Month: $unixMonth"

# Get the current day of the month in Unix format
$unixDay = Get-Date -UFormat "%d"
Write-Output "Unix Day of the Month: $unixDay"

# Get the current hour in Unix format (24-hour clock)
$unixHour = Get-Date -UFormat "%H"
Write-Output "Unix Hour (24-hour clock): $unixHour"

# Get the current minute in Unix format
$unixMinute = Get-Date -UFormat "%M"
Write-Output "Unix Minute: $unixMinute"

# Get the current second in Unix format
$unixSecond = Get-Date -UFormat "%S"
Write-Output "Unix Second: $unixSecond"

# Get the current day of the week in Unix format (0-6, Sunday is 0)
$unixDayOfWeek = Get-Date -UFormat "%w"
Write-Output "Unix Day of the Week: $unixDayOfWeek"

# Get the current day of the year in Unix format (001-366)
$unixDayOfYear = Get-Date -UFormat "%j"
Write-Output "Unix Day of the Year: $unixDayOfYear"

# Get the current week number of the year in Unix format (00-53, Sunday is the first day of the week)
$unixWeekOfYear = Get-Date -UFormat "%U"
Write-Output "Unix Week of the Year (Sunday first day): $unixWeekOfYear"

# Get the current week number of the year in Unix format (00-53, Monday is the first day of the week)
$unixWeekOfYearMonday = Get-Date -UFormat "%W"
Write-Output "Unix Week of the Year (Monday first day): $unixWeekOfYearMonday"

# Get the current time zone abbreviation in Unix format
$unixTimeZone = Get-Date -UFormat "%Z"
Write-Output "Unix Time Zone: $unixTimeZone"

# Get the current time zone offset in Unix format
$unixTimeZoneOffset = Get-Date -UFormat "%z"
Write-Output "Unix Time Zone Offset: $unixTimeZoneOffset"

# Get the current date and time in Unix format (locale's date and time)
$unixLocaleDateTime = Get-Date -UFormat "%c"
Write-Output "Unix Locale's Date and Time: $unixLocaleDateTime"

# Get the current date in Unix format (locale's date)
$unixLocaleDate = Get-Date -UFormat "%x"
Write-Output "Unix Locale's Date: $unixLocaleDate"

# Get the current time in Unix format (locale's time)
$unixLocaleTime = Get-Date -UFormat "%X"
Write-Output "Unix Locale's Time: $unixLocaleTime"