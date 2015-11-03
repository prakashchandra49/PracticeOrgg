public with sharing class TransactionControlDemo {
		public static void InsertAcc(){
		Account acc=new Account(name='Testing Account2');
		insert acc;
		system.debug('@@@@@@@@@@@@@@@@@@account id'+acc.id);
		
		System.assertEquals(null, [select accountNumber from Account where id=:acc.id].accountNumber);
		system.debug('@@@@@@@@@@@@@@@@@@account id'+acc.id);
		SavePoint sp=Database.setSavePoint();
		acc.AccountNumber='123';
		update acc;
		System.assertEquals('123', [select accountNumber from Account where id=:acc.id].accountnumber);
		Database.rollback(sp);
		System.assertEquals(null, [select accountNumber from Account where id=:acc.id].accountNumber);
		}
}