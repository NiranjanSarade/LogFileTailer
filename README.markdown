LogFileTailer
=============

This is a simple sinatra app to monitor your log file. You can do a healthcheck such as whether the log file
is updated in last two hours or not (if you are expecting a scheduled job to update your log file with some
logger statements). You can view the the last 15 lines (unix tail) of the log file by default. You can also
view the last 'n' number of lines supplied as a parameter.
***

Prerequisites
=============

sinatra (1.2.3)  

file-tail (1.0.5)
***

Description
============

A sample log file is provided to let you know how this works.
You can run this as a pure rack application as 

`rackup config.ru`

The things that you can check as :-

>http://localhost:9292/
>http://localhost:9292/healthcheck
>http://localhost:9292/tail
>http://localhost:9292/tail/20




