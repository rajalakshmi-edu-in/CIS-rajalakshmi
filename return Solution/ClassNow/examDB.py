import mysql.connector
from datetime import datetime
def createAssignmentDB(userid,due,testname,qns,op1,op2,op3,op4,ans):
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="classroomdb"
    )
    mycursor = mydb.cursor()
    dueData=due.split('T')
    sql = "INSERT INTO assmtdata (assmtname,ownerid,postdate,duedate,duetime) values (%s,"+str(userid)+",%s,%s,%s);"
    adr = (testname,datetime.today().strftime('%Y-%m-%d'),dueData[0],dueData[1])
    mycursor.execute(sql,adr)
    testid=str(mycursor.lastrowid)
    for questionNumber in range (len(qns)):
        sql = "INSERT INTO assmtqns (question,op1,op2,op3,op4,ans,assmtid) values (%s,%s,%s,%s,%s,"+ans[questionNumber]+","+testid+");"
        adr = (qns[questionNumber],op1[questionNumber],op2[questionNumber],op3[questionNumber],op4[questionNumber])
        mycursor.execute(sql, adr)
    mydb.commit()

def createTestDB(userid,testname,qns,op1,op2,op3,op4,ans):
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="classroomdb"
    )
    mycursor = mydb.cursor()
    sql = "INSERT INTO testdata (testname,ownerid) values ('"+testname+"',"+str(userid)+");"
    mycursor.execute(sql)
    testid=str(mycursor.lastrowid)
    for questionNumber in range (len(qns)):
        sql = "INSERT INTO questionbank (question,op1,op2,op3,op4,ans,testid) values (%s,%s,%s,%s,%s,"+ans[questionNumber]+","+testid+");"
        adr = (qns[questionNumber],op1[questionNumber],op2[questionNumber],op3[questionNumber],op4[questionNumber])
        mycursor.execute(sql, adr)
    mydb.commit()
