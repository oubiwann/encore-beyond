(defmodule encore-beyond-persist-meta
  (export all))

(defrecord metadata key value)

(defun start
  ;; (: mnesia create_schema (list (node))) ;; unnecessary for local dev
  (: mnesia start)
  (let (((tuple atomic ok)
         (: mnesia create_table 'metadata '(#(attributes (key value))))))))

;; pattern match 'ok
(defun ensure-loaded
  ((: mnesia wait-for-tables '([metadata], infinity))))

;; lifted from lfe examples, yet fails to compile
(defun persist key value
  (match-lambda
    ([(tuple k v)]
     (: mnesia transaction
       (lambda ()
         (let ((new (make-metadata key k value v)))
           (: mnesia write new)))))))