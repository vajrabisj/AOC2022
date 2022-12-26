(defun cals-per-elf ()
  (with-temp-buffer
      (progn (insert "((")
             (insert-file-contents "c:/Lisp/aoc-2022/input01.txt")
             (while (re-search-forward "^$" nil t)
                    (replace-match ")(" nil nil))
             (end-of-buffer)(insert "))")
             (goto-char 0))
    (mapcar (lambda (food-carried)
              (cl-reduce #'+ food-carried))
            (read (current-buffer)))))

(defun aoc-day1-part1 ()
  (cl-reduce #'max
             (cals-per-elf)))
(defun aoc-day1-part1 ()
  (cl-reduce #'+
             (seq-take (cl-sort (cals-per-elf)
                                #'>)
                       3)))
