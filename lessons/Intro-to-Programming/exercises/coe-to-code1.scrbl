#lang curr/lib

@(define exprs '((- (+ 17 16) (* 13 17))
                 (+ (* 12 5) 24)
                 (- (* 4 13) (- 19 21))
                 (- 21 (* 4 13))
                 (- (- 19 9) (* (+ 10 9) -3))
                 (* 1 (* 21 10))
                 (- (* 17 (* 5 5)) 4)))

@(define exprs-as-coe (map sexp->coe exprs))
@(define exprs-as-code (map sexp->code exprs))

@(exercise-handout 
  #:title "Converting Circles of Evaluation to Code"
  #:instr "For each Circle of Evaluation on the left-hand side, write the code
           for the Circle on the right-hand side:" 
  #:forevidence "A-SSE.1-2&1&3"
  @(create-exercise-itemlist #:with-answer-blanks? #t #:large-blanks? #t exprs-as-coe)
  @(exercise-answers
    (create-exercise-sols-itemlist exprs-as-coe exprs-as-code))
  )
