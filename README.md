What?
=====

A plugin for Oldskool that supports searching and rendering
results from a Google Custom Search engine using the REST
API

Google APIs only allow 100 queries a day for free so this is
quite limited but 100 should be enough for most people

Configuration?
--------------

In your _oldskool.yaml_ add the following:

   :google_api_key: YOUR_API_KEY

You can then create keywords that search specific search engines:

   :keywords:
   - :type: :gcse
     :cx: YOUR_GCSE_IDENTIFIER
     :keywords:
     - puppet

This creates a keyword _guk_ that will search your specific custom
search engine

Contact?
--------

R.I.Pienaar / rip@devco.net / @ripienaar / http://devco.net/
