Original App Design Project - README Template
===

# Job Hunter

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
An application where prospective job hunters can quickly swipe on jobs they would be interested in. If they meet the requirements for the job they will be put in a chat with a recruiter. 

### App Evaluation

- **Category:** productivity / career
- **Mobile:** Job Hunter would be mainly accessible through mobile devices but could possibly be launched on computers.
- **Story:** Determines whether user meets job qualifications and puts them in touch with a recruiter. It will allow the user to easily navigate through relevant job listings and their descriptions.
- **Market:** Individuals actively looking or browsing for jobs, who are in or about to enter the job force.
- **Habit:** This app would be used primarily when looking for a job, so it would not be in use often.
- **Scope:** The app would begin as a job search vessel as well as a way to chat with recuiters and then it could evolve into a platform that fuels connections, possibly partnering with LinkedIn or other job sites.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User picks the jobs they are interested in by swiping left (no) or right(yes)
* After swiping left, the user’s resume will be automatically sent to the HR/recruiter
* User authentication (account is remembered unless manually logged out)
* Profile page that stores user basic information including resume, who he/she is, what he/she is looking for 
* Dashboard that keeps track of all the emails sent/jobs liked
* User can create a new account

**Optional Nice-to-have Stories**

* User can filter relevant jobs  
* User can search up jobs
* User can see the amount of people liked the job
* Trending job page

### 2. Screen Archetypes

* Login Screen 
   * User can login  
* Registration Screen
   * User can register
* Stream
   * Send network requests to job API to retrieve lists of job openings to display
   * User has the option of viewing more information about the job opening
   * Endless scrolling which paginates as user consumes content
* Search
   * User can search up job
* Profile
   * User can update their resume and information
*Dashboard
  * User can view all the jobs he/she liked 


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Profile / Settings
* Dashboard
* Job Search Home

**Flow Navigation** (Screen to Screen)

* Login Screen 
   * Home
 * Registration Screen 
   * Home
* Home 
   * Profile
* Search Screen
  * None
* Profile
  *DashBoard
  * Logout
* Logout screen 
  * Login Screen


## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for a job posting |
   | applicant     | Pointer to User| applicant profile |
   | resume        | File     | resume file |
   | image         | File     | profile image|
   | bio           | String   | description/ bio for each user|
   | jDesc         | String   | job description|
   | salary        | Number   | salary of job |
   
### Networking
- Home Feed Screen
      - (Read/GET) Query all jobs from job aggretor API
      - (Create/POST) Create a new request to apply to job
   - Create Post Screen
      - (Create/POST) Upload resume 
   - Profile Screen
      - (Read/GET) Query logged in user object
      - (Update/PUT) Update user profile image
      - (Update/PUT) Update user profile image
   - Recruiter Profile Page
      - (Read/GET) Query recruiter profile information from Random Profile API
      - (Create/POST) Create direct message post to recruiter
      
[OPTIONAL: List API endpoints]

##### Random User API
- Base URL - [https://randomuser.me/api/](https://randomuser.me/api/)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /        | returns a list of random users with randomly generated attributes
    
##### Arduna Job API
- Base URL - [http://api.adzuna.com/v1/api/jobs](http://api.adzuna.com/v1/api/jobs)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /employerID | searches jobs for that employer
    `GET`    | /keywords | searches for jobs with all keywords
    `GET`    | /locationName| searches for jobs in location


    
##### REED Job API
- Base URL - [https://www.reed.co.uk/api/1.0](https://www.reed.co.uk/api/1.0)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /employerID | searches jobs for that employer
    `GET`    | /keywords | searches for jobs with all keywords
    `GET`    | /locationName| searches for jobs in location



