
**Flutter App**

![Screenshot_1587312149](https://user-images.githubusercontent.com/52973501/79696268-62f43480-8299-11ea-860e-f610eee2cdd2.png)


**What is the problem that we want to address?**

Medical care is a top priority in today's world. Most of us are able to reach the doctors or medical support in time. But some are unfortunate enough that medical support in not able to reach them in time. Even within a span of 5 to 10 mins we can save someone's life. We want to reach out to the people who are not provided with medical care in time. Due to the rising epidemic of COVID-19, the need for medical care has reached its peak and we our in need of medical help way more than more.

![Screenshot_1587312400](https://user-images.githubusercontent.com/52973501/79696346-c2eadb00-8299-11ea-8242-c92b518f1119.png)

**The Solution we came up with.**

When your are in the face of an medical emergency, you would want medical help to reach you as soon as possible. But it could be possible that you might no know any doctors near you and the nearest hospital to you could be a bit far away. Even if you knew a doctor it could be possible that he/she might not be available. There may be a lot of doctors in your vicinity, but you may not know about them. We came up with an idea that utilises a simple mobile application and uses it to contact your nearest doctor and fetch medical help for you.

![Screenshot_1587312396](https://user-images.githubusercontent.com/52973501/79696331-ad75b100-8299-11ea-8357-bd0a8642abb3.png)


How can a simple mobile application be of help?

The human civilization has reached the technological era. With recent enhancement in technology, instant  connectivity is possible. This is achieved by a concept known as socket connections. The user press a button and the nearest doctor is sent an alert that an emergency is happening near him and would he like to attend to it or not.


![Screenshot_1587312153](https://user-images.githubusercontent.com/52973501/79696361-dac25f00-8299-11ea-9660-df99c35befb6.png)

**The process with which the app works**

The user triggers an alert, (the user can trigger the alert with registering and logging in). Then his location is sent to firebase which finds the nearest doctor to his/her location using a simple algorithm. Then an alert is sent to the doctor that an emergency is happening near him and would he like to attend to it or not. Should the doctor choose ‘NO’, another doctor is sent the same alert. This process is repeated until a doctor accepts then emergency.(The alert will have a maximum distance).
Note- Neither the app nor the doctor is liable if anything happens to the paitent.

**Authentication for the doctors**

To authenticate if the person registering as a doctor is real or not, we will intake their medical registration id and compare it with Governments API that gives out a list of Doctors. If this does not happen, we will use machine learning to scan their id’s and check for authenticity.

![Screenshot_1587312466](https://user-images.githubusercontent.com/52973501/79696372-eada3e80-8299-11ea-891d-bd94bbfe040b.png)

**Future Growth Possible in the Application**

1)Adding a feature that displays maps  and shows the remaining distance between doctor and the user.

2)Adding a map that shows the nearest clinics and hospitals

3)A feature that allows us to book an appointment in a certain clinic or a hospital.

4)Adding a feature that allows you to call  the doctor after he accepts the emergency alert.

5)Calling the ambulance as soon as the alert is triggered.

6)Adding maximum time limit with which the doctor is allowed to accept the emergency.


**Note to run this this app, Googleservices.json file is required**
