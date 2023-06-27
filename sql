
import logging 

logging.basicConfig(filename='checker.log',level = logging.DEBUG,format=("%(asctime)s : %(message)s : %(levelname)s"))
import mysql.connector

class Main:
    
    def __init__(self,hostname,userid, password):
        self.hostname = hostname
        self.userid = userid
        self.password = password
        
    def connection(self):
        self.mydb = mysql.connector.connect(host = self.hostname, user =self.userid, password = self.password)
        print(self.mydb.is_connected())
        logging.info('conection is done')
        
    def database_name(self,db_name):
        try:
            self.db_name = db_name
            self.mycurs = self.mydb.cursor()
            self.mycurs.execute(f'create database if not exists {self.db_name}')
            logging.info('table creation done')
        except Exception as e:
            print(e)
            self.mycurs.execute(f'use {self.db_name}')
            self.mycurs.execute(f'show databases')
            logging.info('database done')
            for i in self.mycurs:
                print(i)
                
    def table (self,table_name,contains):
        self.table_name = table_name 
        try:
            self.mycurs.execute(f'create table if not exists {self.db_name}.{table_name} {contains}')
            logging.info('creating a table sucessfully ')
            for i in self.mycurs:
                print(i)
        except Exception as e:
            print(e)
            logging.info('file already exist here so we can use insert function ')
            
            
    def insert(self,values):
        self.values = values
        self.mycurs.execute(f'insert into {self.db_name}.{self.table_name} values {values}')
        self.mydb.commit()
        logging.info('here insert sucessfully')
            
            
    def show(self):
        self.mycurs.execute(f'select * from {self.db_name}.{self.table_name}')
        for i in self.mycurs:
            print(i)
            logging.info('showing details')
            
            
m = Main('localhost','root','devendra@12345')
m.connection()
m.database_name('material')
m.table('details',"(item varchar(50),quantity int,cont int,email varchar(50))")
m.insert(('sugar',1,8435,'ram kirana'))
m.show()
m.insert(('chai',9,8436,'deven kirana'))
m.insert(('salt',10,8437,'arti pandey'))
m.insert(('jera',7,8438,'abha kirana'))
m.insert(('sauf',8,718,'ashishmandloi'))
m.show()
