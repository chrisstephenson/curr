#lang curr/lib
@declare-tags[]

@title{Unit 3: Structures, Reactors, and Animations}

@unit-overview/auto[#:lang-table (list (list "Number" @code{+ - * / num-sqr num-sqrt num-expt})
                                       (list "String" @code{string-append string-length})
                                       (list "Image"  @code{rectangle circle triangle ellipse star text scale rotate put-image})
                                       (list "Cake" @code{cake .flavor .color .message .layers .is-iceCream}))]{

@unit-descr{Students, having worked with pre-made data structures in the last lesson (Cakes), generalize their understanding by defining more data structures of their own, accessing their fields, and writing functions that produce them. 
}
}
@unit-lessons{
@lesson/studteach[#:title "Animations in Pyret (still need to fix lesson metadata)"
        #:duration "10 minutes"
        #:overview ""
         #:learning-objectives @itemlist[@item{Write complex functions that consume, modify and produce structures}
            @item{Deepen their understanding of structures, constructors and accessors by being introduced to a new data structure.}]
        #:evidence-statements @itemlist[]
        #:product-outcomes @itemlist[@item{Students define a new data structure: a party }]
        #:standards (list "N-Q" "F-IF.1-3" "BS-M" "BS-IDE" "BS-PL.1" "BS-DS.1" "BS-DS.2")
        #:materials @itemlist[@item{The @editor-link[#:public-id "0B9rKDmABYlJVUUt1SUc5UnVsdm8" "Party Planner"] file preloaded on students' machines}
                              @item{Pens/pencils for the students, fresh whiteboard markers for teachers}
                            @item{Class poster (List of rules, design recipe, course calendar)}
                            @item{Editing environment (Pyret Editor)}
                            @item{Language Table}]
     #:preparation @itemlist[@item{Seating arrangements: ideally clusters of desks/tables}]
     #:pacings (list 
                @pacing[#:type "remediation"]{@itemlist[@item{}]}
                @pacing[#:type "misconception"]{@itemlist[@item{}]}
                @pacing[#:type "challenge"]{@itemlist[@item{}]}
                )
      ]{
        @points[
	
	@point{@student{You've learned how to create data structures, and how to create images. Now it's time to put these together to create an animation in Pyret.  We'll even go a step further than what we did in Bootstrap:1, creating an animation with movement in two dimensions.}
	       @teacher{}}
	@point{@student{In Bootstrap:1, many decisions about your animation were made for you. We told you how many characters you had and which aspects of them could change during the animation.  The danger always moved in the x-axis, the player always moved in the y-axis.  In Bootstrap:2, we give you much more control of your game: you decide how many characters you will have, and what aspects of them can change (position, color, size, etc).  In order to have this flexibility, we need to do a little more work to set up the animation.  Let's break down an animation to see what we need.}
	       @teacher{}}
	@point{@student{Let's create an animation of a sunset.  The sun will start at the top-left corner of the screen and fall diagonally down and right across the sky. Here's a running version of the animation we are trying to create:
	                @bannerline{@animated-gif{images/sunset.gif}}
	                In Bootstrap:1, we talked about how an animation is made of a sequence of images that we flip through quickly.
                        We continue to think of an animation as a sequence of images in Bootstrap:2. For example, here are the first three frames of the sunset
			animation:
			 @bannerline{@bitmap{images/first-three-sunset-frames.png}}
			}
	       @teacher{}
	       }
	@point{@student{Where will we get this sequence of images? We don't want to create them all by hand.
			Instead, we want to write programs that will create them for us.
                        This is the power of computer programming.  It can automate tasks (like creating
			new images) that might otherwise be tedious for people to do. There are four steps to creating
			animations programs.  You've actually already done the first three in the first two units, but
			now we need to show you how to put them together.}
	       @teacher{This is a key point at which to emphasize why functions are important to computer science.
	       		Computers are good at repetition, but they need instructions
                        telling them what steps to repeat.  Functions capture those instructions.}
	       }
	@point{@student{The first step is to develop a data structure for the information that changes across frames.
			Look at our three sample images: what information
			is needed to create each frame image?  Which infomation is different across
			the frames?  What is the same? 
			@activity{Figure out the differences and write them down in [FILL PART]
			of the animation worksheet.}
			Hopefully, you identified two pieces of changing information: the x-coordinate of
			the sun and the y-coordinate of the sun. Each image also contains the horizon (the
			brown rectangle), but that is the same in every frame. Let's write down a data
			structure for this.
	                @activity{Create a data structure named @code{SunsetState} that holds the
				  x-coordinate of the sun and the y-coordinate of the sun.}
                        You should have come up with something like this: a data block with numbers for the two coordinates.
                @code[#:multi-line #t]{# a SunsetState has the x-coordinate of the sun and the y-coordinate of the sun
		      data SunsetState:
		       | sunset(
		           xpos :: Number,
			   ypos :: Number
			   )
		       end}
		       The term @vocab{state} is used in computer science to refer to the details of a program
		       at a specific point in time.  Here, we use it to refer to the details that are unique to
		       a single frame of the animation.
		  }
		@teacher{We are adopting a convention here, in which we include "State" in the name of the data block,
			 then use the same base name (without "State") for the constructor.
                         By not conflating the names here, students should have an easier time distinguishing between
			 the constructor name and data structure name.}
		}
	@point{@student{Any time we make a data structure, we should make some sample instances: this helps check
			that we have the right fields and gives us data to use in making examples later.
			@activity{In the worksheet,
			write down the @code{sunset} instances under each frame. The first one is at coordinate (10, 300),
			the second is at (18, 292), and the third is at (26, 284).}
	                }
   	       @teacher{}}
     	@point{@student{The second step in making an animation is to write a function that consumes an instance of one state
	                and produces the image for that instance. For sunset, we want to write a function named @code{draw-state}
			that consumes a @emph{SunsetState} instance and produces an image with the sun at that location
			over the horizon. This function should use @code{put-image}, as we did with the hikers in unit 1.
			@activity{Go to @worksheet-link[#:name "next-position"] in your workbook and develop the @code{draw-state} function
			          described there. Type in your function and use it to draw several individual sunset frames.}
			}
			
	       @teacher{You may have noticed that we used @code{SunsetState} instead of @code{sunset} as the domain name.
	                Remember that @code{sunset} is just the name of the constructor, while @code{SunsetState} is the
			name of the type.  We use @code{SunsetState} whenever we need a type name for the domain or range.}}

     	@point{@student{We can now draw one frame, but an animation needs many frames. How can we draw multiple frames?
	                Let's simply the problem a bit: if you have the instance for one frame, how do we compute the instance
			for the next frame?  Note we didn't ask how to produce the @emph{image} for the next frame. We only asked
			how to produce the next @code{SunsetState} instance.  Why?  We just wrote @code{draw-state}, which
			produces the image from a @code{SunsetState}.  So if we can produce the instance for the next
			frame, we can use @code{draw-state} to get the image.}
	       @teacher{Separating the instance from the image of it is key here: when we produce an animation, we actually
	                produce a sequence of instances, and use @code{draw-state} to produce each one.  Students may
			need some practice to think of the instance as separate from the image that goes into the animation.}}
     	@point{@student{The third step in making an animation is to write a function that consumes an instance of one state
	                and produces the instance for the next state. For sunset, we want to write a function named
			@code{next-state-tick} that consumes a @emph{SunsetState} instance and produces a @emph{SunsetState}
			instance that is just a little lower in the sky.
			@activity{Go to page [FILL] in your workbook and develop the @code{next-state-tick} function
				  described there. Use the sample @code{SunsetState} instances that you developed in
				  step 1 as you make your examples of the function. Type in your code and make sure
				  your examples are producing the expected answers.}
			}
	       @teacher{}}
	       
     	@point{@student{Together, the @code{draw-state} and @code{next-state-tick} give us the building blocks for an
	                animation. To start to see how, let's first use these two functions to create the first
			several frames of an animation by hand (then we'll show you how to make more frames automatically).
			@activity{Run each of the following expressions in the interactions window in turn. Just copy and
			          paste them, rather than type them by hand each time:
				  @itemlist[
				  @item{@code{draw-state(sunset(10,300))}}
				  @item{@code{next-state-tick(sunset(10,300))}}
				  ]
				  Now use @code{draw-state} on the result of @code{next-state-tick}, then call
				  @code{next-state-tick} again:
				  @itemlist[
				  @item{@code{draw-state(sunset(18,296))}}
				  @item{@code{next-state-tick(sunset(18,296))}}
				  @item{@code{draw-state(sunset(26,292))}}
				  @item{@code{next-state-tick(sunset(26,292))}}
				  ]}
		          Do you see the sun getting lower in the sky from image to image?
			  Do you see how we are creating a "chain" of images by alternating calls
			  to @code{draw-state} and @code{next-state-tick}? We use @code{next-state-tick} to
			  create the instance for a new frame, then use @code{draw-state} to produce the image
			  for that frame.
			
			@activity{(Optional) Here's another way to see the same sequence of expressions. Run each of the
			          following expressions in the interactions window in turn. Just copy and 
			          paste them, rather than type them by hand each time:
				  @itemlist[
				  @item{@code{draw-state(sunset(10,300))}}
				  @item{@code{draw-state(next-state-tick(sunset(10,300)))}}
				  @item{@code{draw-state(next-state-tick(next-state-tick(sunset(10,300))))}}
				  @item{@code{draw-state(next-state-tick(next-state-tick(next-state-tick(sunset(10,300)))))}}
				  ]}
		        Do you see what this sequence
			of expressions does? Each one starts with the sun in the upper-left corner, calls
			@code{next-state-tick} one or more times to compute a new position for the sun, then draws the state.
			Notice that this sequence only has us write down one @code{SunsetState} instance
			explicitly (the first one).  All the others are computed from @code{next-state-tick}.
			If we could only get Pyret to keep making these calls for us, and to show us the images
			quickly one after the next, we'd have an animation!
			}
	       @teacher{These sequences show students how the two functions work together to create an animation.
	       If you feel the second one that composes @code{next-state-tick} with itself many times is too
	       complicated for your students, you can skip it. The goal of the second sequence is to show that we
	       only need an initial instance and the two functions to generate a sequence of images that make
	       up an animation.}}

        @point{@student{The fourth (and final) step in making an animation is to tell Pyret to create an
	 		animation using an initial @code{SunsetState} instance and our @code{draw-state} and
			@code{next-state-tick} functions. To do this, we need a new construct called a
			@vocab{reactor}. A reactor gathers up the information needed to create an animation.
			Here, we define a reactor named @code{r} for the sunset animation:
			@code[#:multi-line #t]{
                          r = reactor:
  			    init: sunset(10, 300),
			    on-tick: next-state-tick,
			    to-draw: draw-state	  
                          end}
			Each of @code{init:}, @code{on-tick:}, and @code{to-draw:} names a piece of information needed
			to make an animation.  We supply the instances and functions for each piece. For example,
			this reactor says to use our @code{draw-state} 
			function whenever the reactor needs "to draw" a new image.  It says to use our
			@code{next-state-tick} to create a new instance of the animation state between frames. The
			instance marked @code{init} tells the reactor where the sun should start at the beginning of the
			animation.
			@activity{Copy this reactor definition into your sunset animation program.}
			}
	       @teacher{The reactor is new to Bootstrap:2. In Bootstrap:1, the reactor was built into each teachpack so
	                you didn't see it.  We could do that because we fixed the contents of the state data structure
			(a target moving in the x-coordinate, a player moving in the y-coordinate, etc) and the names
			of all the functions.  In Bootstrap:2, however, you get to customize these; in exchange, you
			have to write the reactor expression yourself. In each line, the contents to the left of the colon
			are fixed.  You tailor the instance and function names to the right of each colon.
	       
	        	If you happen to know the term "handler" from other programming experience (we don't expect you to!),
	                a reactor expression specifies handlers to use for various tasks.}}

     	@point{@student{If you run your sunset program after adding the reactor, nothing seems to happen. We have set
			up an animation by defining @code{r}, but we haven't told Pyret to run it.  You could define
			multiple reactors in the same file, so we have to tell Pyret explicitly when we want to run one.
			@activity{Type @code{interact(r)} in the interactions window to run your sunset animation.}
			}
	       @teacher{The Bootstrap:1 teachpacks started the animation automatically.  In Bootstrap:2, you
	       		have to start the animation manually by calling @code{interact}.}}

        @point{@student{What happens when we call @code{interact}?  The following diagram summaries what Pyret does to
			run the animation. It
			draws the initial instance, then repeatedly calls @code{next-state-tick} and @code{draw-state} to
			create and display successive frames of your animation.  
			
 	                @bannerline{@bitmap{images/world-model.png}}

			These are the same computations you did by hand in the interactions window a little while
			ago, but Pyret now automates the cycle of generating and drawing instances.  By having
			functions that can generate instances and draw images, we can let the computer do the work of
			creating the full animation.}
               @teacher{This figure may be too complex for some students.  Hopefully it helps you, and perhaps them,
	                see how an animation arises from the two functions we've written in this lesson.}}
	@point{@student{Functions are essential to creating animations, because each frame comes from a different @code{SusetState}
			instance. The process of drawing each instance is the same, but the instance is different each time.
			Functions are computations that we want to perform many times.  In an animation, we perform
			the @code{draw-state}and @code{next-state-tick} functions once per frame.  Animations are an
			excellent illustration of why functions matter in programming.}
	       @teacher{Whether you are primarily teaching math or CS, helping students see the idea of functions and
	       		repeated computations is a key part of what Bootstrap tries to teach.  Animations are a powerful
			illustration of repeated computations that functions can capture naturally.}}
	@point{@student{Summarizing what we have seen so far, we have to write four things in order to make an animation:
                        @itemlist[#:style 'ordered
                           @item{Create a state structure to hold the information that changes across frames. This information is called the @vocab{state}.}
                           @item{Write a function to generate an image of the current state (we'll call this @code{draw-state}).}
                           @item{Write a function to generate a new state from a given state (we'll call this @code{next-state-tick}).}
                           @item{Define a reactor that will use an initial instance of the state and the two functions to create an animation.}
                        ]
                        }
               @teacher{}}
	       
	@point{@student{You have just seen the incredible power of functions in programming! Functions let us
	                @emph{generate content automatically}. In the early days of making cartoons,
                        artists drew every frame by hand.  They had to decide at the beginning how many frames
			to create. Here, we let the computer generate as many frames as we want,
                        by letting it call @code{next-state-tick} over and over until we stop the animation.
			If we want to slow down the sunset, we simply change the new coordinates
                        within @code{next-state-tick}.  If we start with a larger screen size, the computer
			will continue to generate as many images as we need to let the sun drop out of the window.
                        The computer can give us this flexibility as long as @italic{we provide a function that tells
			the computer how to generate another frame}.
	       }
	       @teacher{}}
	       ]
	       }
         
	       
@lesson/studteach[#:title "Designing Data Structures for Animations (metadata needs to be fixed)"
        #:duration "80 minutes"
        #:overview ""
        #:learning-objectives @itemlist[@item{Students will write complex functions that consume, modify and produce structures}]
        #:evidence-statements @itemlist[]
        #:product-outcomes @itemlist[@item{Students will write functions that access fields of a Cake, and produce new Cakes}]
        #:standards (list "7.EE.1-2" "F-IF.1-3" "A-CED.1-4" "BS-DR.1" "BS-DR.2" "BS-DR.3" "BS-DR.4" "BS-DS.1")
        #:materials @itemlist[@item{The  @editor-link[#:public-id "0B9rKDmABYlJVU2lINzk1X0x2ODg" "Bakery"] file used in the previous unit}]
        #:preparation @itemlist[]
        #:pacings (list 
                @pacing[#:type "remediation"]{@itemlist[@item{}]}
                @pacing[#:type "misconception"]{@itemlist[@item{}]}
                @pacing[#:type "challenge"]{@itemlist[@item{}]}
                )
      
      ]{
        @points[
      	@point{@student{You've learned the components of an animation in Pyret. The data structure for the state lies at the heart of the animation: each of the initial state, the @code{draw-state} function and the @code{next-state-tick} function are based on the data structure you choose. Being able to figure out the data structure you need for an animation is therefore a critical skills in making your own animations.  In this lesson, we are going to practice identifying the data and creating the data structures for various animations. We will not write the entire animation.  We are just going to practice identifying the data.}
	       @teacher{Figuring out the data structure is actually one of the most creative tasks in programming. More complex problems can be captured through multiple data structures. For example, we might have some information that could be computed from other information, so we have to decide what data to include and what to compute.  Or, we might want to combine multiple smaller data structures into a larger one, having a data structure for a coordinate (with both x- and y-positions), and a data structure for a character that has a coordinate and a color. We don't expect that you can envision all of these possibilities right now.  We do want you to be aware that students may come up with different ideas, and that this is appropriate and interesting at this stage.  Your students can have some valuable discussions about design once they start brainstorming different ways to organize data for a problem.}}
	@point{@student{@bold{Exercise: Jumping Cow} -- Look at this animation of a cow jumping over the moon.
	                @animated-gif{images/cowjump.gif} 
	                @activity{Go to page [FILL] in the workbook. Draw three frames from this animation.
				  Choose ones that highlight differences across the frames.
			          The frames don't need to be consecutive.}
			When you chose which frames to draw, did you include ones with different images or heights of the cow?
			Choosing images with some variation will help you think through the data in your animation.
			@activity{Fill in the table of what information changes across the frames.}
			In this case, the cow's x-coordinate and y-coordinate are both changing. The image changes too,
			but the position (coordinates) determines which image to use.  The state data structure therefore
			only needs to store the coordinates.
			@activity{Fill in the table of what fields you need for each piece of changing information.
			          Write a data structure @code{CowState} to capture the data in this animation.}
			}
	       @teacher{If students want to include the image in the state, that is fine too. Examples like this
	       		are good for raising discussion about what parts of an animation depend on one another.
			The image doesn't need to be in the state, but it isn't wrong to include it there either.}}
	       
	@point{@student{@bold{Exercise: Falling Person} -- Look at this animation of a person falling through the sky while two
			birds fly upwards.
	                @animated-gif{images/falling.gif} 
	                @activity{Go to page [FILL] in the workbook. Draw three frames from this animation.
				  Choose ones that highlight differences across the frames.
			          The frames don't need to be consecutive.}
			When you chose which frames to draw, did you include ones with the two birds different distances from each other?
			@activity{Fill in the table of what information changes across the frames.}
			In this case, there are five pieces of information: the y-coordinate of the person,
			the x- and y-coordinates of the first bird, and the x- and y-coordinates of the second bird.
			Do we really need the x-coordinates of the birds?  They only move in the y-axis, but once they go off screen,
			their x-coordinates can change for their next pass upward.  You only notice that the x-axis changes if you
			look at frames from multiple passes, rather than three consecutive frames.
			@activity{Fill in the table of what fields you need for each piece of changing information.
			          Write a data structure @code{FallingState} to capture the data in this animation.}
			}
	       @teacher{}}
	       
	 @point{@student{@bold{Exercise: Pulsing Star} -- Look at this animation of a star that pulses as it moves across the sky.
	                @animated-gif{images/pulsingstar.gif} 
	                @activity{Go to page [FILL] in the workbook. Draw three frames from this animation.
				  Choose ones that highlight differences across the frames.
			          The frames don't need to be consecutive.}

		        When you chose which frames to draw, did you show the star getting smaller and then getting larger again?

			@activity{Fill in the table of what information changes across the frames.}

			The x- and y-coordinates of the star change, as does the size of the star. These changes are easy to see across
			two frames. Something else changes too, but you have to look across at least three frames to see it. Imagine you
			had a single frame with the star at size 75. In the next frame, should the star be larger or smaller? It's hard
			to tell, because we don't know whether the star is currently in a "growing" phase or a "shrinking" one.  This
			animation actually has a fourth state field: the direction of growth of the star. When the star is getting bigger,
			the star's size should increase in the next frame. When the star is getting smaller, the size should decrease in
			the next frame.

			@activity{Fill in the table of what fields you need for each piece of changing information.
			          Write a data structure @code{StarState} to capture the data in this animation.}

		        What type did you choose for the field that tracks the direction of growth?  You have several choices: a boolean
			such as @code{is-growing}, a string such as @code{direction} (with values @code{"grow"} or @code{"shrink"}), or
			a number such @code{growth-rate} which is the amount to add to the size from state to state (a positive value
			grows the star while a negative value shrinks it).  The code for @code{next-state-tick} will be cleaner if you
			use the number, but the others make sense before you've thought ahead to the code.}
			
	       @teacher{The type for tracking direction of growth gives potential for a good discussion. None of these answers are
	                wrong.  If they were to use the boolean or the string, however, their @code{next-state-tick} function would
			need a conditional to decide whether to add or substract from the current size.  In this exercise, they
			aren't writing the animations, so this is less of an issue. Our real goal is to get them to imagine
			animations and to identify the state information that underlies each one.}
			}

	@point{@student{Light Dimmer -- point here is that two visual effects might be due to the same variable.}
	       @teacher{}}
	       
	@point{@student{For a real challenge, do single-paddle pong}
	       @teacher{}}
         ]}
       

@lesson/studteach[#:title "Closing"
        #:duration "5 minutes"
         #:overview ""
         #:learning-objectives @itemlist[]
         #:evidence-statements @itemlist[]
         #:product-outcomes @itemlist[]
         #:standards (list)
         #:materials @itemlist[]
         #:preparation @itemlist[]
         #:pacings (list 
                @pacing[#:type "remediation"]{@itemlist[@item{}]}
                @pacing[#:type "misconception"]{@itemlist[@item{}]}
                @pacing[#:type "challenge"]{@itemlist[@item{}]}
                )
      ]{
        @points[@point{@student{You've learned how to create an animation in Pyret. You saw how having control of drawing the state lets you create interesting effects like changing the color of the sun.  You've gotten a hint that you can make states with any information you want.  In upcoming lessons, we will make use of this to do even more interesting animations.}
                        @teacher{Have students volunteer what they learned in this lesson}}
                        
                        ]}

       
}

  

