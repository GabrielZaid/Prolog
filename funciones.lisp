(deffunction factorial (?n)
  (if (<= ?n 1)
      1
      (* ?n (factorial (- ?n 1)))))


(deffunction fibonacci (?n)
  (if (<= ?n 1)
      ?n
      (+ (fibonacci (- ?n 1)) (fibonacci (- ?n 2)))))
