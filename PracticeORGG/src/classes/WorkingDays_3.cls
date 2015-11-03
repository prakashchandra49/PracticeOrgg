/*
Question 3 :-  Create a function which take 2 dates as argument 
and return number of working days between   two days excluding both days
(Saturday and Sunday is nonworking)
**/
public class WorkingDays_3
{
public void CalculateDays(date startDate,date lastDate)
{

Integer daysBetweenDates=startDate.daysBetween(lastDate);
//system.debug('********************* days ='+daysBetweenDates);
daysBetweenDates-=1;
Integer offDays=0;
DateTime start=startDate;
DateTime last=lastDate;
start=start.addDays(1);
Integer noOfWeeks=daysBetweenDates/7;
start=start.addDays(7*noOfWeeks);
offDays=2*noOfWeeks;
while(start< last)
{
if(start.format('E')=='Sat' || start.format('E')=='Sun'){
offDays++;
}
start=start.addDays(1);
}
Integer workingDays=daysBetweenDates-offDays;
System.debug('No of working days:= '+workingDays +'& No of Off Days:= '+offDays);
}
}