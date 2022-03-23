(define (domain project)
(:requirements :strips :equality :typing)

(:types
    room zone corridor - location
    door
    elevator
)

(:predicates 
  (at ?l - location) 
  (in ?l1 ?l2 - location)
  (connected ?l1 ?l2 - location ?d - door)
  (open ?d - door)
  (close ?d - door)

  ;;(at-obj ?o - obj ?l - location)
)

(:constants None - door)

(:action move
  :parameters (?from ?to - location ?door - door)
  :precondition 
    (and 
      (at ?from)
      (connected ?from ?to ?door)  
      (open ?door)
    )
  :effect 
    (and 
      (at ?to)
      (not (at ?from)))
    )

(:action move-to-zone
  :parameters (?room - room ?zone - zone)
  :precondition 
    (and 
      (at ?room)
      (in ?room ?zone)  
    )
  :effect 
    (and 
      (at ?zone)
      (not (at ?room)))
    )

(:action leave-zone
  :parameters (?room - room ?zone - zone)
  :precondition 
    (and 
      (at ?zone)
      (in ?zone ?room)  
    )
  :effect 
    (and 
      (at ?room)
      (not (at ?zone)))
    )

(:action open-door
    :parameters (?from ?to - location ?door - door)
    :precondition 
    (and 
      (at ?from)
      (close ?door)
      (connected ?from ?to ?door)
    )
    :effect 
    (and
      (open ?door) 
    )
)
)
