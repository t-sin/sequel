(defpackage #:sequel
  (:use #:cl)
  (:export #:generate))
(in-package #:sequel)

(defun generate-comment (c)
  (format *standard-output* "~%%")
  (if (eq (car c) :comment)
      (format *standard-output* " ~a" (cadr c))
      (progn
        (format *standard-output* "%")
        (format *standard-output* "~a" (car c))
        (format *standard-output* "~s" (cdr c))))
  (format *standard-output* "~%"))

(defun generate-string (s)
  (format *standard-output* "(")
  (loop
    :for c :across s
    :do (cond ((member c '(#\( #\)) :test #'char=)
               (format *standard-output* "\\~c" c))
              ((char= c #\newline)
               (format *standard-output* "\\n"))
              (t (format *standard-output* "~a" c))))
  (format *standard-output* ")"))

(defun generate-name (k)
  (format *standard-output* "/")
  (format *standard-output* "~(~a~)" k))

(defun generate (code)
  (format *standard-output* "%!~%")
  (macrolet ((with-space (&body body)
               `(progn ,@body (unless (null rest) (format *standard-output* " ")))))
    (loop
      :for (c . rest) :on code
      :do (typecase c
            (list (generate-comment c))
            (keyword (with-space (generate-name c)))
            (symbol (with-space (format *standard-output* "~(~a~)" c)))
            (number (with-space (format *standard-output* "~a" c)))
            (string (with-space (generate-string c)))
            (t (error (format nil "code ~s is not a valid code." c))))
      :finally (format *standard-output* "~%"))))