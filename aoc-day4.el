;;
(setq day4part1tmp (with-temp-buffer
                     (progn (insert-file-contents "c:/lisp/aoc-2022/input04.txt")
                            (beginning-of-buffer)
                            (while (re-search-forward "-" nil t) 
                                   (replace-match " " nil t))
                            (beginning-of-buffer)
                            (while (re-search-forward "," nil t)
                                   (replace-match ")(" nil t))
                            (beginning-of-buffer)
                            (while (re-search-forward "^" nil t)
                                   (replace-match "((" nil t))
                            (beginning-of-buffer)
                            (while (re-search-forward "\n" nil t)
                                   (replace-match "))" nil t))
                            (beginning-of-buffer)
                            (insert "(")
                            (end-of-buffer)
                            (insert ")")
                            (search-backward "((" nil t)(replace-match "" nil t))
                     (cl-loop for item in (read (buffer-string)) collect (sort item #'bycar))))

(setq meetcrit (seq-filter (lambda (i) (and (>= (caar i) (caadr i)) (<= (cadar i) (cadadr i)))) day4part1tmp))

(setq aftertuplededuct (cl-loop for item in day4part1tmp collect (push (apply #'tuplededuct item) item)))
(setq day4part2tmp (seq-filter (lambda (i) (and (and (> (caar i) 0) (> (cadar i) 0)) (= (cadr (nth 1 i)) (car (nth 2 i))))) aftertuplededuct))

(setq fortest '())
(setq tuplededuct (seq-doseq (item day4part1tmp)
                                  (push (seq-mapn #'- (car item) (cadr item)) item)))

(setq meetcrit (seq-filter (lambda (i) (and (<= (caar i) 0) (>= (cadar i) 0))) aftertuplededuct))
(setq meetcrit (seq-filter (lambda (i) (and (>= (nth 0 i) 0) (<= (nth 1 i) 0))) fortest))

(defun bycar (1car 2car)
  (if (> (car 1car) (car 2car)) t))

(defun tuplededuct (1tup 2tup)
  (cl-values (- (car 2tup) (car 1tup)) (- (nth 1 2tup) (nth 1 1tup))))


