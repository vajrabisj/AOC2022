Rock 1
Pape 2
Sisc 3

(setq day2part1 (with-temp-buffer
                    (progn (insert-file-contents "c:/lisp/aoc-2022/input02.txt")
                           (beginning-of-buffer)
                           (while (re-search-forward "[AX]+" nil t) 
                                  (replace-match "1" nil t))
                           (beginning-of-buffer)
                           (while (re-search-forward "[BY]+" nil t) 
                                  (replace-match "2" nil t))
                           (beginning-of-buffer)
                           (while (re-search-forward "[CZ]+" nil t) 
                                  (replace-match "3" nil t))
                           (beginning-of-buffer)
                           (while (re-search-forward "\n" nil t)
                                  (replace-match ")(- " nil nil))
                           (end-of-buffer)(re-search-backward "(- " nil t)(replace-match ")" nil nil)
                           (goto-char 0)(insert "((- ")
                           (cl-loop for pair in (read (buffer-string)) 
                                    when (= (eval pair) 0)
                                    collect (+ 3 (nth 2 pair))
                                    when (= (eval pair) 2)
                                    collect (+ 6 (nth 2 pair))
                                    when (= (eval pair) -2)
                                    collect (nth 2 pair)
                                    when (= (eval pair) -1)
                                    collect (+ 6 (nth 2 pair))
                                    when (= (eval pair) 1)
                                    collect (nth 2 pair)
                                    ))))


(cl-reduce #'+ day2part1)

(setq day2part2tmp (with-temp-buffer
                    (progn (insert-file-contents "c:/lisp/aoc-2022/input02.txt")
                           (beginning-of-buffer)
                           (while (re-search-forward "A" nil t) 
                                  (replace-match "1" nil t))
                           (beginning-of-buffer)
                           (while (re-search-forward "B" nil t) 
                                  (replace-match "2" nil t))
                           (beginning-of-buffer)
                           (while (re-search-forward "C" nil t) 
                                  (replace-match "3" nil t))
                           (beginning-of-buffer)
                           (while (re-search-forward "\n" nil t)
                                  (replace-match ")(- " nil nil))
                           (end-of-buffer)(re-search-backward "(- " nil t)(replace-match ")" nil nil)
                           (goto-char 0)(insert "((- ")
                           (read (buffer-string)))))

(cl-loop for pair in day2part2tmp
         when (and (eq (nth 2 pair) 'X) (or (= (nth 1 pair) 3) (= (nth 1 pair) 2))) do
         (setf (nth 2 pair) (- (nth 1 pair) 1))
         when (and (eq (nth 2 pair) 'X) (= (nth 1 pair) 1)) do
         (setf (nth 2 pair) 3)
         when (eq (nth 2 pair) 'Y) do
         (setf (nth 2 pair) (nth 1 pair))
         when (and (eq (nth 2 pair) 'Z) (or (= (nth 1 pair) 1) (= (nth 1 pair) 2))) do
         (setf (nth 2 pair) (+ (nth 1 pair) 1))
         when (and (eq (nth 2 pair) 'Z) (= (nth 1 pair) 3)) do
         (setf (nth 2 pair) 1))


(setq day2part2 (cl-loop for pair in day2part2tmp 
                         when (= (eval pair) 0)
                         collect (+ 3 (nth 2 pair))
                         when (= (eval pair) 2)
                         collect (+ 6 (nth 2 pair))
                         when (= (eval pair) -2)
                         collect (nth 2 pair)
                         when (= (eval pair) -1)
                         collect (+ 6 (nth 2 pair))
                         when (= (eval pair) 1)
                         collect (nth 2 pair)
                         ))

(cl-reduce #'+ day2part2)
