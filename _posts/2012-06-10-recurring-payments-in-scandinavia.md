---
title: Recurring payments in Scandinavia
---

At [Oktavilla](http://oktavilla.se) we are working on a product called [PortfolioDeck](http://portfoliodeck.com). It has been a long time coming and we are getting close to the first public release. One of the things we have been working on this spring is adding monthly payments for using the service, what you usually call _recurring payments_ or _subscription billing_.

There are a few cool services out there for doing this but they usually requires a US merchant account or that you are based in the US. We are doing this a Swedish company and don't have a US merchant account so the options have been limited when it comes to adding this without building the whole payment and plan handling system from scratch. I have seen quite a few posts on sites like [HackerNews](http://news.ycombinator.com/) asking how to do recurring billing if you are not US based and it looks like there are little information on how to do this. 

After some research we ended up using three different services to solve this:

* [Chargify](http://chargify.com/) for billing and plan management 
* [QuickPay](http://quickpay.net) as payment service provider
* [Euroline](http://www.euroline.se/) to manage the actual transactions

With these three services setup it is pretty easy to do recurring payments, you just have to integrate with Chargify's API which is not a big issue once you have wrapped your head around it. When new users sign up they get assigned to a plan in trialing mode (a subscription) on Chargify, if they want to start to pay for the service after the trial is over they add their credit card details using Chargify's [hosted pages](http://docs.chargify.com/hosted-page-integration) and then we get callbacks to the app letting us know how the state changes on each users subscription. QuickPay and Euroline handles the actual transactions in the background.

## A few pointers 

To make the process as fast as possible I would suggest that you start out with adding the billing screens and Chargify integration to your application (test out the API using Chargify's [Test Gateway](http://docs.chargify.com/gateway-configuration)). The reason to start with this is that Euroline wants to screen your web site before accepting you as a customer to ensure that the appropiate information on billing is available to your new customers. Euroline will provide you with a list of information that has to be on the web site when you contact them the first time. 

When applying for your Euroline account make sure that you enter all the different currencies that you want to accept. Also make sure that you get both a customer number and TOF number after they have accepted you as a customer. It tooks us about a week to get the right TOF number and to work out why we were getting an error. The error message just said ”120” and it turned out that is was raised because our account was not setup to  handle Euro. 

I got a bit confused by the QuickPay interface at first. To set up Euroline in QuickPay manager: under the Settings category in the navigation open the Acquirers screen and add your TOF number and enable subscription payments below “Nets/Teller” also add your Euroline customer number as the Euroline merchant ID below “Euroline”. 

You can check that the QuickPay integration is working if you open up the Tools category in QuickPay manager navigation and click the Testsuite item, then run the “Test subscription“ test to verify. When the test passes just enable QuickPay in Chargify and your are ready to start accepting recurring payments.

## The future

I really hope that someone is working on a sweet service for handling the whole chain of accepting payments online that works outside the US. A part from recurring billing and one time charges I also want to be able to do metered billing (the customer pays for usage). 

The solution with Chargify, QuickPay and Euroline should work good but there are a bit of paper work and research needed to get it up and running. It should be as easy as signing up for one web service, setup how you want the money transferred to you and start integrating with the service API. I would be so happy to pay for that service.
