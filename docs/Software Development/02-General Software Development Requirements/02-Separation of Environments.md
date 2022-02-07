# Separation of Environments
Information and configuration must not be hardcoded in the software codebase whatsoever (i.e. Database connection string, external service URLs, IP Addresses, host names, etc). These configurations must be designed in such a way that it could be set to different values in different environments. 

Any software code that deviates from this rule will be considered as a **script** and will not go through a regular CI/CD and Deployment Pipelines. The usage of such a software requires the consent of the Head of Software Development **and** the Head DevOps Team. 



These configurations must be properly documented in two ways: 



1. In a README.md file that must exist in every project, preferably with a table that includes the following columns: ENV NAME, DESCRIPTION, DEFAULT VALUE(s)
2. In a .env.example file that can be turned to a “.env” file just be renaming it. This means that all configurations that can have default values will already include the values with them. 



Unless these documents are submitted, the code is not **accepted** and **delivery** is not complete. 

The documentations, as well as the code base, must not include any **secrets**. 

As for naming convention, the following format must be used:

1. Group environment variable configurations by appending double underdashes (__). For instance, this is how database-related environment variables can be grouped:

   ```bash
   DB__CONNECTION=
   DB__USERNAME=
   DB__PASSWORD=
   DB__DBNAME=
   ```

   Think of this structure as JSON Object keys: 

   ```json
   {
     "DB": {
       "CONNECTION": "",
       "USERNAME": "",
       "PASSWORD": "",
       "DBNAME": ""
     }
   }
   ```

   Follow the same pattern if you would like to nested objects deeper. 

2. If you environment variable is an array, append the two underdashes and the index of the position to the name. For example, consider this case: 

   ```bash
   MONGODB__REPLICA_URL__0=
   MONGODB__REPLICA_URL__1=
   MONGODB__REPLICA_URL__2=
   ```

   This is equivalent to the following JSON Object structure: 

   ```json
   {
     "MONGODB": {
       "REPLICA_URL": ["", "", ""]
     }
   }
   ```


