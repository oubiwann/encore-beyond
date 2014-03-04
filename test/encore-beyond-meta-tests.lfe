(defmodule encore-beyond-meta-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))
    (from encore-beyond-meta
      (dispatch 3))
    (from encore-beyond-util
      (make-result-error 0)
      (make-result-not-found 0)
      (make-result-ok 1))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/data-records.lfe")

(deftest dispatch-with-get
  (: meck new 'encore-beyond-meta-storage)
  (: meck expect 'encore-beyond-meta-storage 'read-one 1
     (tuple 'ok (metadata-record 'my-key 'my-value)))
  (try
    (let ((response (make-result-ok 'my-value)))
      (is-equal response (dispatch 'GET 'path 'arg-data)))
    (after
      (: meck validate 'encore-beyond-meta-storage)
      (: meck unload 'encore-beyond-meta-storage))))

(deftest dispatch-with-get-not-found
  (: meck new 'encore-beyond-meta-storage)
  (: meck expect 'encore-beyond-meta-storage 'read-one 1
     (tuple 'ok 'undefined))
  (try
    (let ((response (make-result-not-found)))
      (is-equal response (dispatch 'GET 'path 'arg-data)))
    (after
      (: meck validate 'encore-beyond-meta-storage)
      (: meck unload 'encore-beyond-meta-storage))))

(deftest dispatch-with-get-error
  (: meck new 'encore-beyond-meta-storage)
  (: meck expect 'encore-beyond-meta-storage 'read-one 1
     (tuple 'error 'my-error))
  (try
    (let ((response (make-result-error)))
      (is-equal response (dispatch 'GET 'path 'arg-data)))
    (after
      (: meck validate 'encore-beyond-meta-storage)
      (: meck unload 'encore-beyond-meta-storage))))

(defun metadata-record (key-data value-data)
  (make-metadata key key-data value value-data))