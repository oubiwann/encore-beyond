(defmodule encore-beyond-schema
  (export all))


(defun dispatch
  "If you'd like to see the the arg-data parameter printed out for any given
  dispatch below, simply comment it out. The lines that print to stdout
  are commented below in order to better assess perfmance when benchmarking.

  Note that some of the below are not actually supported by YAWS, but
  presented here for completeness. (In particular, TRACE and CONNECT are not
  supported.)"
  (('GET path arg-data)
   #(content
     "application/json"
     "{\"data\": \"Here, hazsomeGETdatuhz!\"}")))
