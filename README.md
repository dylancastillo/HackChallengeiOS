# Frat App

App Tagline: events manager for fraternity members, and attendees of fraternity events.

https://github.com/Aayush-Agnihotri/HackChallenge

We want to develop an app that streamlines the process for fraternities to admit and manage attendees at their parties, allowing them to grant or deny access via a digital scan rather than physical wristbands. Fraternities will allow certain members of their frat to allot invites to one or many people (where one person can share with a few of their friends). There are three types of users on this application, (i) regular students not in greek life, (ii) students in greek life, (iii) fraternities. Students will be able to see public greek life events, and get invited to multiple fraternity events and accept those invites.


* NSLayoutConstraint used for everything
* There are 5 distinct UITableViews.
* Navigation: When an event is created or edited, there is a push with delegation. When you look at an event's details, it is presented with delegation. You can navigate between
"Public" and "Invites" by tapping the bottom of the screen.
* Integrate with your Backend’s API: The events that show up are from the backend. When an event is created, it is sent to the backend, where it is stored. When an event is edited, it is edited
through the backend. When an event is deleted, it is deleted through the backend. When a private event is accepted or declined, it is accepted or declined through the backend.

