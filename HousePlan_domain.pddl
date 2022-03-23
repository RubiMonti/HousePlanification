(define (domain robots-move)
(:requirements :strips :equality :typing)

(:types
  room corridor zone - location
  door free - connections
  robot
  object
  gripper
)

(:predicates 
  (robot_at ?r - robot ?l - location)
  (object_at ?o - object ?l - location)
  (gripper_free ?g - gripper)
  (gripper_at ?g - gripper ?r - robot)
  (robot_carry ?r - robot ?g - gripper ?o - object)
  (connected ?l1 ?l2 - location ?c - connection)
  (open ?d - door)
  (close ?d - door)
)

(:action open-door
  :parameters (?r - robot ?l1 ?l2 - location ?d - door)
  :precondition 
    (and 
      (robot_at ?r ?l1)
      (close ?d)
      (connected ?l1 ?l2 ?d)
    )
  :effect 
    (and 
      (open ?d)
      (not (close ?d))
    )
)

(:action close-door
  :parameters (?r - robot ?l1 ?l2 - location ?d - door)
  :precondition 
    (and 
      (robot_at ?r ?l1)
      (open ?d)
      (connected ?l1 ?l2 ?d)
    )
  :effect 
    (and 
      (close ?d)
      (not (open ?d))
    )
)

(:action move
  :parameters (?r - robot ?from ?to - location ?c - connection)
  :precondition 
    (and 
      (robot_at ?r ?from)
      (connected ?from ?to ?c)
      (open ?d) ;;!!
    )
  :effect 
    (and 
      (robot_at ?r ?to)
      (not (robot_at ?r ?from))
    )
)
(:action pick
  :parameters (?o - object ?l - location ?r - robot ?g - gripper)
  :precondition 
    (and
      (gripper_at ?g ?r)
      (object_at ?o ?l)
      (robot_at ?r ?l) 
      (gripper_free ?g)
    )
:effect 
  (and 
    (robot_carry ?r ?g ?o) 
    (not (object_at ?o ?l))
    (not (gripper_free ?g)))
  )

(:action drop
:parameters (?o - object ?l - location ?r - robot ?g - gripper)
:precondition 
  (and 
    (gripper_at ?g ?r)
    (robot_at ?r ?l)
    (robot_carry ?r ?g ?o)
  )
:effect 
  (and 
    (object_at ?o ?l)
    (gripper_free ?g)
    (not (robot_carry ?r ?g ?o))
  )
)
)