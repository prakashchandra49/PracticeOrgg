public with sharing class DateTimeDemo {
	

String LongDate = ' ';

// Init cLongDate with the current Datetime in long date format
public String getLongDate() {
Datetime cDT = System.now();
LongDate = cDT.format('EEEE,MMMM d, yyyy');
date d1=date.newInstance(2011,10,1);
date d2=date.newInstance(2011,11,10);
Integer daysBetweenDates=d1.daysBetween(d2);
System.debug(daysBetweenDates);
Date d = Date.newInstance(cDT.year(),cDT.month(),cDT.day());
System.debug(d);
return LongDate;
}
}