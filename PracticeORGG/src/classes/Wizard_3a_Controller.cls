public class Wizard_3a_Controller
{

Boolean testval = false;

public String getShowSection1()
{
testval= true;
return null;
}

public String getShowSection2()
{
testval= false;
return null;
}

public Boolean getHideshow()
{
return testval;
}
public void setHideshow(boolean s)
{
this.testval = s;
}
}