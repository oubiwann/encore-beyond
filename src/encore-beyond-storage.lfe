(defmodule encore-beyond-storage
  (export all)
  (import
    (rename mnesia
      ((dirty_read 1) storage-dirty-read))))

(defun read-one (table-name key)
  "Returns the 1st item from the list of results. When the list is empty,
   this will return the atom 'undefined. See read/2 for further details."

  (let ((result (read table-name key)))
    (case result
      ((tuple 'ok _)
        (let (((tuple 'ok records) result))
          (case (: erlang length records)
            (0 (tuple 'ok 'undefined))
            (_ (tuple 'ok (car records))))))
      ((tuple 'error _) result))))

(defun read (table-name key)
  "This function takes a table & key. It returns a record if it is
  stored in Mnesia. This wraps mnesia:dirty_read/1 which
  is 10x faster than running in a transaction. A
  transaction would protect from concurrency concerns."

  (let ((result (storage-dirty-read (tuple table-name key))))
    (case result
      ((tuple 'aborted _)
         (tuple 'error result))
      (_
         (tuple 'ok result)))))
