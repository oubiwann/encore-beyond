(defmodule encore-beyond-meta
  (export all))

(include-lib "include/data-records.lfe")

(defun dispatch
  "This is called by Yaws to determine and render a response."
  (('GET path arg-data)
   (let ((result (car (: encore-beyond-meta-storage read path))))
     (if (is-metadata result)
       (let ((value (metadata-value result)))
         `#(content "application/json" ,value))
       #(content "application/json" "{\"result\": \"not_found\"}"))))

  (('PUT path arg-data)
   (let ((key path)
         (value (binary_to_list (: erlang element 7 arg-data))))
     (let ((result (: encore-beyond-meta-storage write key value)))
       (case result
         ((tuple atomic ok) #(content "application/json" "{\"result\": \"ok\"}"))
         (_ #(content "application/json" "{\"result\": \"fail\"}")))))))