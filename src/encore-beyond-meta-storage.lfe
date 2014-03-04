(defmodule encore-beyond-meta-storage
  (export all)
  (import
    (rename encore-beyond-storage
      ((read 2) storage-read)
      ((read-one 2) storage-read-one))))

(include-lib "include/data-records.lfe")

(defun read (key)
  (storage-read (table-name) key))

(defun read-one (key)
  (storage-read-one (table-name) key))

(defun start ()
  "Starts the mnesia application and creates a table for
  metadata. Currently, table is in-memory only.

  Returns 'ok."
  (: mnesia start)
  (let (((tuple atomic ok)
         (: mnesia create_table
           (table-name)
           '(#(attributes (key value)))))))
  'ok)

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
