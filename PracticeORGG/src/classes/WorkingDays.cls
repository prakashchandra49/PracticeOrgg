public class WorkingDays
{
public void CalculateDays(date startDate,date lastDate)
{

Integer daysBetweenDates=startDate.daysBetween(lastDate);
Integer offDays=0;
DateTime start=startDate;
DateTime last=lastDate;
Integer noOfWeeks=daysBetweenDates/7;
 Integer remainingDays=math.mod(daysBetweenDates,7);
 start=start.addDays(7*noOfWeeks);
 offDays=2*noOfWeeks;
while(start < last)
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