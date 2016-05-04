#!/bin/sh
if [ "$#" = "0" ]
then
	year=`date +%Y`
	month=`date +%m`
	day=`date +%d`
	month_adjust=`expr $month - 1`
	yesterday_year=`date --date yesterday +%Y`
	yesterday_month=`date --date yesterday +%m`
	yesterday_month_adjust=`expr $yesterday_month - 1`
	yesterday_day=`date --date yesterday +%d`
	echo ${month}/${day}/${year}
	echo ${yesterday_month_adjust}
	echo ${yesterday_month}/${yesterday_day}/${yesterday_year}
	for company in '1201.TW' '1203.TW' '1210.TW' '1213.TW' '1215.TW' '1216.TW' '1217.TW' \
'1218.TW' '1219.TW' '1220.TW' '1225.TW' '1227.TW' '1229.TW' '1231.TW' '1232.TW' '1233.TW' \
'1234.TW' '1235.TW' '1236.TW' '1256.TW' '1702.TW' '1737.TW' '1402.TW' '1409.TW' '1410.TW' \
'1413.TW' '1414.TW' '1416.TW' '1417.TW' '1418.TW' '1419.TW' '1423.TW' '1432.TW' '1434.TW' \
'1439.TW' '1440.TW' '1441.TW' '1443.TW' '1444.TW' '1445.TW' '1446.TW' '1447.TW' '1449.TW' \
'1451.TW' '1452.TW' '1453.TW' '1454.TW' '1455.TW' '1456.TW' '1457.TW' '1459.TW' '1460.TW' \
'1463.TW' '1464.TW' '1465.TW' '1466.TW' '1467.TW' '1468.TW' '1469.TW' '1470.TW' '1472.TW' \
'1473.TW' '1474.TW' '1475.TW' '1476.TW' '1477.TW' '4414.TW' '4426.TW' '1603.TW' '1604.TW' \
'1605.TW' '1608.TW' '1609.TW' '1611.TW' '1612.TW' '1613.TW' '1614.TW' '1615.TW' '1616.TW' \
'1617.TW' '1618.TW' '1626.TW' '4930.TW' '1701.TW' '1707.TW' '1720.TW' '1729.TW' '1731.TW' \
'1733.TW' '1734.TW' '1736.TW' '1762.TW' '1783.TW' '1786.TW' '1789.TW' '3164.TW' '3705.TW' \
'4104.TW' '4106.TW' '4108.TW' '4119.TW' '4133.TW' '4137.TW' '4141.TW' '4142.TW' '4144.TW' \
'4164.TW' '4737.TW' '4746.TW' '1902.TW' '1903.TW' '1904.TW' '1905.TW' '1906.TW' '1907.TW' \
'1909.TW'

	do
		url="http://real-chart.finance.yahoo.com/table.csv?s=$company&a=${yesterday_month_adjust}&b=${yesterday_day}&c=${yesterday_year}&d=${month_adjust}&e=${day}&f=${year}&g=d&ignore=.csv"
		wget -O /home/jonathan/project/price_data/${company}-${year}${month}${day} ${url}
	done
fi
`python database.py`

if [ "$#" != "0" ]
then
	year=$1
	month=$2
	day=`expr $3 - 1`
	fileday=$3
	month_adjust=`expr $month - 1`
	yesterday_year=$4
	yesterday_month=$5
	yesterday_month_adjust=`expr $yesterday_month - 1`
	yesterday_day=`expr $6 - 1`
	company=$7
	url="http://real-chart.finance.yahoo.com/table.csv?s=$company&a=${yesterday_month_adjust}&b=${yesterday_day}&c=${yesterday_year}&d=${month_adjust}&e=${day}&f=${year}&g=d&ignore=.csv"
        wget -O /home/jonathan/project/price_data/${company}-${year}${month}${fileday} ${url}

fi
