import cv2
import time
import numpy
import os
import imutils

def buildDataset(usrnm):
    capture = cv2.VideoCapture(0)
    capture.set(3,640)
    capture.set(4,480)
    img_counter = 0
    frame_set = []
    print("Console: Writing Started")
    while(True):
        
        ret , frame = capture.read()
        frame = imutils.resize(frame, width=400)
        cv2.imshow('frame',frame)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
        if not os.path.exists("unknownData/"+usrnm):
            os.makedirs("unknownData/"+usrnm)
        img_name = os.path.sep.join(["unknownData/"+usrnm, "{}.png".format(
                            str(img_counter).zfill(5))])
        cv2.imwrite(img_name,frame)
        img_counter +=1
        if img_counter > 150:
            capture.release()
            cv2.destroyAllWindows()
            time.sleep(3)
            print("Dataset for"+usrnm+" created")
            break

def addDataset(usrnm):
    capture = cv2.VideoCapture(0)
    capture.set(3,640)
    capture.set(4,480)
    img_counter = 0
    frame_set = []
    print("Console: Writing Started")
    while(True):
        
        ret , frame = capture.read()
        frame = imutils.resize(frame, width=400)
        cv2.imshow('frame',frame)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
        if not os.path.exists("knownData/"+usrnm):
            os.makedirs("knownData/"+usrnm)
        img_name = os.path.sep.join(["knownData/"+usrnm, "{}.png".format(
                            str(img_counter).zfill(5))])
        cv2.imwrite(img_name,frame)
        img_counter +=1
        if img_counter > 15:
            capture.release()
            cv2.destroyAllWindows()
            time.sleep(3)
            print("Dataset for"+usrnm+" created")
            break
