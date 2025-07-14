FROM rocker/shiny:latest

USER root
WORKDIR /shiny/dashboard

# Install system dependencies for 'terra' and others
RUN apt-get update && apt-get install -y 
RUN apt-get install libgdal-dev -y
RUN apt-get install libgeos-dev -y
RUN apt-get install libproj-dev -y
RUN apt-get install libtbb-dev -y
RUN apt-get install libnetcdf-dev -y
RUN apt-get install libudunits2-dev -y
RUN apt-get install cmake -y

# Copy your app code
COPY . .

# Install R packages
RUN Rscript -e "install.packages(c('shiny', 'bslib', 'leaflet', 'dplyr', 'terra', 's2', 'sf', 'mapgl', 'shinydashboard', 'shinydashboardPlus'), repos='https://cran.rstudio.com')"

EXPOSE 3838

CMD [ "Rscript", "-e", "shiny::runApp('/shiny/dashboard', port = 3838, host = '0.0.0.0')" ]