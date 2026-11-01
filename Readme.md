# Pre-Processing for IEEM_CMCNN Model
In this part the saved structured data from for both bearing is combined and converted to required shape for the model and class labels are created. 

Usually Convolutional Neural network input can be 3 dimensional. Like an Image pixel information can be represented with 3 matrixes each for colour red, blue and green. So an Input can be described as Height x Width(or length) x Depth (i.e. Famous VGG16 input shape is 224 x 224 x 3).

In this work input is vibration so it is an one-dimensional data. 

So the shape of such data should be 1x Length x 1

But in this work we consider the vibration input as 3-dimensional because in the our testbench a particular bearing is monitored with three sensors: one which is closest to the bearing called Mainsensor, another which is at opposite side or closest to the opposite bearing is called Oppsensor and the one at base plate called Basesensor.

Such way the input shape is: 1 x 1000 x 3 (the choice of length size is discussed in paper)

But in real cases similar 3 sensors may not be available, so if the CNNs model is trained with only 3-dimensioal input, other cases will not be considered.
So we created some inputs having only Mainsensor data and for other sensors data are zero.

The Pre-processing is required because CNN model take input as 4D data: Height x Length x Depth x Number of Data

Also in Pre-Processing we create the label the inputs for its classes.

Let’s say A, B, C, D are raw data of differnt number of data points (here equal); A & B are same class and C & D are same class. 
For training (or testing) the raw data is reqiure to convert into 4D data of chosen Input length as here  1 x 4 x 1 x Number of Data

where: 

A= [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 

B= [1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1 1.1];

C= [2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2]; 

D= [2.1 2.1 2.1 2.1 2.1 2.1 2.1 2.1 2.1 2.1 2.1 2.1 2.1 2.1 2.1 2.1];

As all above data are length 16, so total number of data in the Input is (16/4)*4 =16

4D Input and its labels:

<img width="330" height="357" alt="image" src="https://github.com/user-attachments/assets/447fc222-6f70-4313-b12c-ec646177ffb7" />

Input size= 1 x 4 x 1 x 16

There are mainly two functions:
1.	Convert the 1dim data to 3dim data (4th dimension is number of data) and create labels

[Data4D,label]=Convert_ClassStruct_1dim_3channel(structdata,class, learntimesec,segment);

So it takes one total class data with all speed and load with 3 sensors.
<img width="603" height="197" alt="image" src="https://github.com/user-attachments/assets/b45e6b10-5ae6-4f5b-8226-c25b414473c7" />

 

>> size(Data4D)

ans =

           1        1000           3        1860

2.	[sensor4D,senlabal]=Convert_3sensor_3channel_to_one(Data4D,sensor,class);
It mentioned earlier some of the data is kept considering only Mainsensor available. So this function take the Data4D and create 3 dim data with two zero matrixes.
Output:
Output is one 4D data and one categorical 1D data of labels.
With both Bearing data for creating 4 classes: Healthy, IRFault, ORFault, RRFault
'FEBearing_TrainData_4Class.mat'
'DEBearing_TrainData_4Class.mat'


The outputs size:
>> size(traindata)

ans =

           1        1000           3      172800



