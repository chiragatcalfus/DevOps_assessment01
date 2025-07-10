# DevOps_assessment01

The http.sh shell file first runs the maintain.sh to generate the report which is stored at /opt/audit/summary.txt Then copies the summmaryfile.txt here in this folder then adds the uptime and no of useers online to the summary.txt and then adds the report to the html file and docker run the nginx http server with the volume mounted to this folder and deploys on localhost.