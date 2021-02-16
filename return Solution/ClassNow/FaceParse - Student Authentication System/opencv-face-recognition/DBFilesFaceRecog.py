#DBFiles
import mysql.connector
def unknownAdd(uname,timel):
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="faceparse"
    )
    mycursor = mydb.cursor()
    sql = "INSERT INTO unknown (uid, timel) VALUES (%s, %s)"
    val = (uname,timel)
    mycursor.execute(sql, val)
    mydb.commit()

def timeLog(uname,timel):
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="faceparse"
    )
    mycursor = mydb.cursor()
    sql = "INSERT INTO timelog (uid, timel) VALUES (%s, %s)"
    val = (uname,timel)
    mycursor.execute(sql, val)
    mydb.commit()

def usrCheck(uid):
    mydb = mysql.connector.connect(
      host="localhost",
      user="sathya",
      passwd="password",
      database="faceparse"
    )
    mycursor = mydb.cursor()

    mycursor.execute("SELECT user_name FROM info WHERE user_id='"+uid+"'")

    myresult = mycursor.fetchall()

    return myresult
    
