# Field-PIV-toolbox

##Object

The main purpose of the toolbox is for PIV turbulence analysis, there's no open-source turbulent analysis toolbox for PIV data. I want to share some ideas of turbulent analysis in this toolbox.  

Image process PIV image and estimate turbulence parameters. The toolbox will include two parts: 
1) PIV calculation 
2) Turbulence toolbox.

The toolbox was written in MATLAB, was tested at MATLAB 2018a. Imgae processing toolbox may required. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 


### Prerequisites

Install MATLAB 2018a, may need image processing toolbox. 

To call the functions

```
[u,v] = lakepiv(A,B,[40,40],[100,1800,100,800])
```
To store the data, we can do matlab structure
```
velocities(i).u = u;
velocities(i).v = v;

```
Or more Python friendly, 3D matrix
```
[u,v] = lakepiv(A,B,[40,40],[100,1800,100,800])
U(:,:,i) = u;
W(:,:,i) = w;
```


### Installing

Add the folder to path. Main panel -> Set Path -> Add with subfolders. Or 

```
addpath('The\path\of\the\folder')
```

```

```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

* test PIV calculation
  
  Run test_piv.m. The result of the script is expected to plot the PIV image with velocity vector ploted on it.
  
* test turbulent 

  Run test_turb.m There will be a figure with subplot on it. 

### Break down into end to end tests

Compare the dissipation rate method, the different methods comparison live script will be added in the project

```
Here should be a example later
```



## Authors

* **Tong Jin** Ph.D. Candinate in University of Wisconsin, Milwaukee
* Research: Ocean Science, Fluid mechanics, Turbulence

## License

Free for any personal or research use

## Acknowledgments

* Dissipation rate estimation by Large eddy method and direct method(Sheng 2000, Doron 2001)
* Median test method and normalized median test method for removing outlier(Westerweel 1994, 2005)
* Application of large scale PIV in river surface turbulence measurements and water depth estimation(Jin 2019)
* etc
