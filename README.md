# Field-PIV-toolbox

Image process PIV image and estimate turbulence parameters. The toolbox will include two parts: 
1) PIV calculation 
2) Turbulence toolbox.

The toolbox was written in MATLAB, was tested at MATLAB 2018a. Imgae processing toolbox may required. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 


### Prerequisites

Install MATLAB 2018a, may need image processing toolbox. Will try to make Octave works on the toolbox

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

Compare the dissipation rate method, the different methods 

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
