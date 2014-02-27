(defmodule encore-beyond-meta
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
     "{\"data\": \"Yais, hazsomeGETdatuhz!\"}"))
  (('PUT path arg-data)
   (let ((key path)
         (value (binary_to_list (: erlang element 7 arg-data))))
     ;; (: io format '"Handling POST: ~p~n" (list arg-data))
     (let ((result (: encore-beyond-meta-storage write key value)))
       (case result
         ((tuple atomic ok) #(content "application/json" "{\"result\": \"ok\"}"))
         (_
          (: io format '"PUT result: ~p~n" (list result))
          #(content "application/json" "{\"result\": \"fail\"}")))))))