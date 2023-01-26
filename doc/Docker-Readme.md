The Reinforced Wavsep Image.  
Github Repo at: 
* https://github.com/0xUrbz/Reinforced-Wavsep

## Usage    
The image depends on the wavsep db (`nsunina/wavsep-db`).  
You need `docker-compose` or create a script to run it. 

### Docker compose usage


To use it with `docker-compose`: 
``` 
docker-compose up   # docker compose up   
```   
### Docker usage

To use it with `docker`:   
```  
docker network create wavsep-net
docker run --rm -d --net wavsep-net --name wavsepdb nsunina/wavsep-db:v1.8 
docker run --rm -d --net wavsep-net -p 18080:8080 --name wavsep nsunina/wavsep:v1.8
```   


The wavsep will run on `http://0.0.0.0:18080` .     

### Stop

To stop it:  
``` 
docker-compose down    
```
if you are using `docker-compose`, otherwise:   
```   
docker rm -f wavsep
docker rm -f wavsepdb
docker network rm wavsep-net
```



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
Distributed under the GPLv3 License. See LICENSE.txt for more information.


