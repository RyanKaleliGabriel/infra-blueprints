# Base Image
FROM julia:1.10.5 

#Create system user and home direcory
RUN useradd --create-home --shell /bin/bash genie

# Create working directory and change ownership to the user created
RUN mkdir /home/genie/app
COPY . /home/genie/app
WORKDIR /home/genie/app
RUN chown -R genie:genie /home/

# Switch user to genie
USER genie

#Activate and start the julia project
RUN julia -e "using Pkg; Pkg.activate(\".\"); Pkg.instantiate();"

#Expose Container port
EXPOSE 8000

#Julia environment variables
ENV JULIA_DEPOT_PATH "/home/genie/.julia"
ENV JULIA_REVISE = "off"
ENV GENIE_ENV "prod"
ENV GENIE_HOST "0.0.0.0"
ENV PORT "8000"
ENV WSPORT "8000"
ENV EARLYBIND "true"

# Julia secrets
RUN julia -e 'using Pkg; using Genie; Genie.Generator.write_secrets_file();'
#Run the app
ENTRYPOINT ["julia", "--project", "-e", "using GenieFramework; Genie.loadapp(); up(async=false);"]