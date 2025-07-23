## A Section i will be documenting docker commands

## Image Building

 - Building an image. The image name must be in lowercase. Navigate inside the directory where you have the docker file and run

   ```
   docker build -t image_name:tag .
   ```

## Container Operations

 - Checking all containers

   ```
   docker ps -a
   ```

 - Copying a file in a docker container

   ```
   docker cp /home/spatial/Downloads/julia-1.10.9-musl-x86_64.tar.gz 15062ec62fc7:/home/genie/
   ```

 - Copy a directory from a docker container to host 

    ```
    docker cp my_container:/app/logs /home/user/logs_backup   
    ``` 

 - Running a base OS image
   
   ```
   docker run -it -d --name rwanda-alpine alpine sh
   ```

   Inside the container run

   ```
   exit
   ```

   Start the container again
   
   ```
   docker start container_name
   ```

   If you want to jump into the container again 

   ```
   docker exec -it rwanda-alpine sh
   ```