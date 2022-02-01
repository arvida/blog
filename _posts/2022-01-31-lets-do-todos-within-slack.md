---
title: Manage tasks in Slack with Let's Do
---

<p style="font-size: 14px; font-style: italic;">
<strong>TLDR:</strong> I am building an app to manage to-dos within Slack. It is called <a href="https://www.letsdo.io">Let's Do</a>.
</p>

__I have used loads of task management tools on various platforms over the years. Sometimes, more advanced systems like Jira, PivotalTracker, or Trello make sense. Other times you just want a list of tasks shared with other people.__

A simple list of tasks is excellent as there is very little time needed to understand how it works. It is just a list of things that need to get done, sometimes together with metadata like due dates, prioritization, or who is responsible for carrying out the task. Easy to understand, use and follow. 
I use to-do lists to organize different parts of my life, in digital tools and on Post-Its, and in notebooks. Easy to reach for, and it works great in different contexts.

Since Slack introduced itself around eight years ago, it has become the de facto way to organize and operate for many organizations. Over the years, I have been part of loads of different Slack workspaces; during my time at <abbr title="a design agency I ran together with a couple of other people for ten years">Oktavilla</abbr> working with clients and projects, and during my time as a freelance consultant. Often in the role of managing work and also in the role as an individual contributor.

One thing that I have always come back in one form or another is that Slack could work great to organize work. Both as it is where the communication happens and as a platform to build tools on. The collaborators usually already are in Slack on their own devices and are familiar with the application. It has a standardized UI with a limited set of well-known components. You create clear contexts and processes using channels. 

The fallback solution for handling tasks has often been to use an external tool that comes with switching from the primary communication tool to another specifically for tasks. Sometimes it's needed, but not always. Also, you often want to involve people from another team or organization, and then they have to set up in the task management tool. Another way is to use Slacks native ”Posts” feature, but in my experience, that can quickly get clunky.

Last year I started to experiment with how tasks could be managed within Slack using a Slack app. The underlying idea is that as we already are in Slack all day, it could also be a good idea to use it as the workspace for managing tasks in a small team or for a project. After testing a few different concepts, I come up with a few realizations:
- Teams and organizations often create their processes for managing tasks. Provide the tools to handle tasks, due dates, assignments etc., not the process of how to work with tasks. 
- Embrace the limitations of Slacks API. Trying to innovate within Slack easily becomes confusing. Using the tools available with Slacks API, things must be kept simple and focused to be comprehensible.
- One to-do list - one channel. The natural context of channels in Slack also works excellent for creating a context for tasks. 
- Use native Slack processes instead of coming up with new ones. For example, use regular Slack threads associated with the particular to-do to add a discussion about a to-do. 

So, I built out my first version of a to-do manager as a Slack app. And then I iterated. In early November, the app was approved to be listed in the Slack app directory and has since then been in open beta. 


<img src="https://dcq3fmhnv6rly.cloudfront.net/assets/app-home-f6b2b8246eb9694a80a533535ac2560a22e599e60422548b762fdc3b959821c6.png" style="border: 1px solid #eee; border-radius: 0.25rem; box-shadow: rgba(149, 157, 165, 0.2) 0px 8px 24px; margin: 10px 2px 15px 2px;">

There has been a steady flow of new user sign-ups and to-dos created. It has provided great feedback and validation of my different ideas for a Slack to-do manager. And I look forward to continuing working on it and creating a tool that gives value to other people and organizations.


The app is called __[Let's Do](https://letsdo.io)__. To check it out visit [https://letsdo.io](https://letsdo.io). 
