<p align="center">
  <img src="/wavsep-logo.jpeg?raw=true"/>
</p>

# Reinforced-Wavsep 
A reinforced version of the Wavsep evaluation platform.

* Added ≃ 80 GET/POST new cases:

	- Reflected XSS
	- Blind Sql Injection
	- Obfuscation Sql Injection
	- Union Sql Injection
	- XML External Entity
	- Path Traversal
	- OS Command Injection

* Homepage and pages restyling.
* Integrated the WAVSEP benchmark version 1.7

* Added jar libraries for use with mysql 8.0.22 and to execute new XSS and SQLI scenarios (e.g. sectooladdict.jar).

* Solved some bugs.     

## Benchmark test cases
The environment is actually composed of *1405 vulnerable test cases*: 
* 113 vulnerable Reflected XSS test cases;
* 4 vulnerable DOM XSS test cases;
* 168 vulnerable SQL Injection test cases;
* 820 vulnerable Local File Inclusion test cases;   
* 108 vulnerable,  Remote File Inclusione test cases;  
* 120 vulnerable OS-Command-Injection test cases; 
* 60 vulnerable Unvalidated Redirect test cases;   
* 12 vulnerable Xml External Entity test cases;   

The benchmark also contains *40 non-vulnerable test cases*:  
* 7 non-vulnerable Reflected Cross-Site-Scripting test cases;
* 10 non-vulnerable SQL Injection test cases;
* 8 non-vulnerable Local File Inclusion test cases; 
* 6 non-vulnerable Remote File Inclusion test cases; 
* 9 non-vulnerable Unvalidated Redirect test cases; 


# WAVSEP - The Web Application Vulnerability Scanner Evaluation Project

WAVSEP is vulnerable web application designed to help assessing the features, quality and accuracy of web application vulnerability scanners.
This evaluation platform contains a collection of unique vulnerable web pages that can be used to test the various properties of web application scanners.

## Installation 
### Modern approach
Install docker and docker-compose: 
- https://docs.docker.com/get-docker/ 
- https://docs.docker.com/compose/install/   


### Old style approach
(1) Download & Install OpenJdk (suggested >= 11.x).<br/>
(2) Download & install Apache Tomcat (suggested >= 8.x).<br/>
(3) Download & install MySQL Community Server 8.0.22 (sudo apt install mysql-server).<br/>
(3) Copy the wavsep.war file into the tomcat webapps directory.<br/>
(4) Restart the application server.<br/>
<br/>
Example of installation with new setup (January 2021):<br/>
<br/>
(1) JDK:
```bash
sudo apt install openjdk-11-jdk
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
java --version
```
(2) Apache Tomcat:
```bash
mkdir /opt/tomcat
cd /opt/tomcat
wget http://apache.spinellicreations.com/tomcat/tomcat-8/v8.5.32/bin/apache-tomcat-8.5.32.tar.gz
tar xvzf apache-tomcat-8.5.32.tar.gz
export CATALINA_HOME=/opt/tomcat/apache-tomcat-8.5.32
~/.bashrc
$CATALINA_HOME/bin/startup.sh
```
(3) MySQL Community Server:
```bash
sudo apt update
sudo apt install mysql-server
sudo mysql_secure_installation (During installation select 'N', 0, enter root password, 'Y')
systemctl status mysql.service
```

## Usage    
Run the environment with the modern or old-style approach, then the wavsep benchmark is available at the following link:   

http://127.0.0.1:18080/wavsep/  

Use the `Makefile`:   
* run the environmet:  `make up` 
* build the docker image: `make build` 
* stop the environment: `make down` 

### Old style approach 

(i) Create the package with `mvn package`and copy the wavsep.war file into the tomcat webapps directory (with git):
```bash
cd /opt/tomcat/webapps/
mv /path/to/wavsep.war/ .
```
(ii) Restart the application server:
```bash
$CATALINA_HOME/bin/startup.sh

or

cd/opt/tomcat/bin/
./startup.sh
```

Although some of the test cases are vulnerable to additional exposures, the purpose of each test case is to evaluate the detection accuracy of one type of exposure, and thus, “out of scope” exposures should be ignored when evaluating the accuracy of vulnerability scanners.

**Note:** To use SQLI labs correctly there is a .jsp page whose purpose is to create and populate the necessary database tables. To do this, visit the URL "**/wavsep/wavsep-install/install.jsp**", and follow instructions.

## Contributing
Copyright © 2020, Luigi Urbano, Università degli Studi di Napoli Federico II<br/>
Copyright © 2014, Shay Chen<br/>

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.    

## Citation
If you find this code useful in your research, please, consider citing our paper:   
``` 
@inproceedings{Urbano2022,
  doi = {10.1109/icecet55527.2022.9872956},
  year = {2022},
  month = jul,
  publisher = {{IEEE}},
  author = {Luigi Urbano and Gaetano Perrone and Simon Pietro Romano},
  title = {Reinforced {WAVSEP}: a Benchmarking Platform for Web Application Vulnerability Scanners},
  booktitle = {2022 International Conference on Electrical,  Computer and Energy Technologies ({ICECET})}
}
```

## License
[MIT](https://choosealicense.com/licenses/mit/)
