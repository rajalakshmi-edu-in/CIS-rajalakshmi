from flask import Flask, render_template,request,redirect,url_for,flash
from imutils import paths
import numpy as np
import imutils
import pickle
import cv2
import os
import exbd as ex
import DBFiles as dbt
from sklearn.preprocessing import LabelEncoder
from sklearn.svm import SVC
import tm
app = Flask(__name__)

@app.after_request
def add_header(r):
    """
    Add headers to both force latest IE rendering engine or Chrome Frame,
    and also to cache the rendered page for 10 minutes.
    """
    r.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    r.headers["Pragma"] = "no-cache"
    r.headers["Expires"] = "0"
    r.headers['Cache-Control'] = 'public, max-age=0'
    return r

@app.route('/')
def hello_world():
   return render_template('faceParse.html')

@app.route('/addNewUser',methods=['GET','POST'])
def addNewUser():
   if request.method == 'GET':
      return render_template('addNewUser.html')
   if request.method == 'POST':
      uid=request.form['uid']
      uname=request.form['uname']
      uauth=request.form['uauth']
      dob=request.form['dob']
      dbt.approveS2(uid,uname,dob)
      ex.extrt(uid)
      tm.train_model()
      dbt.approveS1(uid)
      temp=dbt.infoRet()
      return render_template('userData.html',ilist=temp,succ="User Added Successfully")   

@app.route('/webcam')
def webcam():
   return render_template('webcam.html')

@app.route('/userData')
def userData():
   temp=dbt.infoRet()
   return render_template('userData.html',ilist=temp,succ="")   

@app.route('/userLog')
def userLog():
   temp=dbt.logT()
   return render_template('userLog.html',kpy=temp)

@app.route('/AConsole',methods=['GET','POST'])
def AConsole():
   if request.method == 'GET':
      temp=dbt.unRet()
      print(temp)
      return render_template('AConsole.html',uklist=temp)
   elif request.method == 'POST':
      ans=request.form['ans']
      if "Approve" in ans:
         op=ans.split()
         return render_template('addNewUser.html',ukid=op[1])
      elif "Deny" in ans:
         op=ans.split()
         dbt.approveS1(op[1])
         temp=dbt.unRet()
         return render_template('AConsole.html',uklist=temp)

@app.route('/extEmb')
def extEmb():
    ex.extrt()
    return "Embeddings being extracted..."

if __name__ == '__main__':
   app.run(debug=True)
