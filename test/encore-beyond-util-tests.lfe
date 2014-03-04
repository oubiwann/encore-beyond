(defmodule encore-beyond-util-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))
    (from encore-beyond-util
      (make-json-content 1)
      (make-json-result 1)
      (make-result 2)
      (make-result-created 0)
      (make-result-error 0)
      (make-result-not-found 0)
      (make-result-ok 0)
      (make-result-ok 1))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")

(deftest make-json-content
  (is-equal
    #(content "application/json" "forty-two")
    (make-json-content '"forty-two")))

(deftest make-json-result
  (is-equal
    #(content "application/json" "{\"result\": forty-two}")
    (make-json-result '"forty-two")))

(deftest make-result-created
  (is-equal
    (make-result 201 (make-json-result '"\"created\""))
    (make-result-created)))

(deftest make-result-error
  (is-equal
    (make-result 500 (make-json-result '"\"error\""))
    (make-result-error)))

(deftest make-result-not-found
  (is-equal
    (make-result 404 (make-json-result '"\"not found\""))
    (make-result-not-found)))

(deftest make-result-ok
  (is-equal
    (make-result 200 (make-json-result '"\"ok\""))
    (make-result-ok)))

(deftest make-result-ok-with-body
  (is-equal
    (make-result 200 (make-json-content '"{\"key\": \"value\"}"))
    (make-result-ok '"{\"key\": \"value\"}")))

(deftest make-result
  (is-equal
   '(#(status 200) #(content "application/json" "{\"result\": \"ok\"}"))
    (make-result 200 #(content "application/json" "{\"result\": \"ok\"}"))))
