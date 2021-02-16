import mysql.connector
from werkzeug import generate_password_hash, check_password_hash
def loginVerify(user,pwd):
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="classroomdb"
    )
    mycursor = mydb.cursor()
    sql = "SELECT * FROM userdata WHERE mail_id = %s"
    adr = (user,)
    mycursor.execute(sql, adr)
    myresult = mycursor.fetchone()
    if myresult:
      if(check_password_hash(myresult[4],pwd)):
        return [myresult[1],myresult[0],myresult[5]]
      else:
        return [0]
    else:
      return [-1]

def addUser(name,mail,phn,pwd,role):
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="classroomdb"
    )
    mycursor = mydb.cursor()
    sql = "INSERT INTO userdata (name, mail_id, ph_no, pwd, role) values (%s,%s,%s,%s,%s);"
    adr = (name, mail, phn, generate_password_hash(pwd), role)
    print(adr)
    mycursor.execute(sql, adr)
    mydb.commit()

def studentPopulateClasses(uid):
  mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="classroomdb"
    )
  mycursor = mydb.cursor()
  sql = "select classid,classname from classrooms where classid in (select classID from studentclass where userid="+str(uid)+");"
  mycursor.execute(sql)
  myresult=mycursor.fetchall()
  return myresult

def ownerPopulateClasses(uid):
  mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="classroomdb"
    )
  mycursor = mydb.cursor()
  sql = "select classid,classname from classrooms where ownerid="+str(uid)+";"
  mycursor.execute(sql)
  myresult=mycursor.fetchall()
  return myresult

def retrieveClassData(classid):
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="classroomdb"
    )
    mycursor = mydb.cursor()
    sql = "select * from materials where classid ="+classid+";"
    mycursor.execute(sql)
    myresult=mycursor.fetchall()
    return myresult

def findClass(classid):
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="classroomdb"
    )
    mycursor = mydb.cursor()
    sql = "select * from classrooms where classid ="+classid+";"
    mycursor.execute(sql)
    myresult=mycursor.fetchall()
    return myresult[0]

def addMaterial(classid,mname,ownerid,url,m_type):
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="classroomdb"
    )
    mycursor = mydb.cursor()
    sql = "INSERT INTO materials (mname,url,classid,ownerid,m_type) values (%s,%s,%s,%s,%s);"
    adr = (name, mail, phn, generate_password_hash(pwd), role)
    print(adr)
    mycursor.execute(sql, adr)
    mydb.commit()

def addClass(className,ownerId):
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="classroomdb"
    )
    mycursor = mydb.cursor()
    sql = "INSERT INTO classrooms (ClassName,Ownerid) values (%s,%s);"
    adr = (className,ownerId)
    mycursor.execute(sql, adr)
    mydb.commit()

def joinClassroom(classid,userid):
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="classroomdb"
    )
    mycursor = mydb.cursor()
    sql = "INSERT INTO studentclass (userid,classid) values (%s,%s);"
    adr = (userid,classid)
    print(adr)
    mycursor.execute(sql, adr)
    mydb.commit()

def allUsers():
  mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="classroomdb"
    )
  mycursor = mydb.cursor()
  sql = "select * from userdata;"
  mycursor.execute(sql)
  myresult=mycursor.fetchall()
  print(myresult)
  return myresult

def deleteUserDB(userid):
  mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="classroomdb"
    )
  mycursor = mydb.cursor()
  sql = "delete from userdata where userid="+userid+";"
  mycursor.execute(sql)
  mydb.commit()


