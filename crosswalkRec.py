

import numpy as np
import cv2
import math
import scipy.misc
import PIL.Image
import statistics
import timeit
import glob
from sklearn import linear_model, datasets

def linecalculation(vx, vy, x0, y0):
    scale = 10
    x1 = x0+scale*vx
    y1 = y0+scale*vy
    m = (y1-y0)/(x1-x0)
    b = y1-m*x1
    return m,b

def angleprediction(pt1, pt2):
    x1, y1 = pt1
    x2, y2 = pt2
    inner_product = x1*x2 + y1*y2
    len1 = math.hypot(x1, y1)
    len2 = math.hypot(x2, y2)
    print(len1)
    print(len2)
    a=math.acos(inner_product/(len1*len2))
    return a*180/math.pi 

def lineintersection(m1,b1, m2,b2) : 
    a_1 = -m1 
    b_1 = 1
    c_1 = b1

    a_2 = -m2
    b_2 = 1
    c_2 = b2

    d = a_1*b_2 - a_2*b_1 #determinant
    dx = c_1*b_2 - c_2*b_1
    dy = a_1*c_2 - a_2*c_1

    intersectionX = dx/d
    intersectionY = dy/d
    return intersectionX,intersectionY

def prediction(im):
    start = timeit.timeit() #start timer

    x = W
    y = H

    radius = 250 #px
    thresh = 170 
    bw_width = 170 

    bxLeft = []
    byLeft = []
    bxbyLeftArray = []
    bxbyRightArray = []
    bxRight = []
    byRight = []
    boundedLeft = []
    boundedRight = []
    
    lower = np.array([170,170,170])
    upper = np.array([255,255,255])
    mask = cv2.inRange(im,lower,upper)

    erodeSize = int(y / 30)
    erodeStructure = cv2.getStructuringElement(cv2.MORPH_RECT, (erodeSize,1))
    erode = cv2.erode(mask, erodeStructure, (-1, -1))

    contours,hierarchy = cv2.findContours(erode,cv2.RETR_TREE,cv2.CHAIN_APPROX_NONE )
 
    for i in contours:
        bx,by,bw,bh = cv2.boundingRect(i)

        if (bw > bw_width):
            
            cv2.line(im,(bx,by),(bx+bw,by),(0,255,0),2) 
            bxRight.append(bx+bw) 
            byRight.append(by) 
            bxLeft.append(bx)
            byLeft.append(by)
            bxbyLeftArray.append([bx,by])
            bxbyRightArray.append([bx+bw,by]) 
            cv2.circle(im,(int(bx),int(by)),5,(0,250,250),2) 
            cv2.circle(im,(int(bx+bw),int(by)),5,(250,250,0),2) 

    medianR = np.median(bxbyRightArray, axis=0)
    medianL = np.median(bxbyLeftArray, axis=0)

    bxbyLeftArray = np.asarray(bxbyLeftArray)
    bxbyRightArray = np.asarray(bxbyRightArray)
     
    for i in bxbyLeftArray:
        if (((medianL[0] - i[0])**2 + (medianL[1] - i[1])**2) < radius**2) == True:
            boundedLeft.append(i)

    boundedLeft = np.asarray(boundedLeft)

    for i in bxbyRightArray:
        if (((medianR[0] - i[0])**2 + (medianR[1] - i[1])**2) < radius**2) == True:
            boundedRight.append(i)

    boundedRight = np.asarray(boundedRight)

    bxLeft = np.asarray(boundedLeft[:,0])
    byLeft =  np.asarray(boundedLeft[:,1]) 
    bxRight = np.asarray(boundedRight[:,0]) 
    byRight = np.asarray(boundedRight[:,1])

    bxLeftT = np.array([bxLeft]).transpose()
    bxRightT = np.array([bxRight]).transpose()

    model_ransac = linear_model.RANSACRegressor(linear_model.LinearRegression())
    ransacX = model_ransac.fit(bxLeftT, byLeft)
    inlier_maskL = model_ransac.inlier_mask_ 

    ransacY = model_ransac.fit(bxRightT, byRight)
    inlier_maskR = model_ransac.inlier_mask_ 

    for i, element in enumerate(boundedRight[inlier_maskR]):
   
        cv2.circle(im,(element[0],element[1]),10,(250,250,250),2) 

    for i, element in enumerate(boundedLeft[inlier_maskL]):
       # print(i,element[0])
        cv2.circle(im,(element[0],element[1]),10,(100,100,250),2) 


    vx, vy, x0, y0 = cv2.fitLine(boundedLeft[inlier_maskL],cv2.DIST_L2,0,0.01,0.01) 
    vx_R, vy_R, x0_R, y0_R = cv2.fitLine(boundedRight[inlier_maskR],cv2.DIST_L2,0,0.01,0.01)

    m_L,b_L=linecalculation(vx, vy, x0, y0)
    m_R,b_R=linecalculation(vx_R, vy_R, x0_R, y0_R)

    intersectionX,intersectionY = lineintersection(m_R,b_R,m_L,b_L)

    m = radius*10 
    if (intersectionY < H/2 ):
        cv2.circle(im,(int(intersectionX),int(intersectionY)),10,(0,0,255),15)
        cv2.line(im,(x0-m*vx, y0-m*vy), (x0+m*vx, y0+m*vy),(255,0,0),3)
        cv2.line(im,(x0_R-m*vx_R, y0_R-m*vy_R), (x0_R+m*vx_R, y0_R+m*vy_R),(255,0,0),3)

   

    POVx = W/2
    POVy = H/2 

    Dx = -int(intersectionX-POVx) 
    Dy = -int(intersectionY-POVy) 

    focalpx = int(W * 4.26 / 6.604) #all in mm


    end = timeit.timeit() #STOP TIMER
    time_ = end - start

    print('DELTA (x,y from POV):' + str(Dx) + ',' + str(Dy))
    return im,Dx,Dy
 
cap = cv2.VideoCapture('inputVideo.mp4') 

W = cap.get(3)
H = cap.get(4) 
 
ratio = H/W
W = 800
H = int(W * ratio)

fourcc = cv2.VideoWriter_fourcc(*'mp4v')
out = cv2.VideoWriter('processedVideo.mp4',fourcc, 15.0, (int(W),int(H)))

Dx = []
Dy = []
after =0
DxAve =0
Dxold =0
DyAve =0
Dyold =0
i = 0
state = ""

while(cap.isOpened()):
    ret, frame = cap.read()
    img = scipy.misc.imresize(frame, (H,W)) 
    
    #draw camera's POV
    cv2.circle(img,(int(W/2),int(H/2)),5,(0,0,255),8)
    
    # try:
    processedFrame,dx,dy = process(img)

    if (i < 6):
        Dx.append(dx)
        Dy.append(dy)
        i=i+1

    else:
        DxAve = sum(Dx)/len(Dx)
        DyAve = sum(Dy)/len(Dy)
        del Dx[:]
        del Dy[:]
        i=0

    if (DyAve > 30) and (abs(DxAve) < 300):        
        if (((DxAve - Dxold)**2 + (DyAve - Dyold)**2) < 150**2) == True:  
            cv2.line(img,(int(W/2),int(H/2)),(int(W/2)+int(DxAve),int(H/2)+int(DyAve)),(0,0,255),7)
            
            if abs(DxAve) < 80 and DyAve > 100 and abs(Dxold-DxAve) < 20:
                state = 'Straight'
                cv2.putText(img,state,(50,50), cv2.FONT_HERSHEY_PLAIN, 3,(0,0,0),2,cv2.LINE_AA)

            elif DxAve > 80 and DyAve > 100 and abs(Dxold-DxAve) < 20:
                state = 'Right'
                cv2.putText(img,state,(50,50), cv2.FONT_HERSHEY_PLAIN, 3,(0,0,255),2,cv2.LINE_AA)

            elif DxAve < 80 and DyAve > 100 and abs(Dxold-DxAve) < 20:
                state = 'Left'
                cv2.putText(img,state,(50,50), cv2.FONT_HERSHEY_PLAIN, 3,(0,0,255),2,cv2.LINE_AA)
        else:
            cv2.line(img,(int(W/2),int(H/2)),(int(W/2)+int(Dxold),int(H/2)+int(Dyold)),(0,0,255),)
        
        if state == 'Straight':
            cv2.putText(img,state,(50,50), cv2.FONT_HERSHEY_PLAIN, 3,(0,0,0),2,cv2.LINE_AA)
        else:
            cv2.putText(img,state,(50,50), cv2.FONT_HERSHEY_PLAIN, 3,(0,0,255),2,cv2.LINE_AA)           

        Dxold = DxAve
        Dyold = DyAve

    # except Exception as e:
    #     print(e)

    img = cv2.imshow('Processed',processedFrame) 
    out.write(processedFrame)
    
    if cv2.waitKey(1) & 0xFF == ord('q') or cv2.waitKey(1) & 0xFF == ord('Q'):
        break

out.release()
cap.release()
cv2.destroyAllWindows()
