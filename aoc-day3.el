;;a 1 97
;;A 27 65

(setq day3part1tmp (with-temp-buffer
                       (progn (insert-file-contents "c:/lisp/aoc-2022/input03.txt")
                              (beginning-of-buffer)
                              (insert "(")
                              (end-of-buffer)
                              (insert ")")
                              (let ((charlist (mapcar #'symbol-name (read (buffer-string))))) ;;use the symbole-name to turn each symbole into string, and read can turn the buffer-string into sequence/list
                                (cl-loop for tchars in charlist
                                         collect (half-split-str tchars) into newcharlist
                                         finally (return newcharlist))))))


(setq day3part1 (cl-reduce #'+ (mapcar (lambda (charcode)
                                         (if (and (<= charcode 90) (>= charcode 65))
                                             (- charcode 38)
                                             (- charcode 96))) (mapcar #'car (cl-loop for item in day3part1tmp
                                                                                      collect (apply #'seq-intersection item)))))) ;;seq-intersection can only take two arguments but it's ok to use it here



(defun half-split-str (astr)
  (let ((halflen (/ (length astr) 2)) (fulllen (length astr)))
    (cl-values (substring astr 0 halflen) (substring astr halflen fulllen))))


(defun every-three (astrlist)
  (let ((strlen (/ (length astrlist) 3)))
    (dotimes (i strlen)
      (add-to-list 'day3part2allthree (append (seq-take astrlist 3)))
      (setq astrlist (seq-drop astrlist 3))))) ;;my re-write, but the elisp already have (seq-partition) function

(setq day3part2tmp (with-temp-buffer
                     (progn (insert-file-contents "c:/lisp/aoc-2022/input03.txt")
                            (beginning-of-buffer)
                            (insert "(")
                            (end-of-buffer)
                            (insert ")")
                            (mapcar #'symbol-name (read (buffer-string))))))

(setq day3part2allthree (seq-partition day3part2tmp 3))

(setq interres '()) ;;variable to accumulate the intersection of every three elements
(defun intersecthree (tlist)
  (let ((case-fold-search nil)(intertmp '())) ;;case-fold-search is critical which tell the search to be case sensitive
    (seq-doseq (c (car tlist))
               (when (string-match (char-to-string c) (nth 1 tlist)) ;;compare and get the intersection of first two elements
                 (add-to-list 'intertmp (char-to-string c)))) ;;add-to-list will not accept duplicate element, it's right to use here
    (seq-doseq (c intertmp)
               (when (string-match c (nth 2 tlist)) ;;compare the result of previous and compare with the third element to get the final intersection.
                 (push c interres))))) ;;push accept duplicate element, it's also right to use here, otherwise the total number of element is not tied. 

(mapcar #'intersecthree day3part2allthree)
(cl-reduce #'+ (mapcar (lambda (charcode)
                         (if (and (<= charcode 90) (>= charcode 65))
                             (- charcode 38)
                             (- charcode 96))) (mapcar #'string-to-char interres))) ;;use string-to-char to get the int char code
