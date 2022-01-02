# final-Project


## Description
An application that enables those wishing to volunteer or donate to record and save their data, see the locations of hospitals near them and available for volunteering, and display their contact information for people in need.

## User Stories
- Registration: As a user, I want to register in the application so that I can save my data.
- Login: As a user, I want to log in so I can use the app.
- the cities :
As a volunteer or donor, I want to see the available areas in my city to facilitate access to its hospitals.
- Donation :
As a donor, I want to add my data and enable those in need of blood to see it and communicate with me.
As a donor, I want to add my data so that those in need, after the death of the donor, can benefit from the organs.
As a needy, I want to see the donors' data so that I can communicate with them.
As a user, I want to read more about blood group information in order to benefit from the information.
- Volunteering:
As a volunteer, I want to add my data and enable those in need to see it and communicate with me.
As a needy, I want to see the volunteers' data so that I can communicate with them.
Location :
As a user, I want to search for the hospital and find its location so that I can reach it.
- Profile personly:
As a user, I want to see my data so I can edit and save it.
As a user, I want to change the appearance of the application to allow the use of night mode and light mode.
As a user, I want to hide my profile picture to preserve privacy.
As a user, I want to change the language from Arabic to English and vice versa to make the application easier to use.
As a user, I can log out of the app so that no one else can use my data.

| Component        | Permissions | Behavu 
| :---             |     ---   |   :---    |
| AnimationPage          | public      | Frist page |
| logInPage                  | anon only   | link to login or register, navigate to tabBar after signIn.|
| Cities Page                | user only    | Show all Cities  , navigate to Service Type.|
| Service Type page    | user only    | Show all Service Type , navigate to the Donors page, Organ Donation ,volunteer.|
| Donors page              | user only  | Show all Donors, link to new donor.|
| New Donors  page     | user only   | add donors data by user.|
| Information Page.        | user only   | information appear about the blood .| 
| Organ Donation page  | user only  | Show all Donors, link to new donor.|
| New Benefactor page   | user only   | add Benefactor data by user.|
| Hospital page | user only | Show all hospital , navigate to the Attendant page. |
| Attendant page  | user only  | Show all volunteer, link to new Attendant.|
| New Attendant page   | user only   | add volunteer data by user.|
| profile page      | user only | Change the app language and change between dark or light mode, change my data.|


## Components: 
- AnimationPage.
- logInPage.
- Cities Page.
- Service Type page.
- Donors page.
- New Donors page
- Information Page.
- Organ Donation page.
- New Benefactor page.
- Hospital page.
- Attendant page.
- New Attendant page.
- profile page.

## Services
auth.login(user)
auth.signup(user)
auth.logout()

## Models
- User model
{  User: {name: String , id: String, userEmail: String} }
- Hospital Model
{  User: {name : String, id : String, image : String} }
- Donors Model 
- Attendant Model
- Organ Model
