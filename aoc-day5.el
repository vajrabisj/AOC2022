;;move 2 from 8 to 1 => (dotimes (i 2) (push (pop from8) from1))
(with-temp-buffer
    (progn (insert-file-contents "c:/lisp/aoc-2022/input05.txt")
           (beginning-of-buffer)
           (while (re-search-forward "move" nil t) 
                  (replace-match "(dotimes (i" nil t))
           (end-of-buffer)
           (while (re-search-backward " from " nil t)
                  (replace-match ") (push (pop from" nil t))
           (beginning-of-buffer)
           (while (re-search-forward " to " nil t)
                  (replace-match ") from" nil t))
           (end-of-buffer)
           (while (re-search-backward "\n" nil t)
                  (insert "))")) ;;use insert here to keep the \n so the file contains list of line of lisp expression that to be loaded/evaluated
           (write-file "c:/Lisp/aoc-2022/temp05.txt" t)))

(setq from1 '(B V W T Q N H D) from2 '(B W D) from3 '(C J W Q S T) from4 '(P T Z N R J F) from5 '(T S M J V P G) from6 '(N T F W B) from7 '(N V H F Q D L B) from8 '(R F P H) from9 '(H P N L B M S Z))

(load "c:/Lisp/aoc-2022/temp05.txt") ;;eval the whole file which is list of expression

(setq all9 (list from1 from2 from3 from4 from5 from6 from7 from8 from9))

(apply #'concat (mapcar #'symbol-name (mapcar #'car all9)))


;;move 2 from 8 to 1 => 2 from8 from1 => from1 from8 2 => (mapcar (lambda (i) (push i from1)) (seq-reverse (seq-take from8 2)))
(setq day5part2tmp (with-temp-buffer
                       (insert-file-contents "c:/lisp/aoc-2022/input05.txt")
                     (beginning-of-buffer)
                     (while (re-search-forward "move " nil t) 
                            (replace-match "(" nil t))
                     (end-of-buffer)
                     (while (re-search-backward "from " nil t)
                            (replace-match "from" nil t))
                     (beginning-of-buffer)
                     (while (re-search-forward "to " nil t)
                            (replace-match "from" nil t))
                     (end-of-buffer)
                     (while (re-search-backward "\n" nil t)
                            (insert ")")) ;;use insert here to keep the \n so the file contains list of line of lisp expression that to be loaded/evaluated
                     (let ((toreverse (split-string (buffer-substring (point-min) (point-max)) "\n"))(tocollect '())) ;;to convert the buffer contents into list
                       (cl-dotimes (i 501) (push (read (nth i toreverse)) tocollect)) ;;total length need to resolve
                       (seq-reverse (mapcar #'seq-reverse tocollect))
                       )))

(setq from1 '(B V W T Q N H D) from2 '(B W D) from3 '(C J W Q S T) from4 '(P T Z N R J F) from5 '(T S M J V P G) from6 '(N T F W B) from7 '(N V H F Q D L B) from8 '(R F P H) from9 '(H P N L B M S Z))

(setq day5part2exp (cl-loop for item in day5part2tmp do
                            (mapcar (lambda (i) (push i (symbol-value (nth 0 item)))) (seq-reverse (seq-take (symbol-value (nth 1 item)) (nth 2 item))))
                            (set (nth 1 item) (seq-drop (symbol-value (nth 1 item)) (nth 2 item))))) ;;use set to update the list

(setq all9 (list from1 from2 from3 from4 from5 from6 from7 from8 from9))
(apply #'concat (mapcar #'symbol-name (mapcar #'car all9)))
