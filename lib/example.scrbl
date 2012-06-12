#lang curr/lib
@(require racket/bool)
@title{Example}

@; Note: this document can be generated in different contexts.
@;
@; E.g.:    $ SCRIBBLE_TAGS=student scribble example.scrbl
@;      vs  $ SCRIBBLE_TAGS=teacher scribble example.scrbl
@;      vs  $ SCRIBBLE_TAGS="student teacher" scribble example.scrbl


@declare-tags[student teacher robot]

@declare-data-repository["bootstrap-data-repository.hashcollision.org"]



@image["bootstrap.gif"]


@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@section{Conditional output}
Untagged content shows for everyone.

@tag[student]{
@subsection{For students}
This is a message that a stupendous student should be able to see.
}

@student{For syntactic convenience, each tag itself is bound to a form that does
the exclusion, like this.}





@tag[teacher]{
@subsection{For teachers}
This is a message that a terrific teacher can take in.
}

@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@tag[(student teacher)]{
@subsection{For either students or teachers}
This is a message that either a student or teacher can see.
A robot would not see this message, however.
}

@tag[teacher]{
    @tag[student]{
        @subsection{Only when both teacher and student tags are enabled}
        Hello world.
    }
}
@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


@section{Fill in the blank}

Here is a fill-in-the-blank: @fill-in-the-blank[#:id "first-example"].

And another: @fill-in-the-blank[#:id "first-name"
                                #:label "First name"
                                #:columns 90]
@fill-in-the-blank[#:id "last-name"
                                #:label "Last name"
                                #:columns 90].



@section{Free response}
This is a free-response: @free-response[#:id "mytext"].




@section{Embedded wescheme}
This is an embedded-wescheme instance:
@embedded-wescheme[#:id "example1"
                   #:public-id "champ-neigh-stoop-sinew-overt"
                   #:width "70%"]


Here is another one:
@embedded-wescheme[#:id "example3"
                   #:interactions-text "(+ 1 2 3)"
                   #:hide-header? #t
                   #:hide-footer? #t
                   #:hide-definitions? #t]



@worksheet{
  This is an example of a worksheet.  It's a section of the document.

  What do you see here?
}




@worksheet{
  This is an example of another worksheet.

  @materials[
    @item{Rock}
    @item{Paper}
    @item{Scissors}
  ]

  @row[#:count 5]{@(number->string (add1 (current-row)))
                  @fill-in-the-blank[#:id "name" #:label "name"] 
                  @fill-in-the-blank[#:id "contract" #:label "contract"]
                 }

}



@goals[
@item{Plant a flower}
@item{Pack suitcase}
@item{Go home}
]

@; new things added 

@;adds an overview section
@;it is formatted to take all elements, so it can absorb the entire review page (@materials, etc)
@overview{This is an overviewwwwwwwwwww
          
          @materials[@item{pencils}]}


@;auto generates all copyright text
@copyright{}


@;contract-exercise -> creates a contract exercise with three fill in the blanks
@;requires a tag, to make unique, use lesson number then problem number (lesson one
@; problem two = "12". must be a string
@(contract-exercise "anything")
@(contract-exercise "anything1")
@(contract-exercise "anything2")

@;examples: cond? tag -> creates an example like in section 2 of design recipe worksheets
@; cond? - whether the example is for a conditional or not (the text differs)
@; tag - a unique string, use the unit number and problem (unit 1 problem 2 goes to 12)
@(example true "13")
@(example false "09")