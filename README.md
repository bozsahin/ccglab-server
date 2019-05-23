# ccglab-server
This is going to be an interface to CCGlab from browsers.

I have given up on the idea of using Allegro CL and native AllegroServe for this task, because Allegro is
so cryptic about garbage-collection you avoid using it and end up garbage collecting all the time.

So, it's going to be SBCL (once again) running Portable AllegroServe, and no Allegro CL in between.

Soon.
