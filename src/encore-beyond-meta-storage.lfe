(defmodule encore-beyond-meta-storage
  (export all))

(include-lib "include/data-records.lfe")

(defun start ()
  "Starts the mnesia application and creates a table for
  metadata. Currently, table is in-memory only.

  Returns 'ok."
  (: mnesia start)
  (let (((tuple atomic ok)
         (: mnesia create_table (table-name) '(#(attributes (key value)))))))
  'ok)

(defun read (key)
  "This function takes a key and returns a record if it is
  stored in Mnesia. This wraps mnesia:dirty_read/1 which
  is 10x faster than running in a transaction. A
  transaction would protect from concurrency concerns.

  Any search that fails to return a record will return 'undefined

  Any search that raises an error wil return:
  #(aborted #(no_exists (metadata, key)))"
  (let ((response (: mnesia dirty_read (tuple (table-name) key))))
    (case response
      (() `#(error #(not-found ,key)))
      (_ response))))

(defun table-name ()
  'metadata)

(defun write (key-data value-data)
  "This function takes a key and value as arguments. The key
  and value are used to make a record and store it in
  Mnesia via a transaction.

  The function returns #(atomic ok)."
  (: mnesia transaction
    (lambda ()
      (let ((metadata (make-metadata key key-data value value-data)))
        (: mnesia write metadata)))))

;; > (: mnesia dirty_read (tuple 'metadata 'my_key))
;; (#(metadata my_key my-value))