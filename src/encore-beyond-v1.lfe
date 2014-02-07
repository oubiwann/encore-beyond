(defmodule encore-beyond-v1
  (export all))


(defun demo
  "If you'd like to see the the arg-data parameter printed out for any given
  dispatch below, simply comment it out. The lines that print to stdout
  are commented below in order to better assess perfmance when benchmarking.

  Note that some of the below are not actually supported by YAWS, but
  presented here for completeness. (In particular, TRACE and CONNECT are not
  supported.)"
  (('GET arg-data)
   ;(: io format '"Handling GET arg-data: ~p~n" (list arg-data))
   #(content
     "application/json"
     "{\"data\": \"Here, hazsomeGETdatuhz!\"}"))
  (('POST arg-data)
   ;(: io format '"Handling POST arg-data: ~p~n" (list arg-data))
   #(content
     "application/json"
     "{\"data\": \"YOU madesomePOSTdatuhz!\"}"))
  (('PUT arg-data)
   ;(: io format '"Handling PUT arg-data: ~p~n" (list arg-data))
   #(content
     "application/json"
     "{\"data\": \"YOU madesomePUTdatuhz!\"}"))
  (('DELETE arg-data)
   ;(: io format '"Handling DELETE arg-data: ~p~n" (list arg-data))
   #(content
     "application/json"
     "{\"data\": \"OHNOEZ! You byebyeddatuhzwithDELETE!\"}"))
  (('OPTIONS arg-data)
   ;(: io format '"Handling OPTIONS arg-data: ~p~n" (list arg-data))
   #(content
     "application/json"
     "{\"data\": \"Here, hazsomeOPTIONSdatuhz!\"}"))
  (('HEAD arg-data)
   ;(: io format '"Handling HEAD arg-data: ~p~n" (list arg-data))
   #(content
     "application/json"
     "{\"data\": \"Here, hazsomeHEADdatuhz!\"}"))
  (('PATCH arg-data)
   ;(: io format '"Handling PATCH arg-data: ~p~n" (list arg-data))
   #(content
     "application/json"
     "{\"data\": \"YOU madesomePATCHdatuhz!\"}"))
  (('CONNECT arg-data)
   ;(: io format '"Handling CONNECT arg-data: ~p~n" (list arg-data))
   #(content
     "application/json"
     "{\"data\": \"YOU madesomeCONNECTtyunz!\"}"))
  (('TRACE arg-data)
   ;(: io format '"Handling TRACE arg-data: ~p~n" (list arg-data))
   #(content
     "application/json"
     "{\"data\": \"YOU madesomeTRACEuhz!\"}"))
  ((method _)
   (: io format '"WTF is this verb?! ~p~n" (list method))
   #(content
      "application/json"
      "{\"error\": \"Y U NO GIVE GOOD VERB?!?!!\"}")))

(defun routes
  "REST API Routes"
  (('"/demo" method arg-data)
    (demo method arg-data))
  ((a b c)
    (: io format '"path-info: ~p method: ~p arg-data: ~p~n" (list a b c))
    #(content
      "application/json"
      "{\"error\": \"Unmatched route.\"}")))


(defun out (arg-data)
  "This is called by YAWS when the requested URL matches the URL specified in
  the YAWS config (see ./etc/yaws.conf) with the 'appmods' directive for the
  virtual host in question.

  In particular, this function is intended to handle all v1 traffic for this
  REST API."
  (: encore-beyond meta-out arg-data #'routes/3))
