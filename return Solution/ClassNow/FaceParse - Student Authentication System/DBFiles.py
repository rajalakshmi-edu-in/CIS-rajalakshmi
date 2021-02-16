#Database for Frontend
import mysql.connector
def infoRet():
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="faceparse"
    )
    mycursor = mydb.cursor()

    mycursor.execute("SELECT user_id,user_name,status FROM info")

    myresult = mycursor.fetchall()

    return myresult

def unRet():
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="faceparse"
    )
    mycursor = mydb.cursor()

    mycursor.execute("SELECT uid,timel FROM unknown")

    myresult = mycursor.fetchall()

    return myresult

def approveS1(uid):
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="faceparse"
    )
    mycursor = mydb.cursor()
    mycursor.execute("DELETE FROM unknown WHERE uid='"+uid+"'")
    mydb.commit()
def approveS2(uid,uname,dob):
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="faceparse"
    )
    mycursor = mydb.cursor()
    sql = "INSERT INTO info (user_id, user_name, dateofbirth,status) VALUES (%s, %s, %s, %s)"
    val = (uid,uname,dob,"Authorized")
    mycursor.execute(sql, val)
    mydb.commit()

def logT():
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="faceparse"
    )
    mycursor = mydb.cursor()

    mycursor.execute("SELECT uid,timel FROM timelog")

    myresult = mycursor.fetchall()

    return myresult

    
    
