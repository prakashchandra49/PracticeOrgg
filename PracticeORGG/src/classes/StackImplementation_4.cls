/*
Question 4 :-  Create a stack class in apex.
**/
public with sharing class StackImplementation_4
{
    List<Integer> stack=new Integer[15];
    Integer top=0;
    public StackImplementation_4()
    {
    stack.add(top,-1);
    }

    public void push(Integer item)
    {
        top++;
        stack.add(top,item);
        System.debug('item Inserted successfully');
    }
    
    public Integer pop()
    {
        if(stack.get(top) == -1)
             return 0;
        else
        {     
            Integer item=stack.remove(top);
            top--;
            return item;
        }    
    }
    public Integer peek()
    {
        Integer item=stack.get(top);
        return item;
    }
}