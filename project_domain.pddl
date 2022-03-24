(define (domain project)
(:requirements :strips :equality :typing)

(:types
    room zone corridor - location
    door 
    elevator
    robot
    gripper  
    object
)

(:predicates  
  ;; Locations
  (in ?l1 ?l2 - location)
  (connected ?l1 ?l2 - location ?d - door)

  ;; Doors
  (open ?d - door)
  (close ?d - door)

  ;; Robot
  (robot_at ?r - robot ?l - location)
  (gripper_free ?g - gripper)
  (gripper_at ?g - gripper ?r - robot)
  (robot_carry ?r - robot ?g - gripper ?o - object)
  
  ;; Elevator
  (floor-connection ?l1 ?l2 - location ?e - elevator)
  (ready ?l - location ?e - elevator)
  (not-ready ?l - location ?e - elevator)

  ;; Object
  (object_at ?o - object ?l - location)
)

(:constants None - door)

;; Movement actions
(:action move
  :parameters (?from ?to - location ?door - door ?robot - robot)
  :precondition 
    (and 
      (robot_at ?robot ?from)
      (connected ?from ?to ?door)  
      (open ?door)
    )
  :effect 
    (and 
      (robot_at ?robot ?to)
      (not (robot_at ?robot ?from))
    )
)

(:action move-to-zone
  :parameters (?room - room ?zone - zone ?robot - robot)
  :precondition 
    (and 
      (robot_at ?robot ?room)
      (in ?room ?zone)  
    )
  :effect 
    (and 
      (robot_at ?robot ?zone)
      (not (robot_at ?robot ?room))
    )
)

(:action leave-zone
  :parameters (?room - room ?zone - zone ?robot - robot)
  :precondition 
    (and 
      (robot_at ?robot ?zone)
      (in ?zone ?room)  
    )
  :effect 
    (and 
      (robot_at ?robot ?room)
      (not (robot_at ?robot ?zone))
    )
)

;; Door actions
(:action open-door
    :parameters (?from ?to - location ?door - door ?robot - robot)
    :precondition 
    (and 
      (robot_at ?robot ?from)
      (close ?door)
      (connected ?from ?to ?door)
    )
    :effect 
    (and
      (open ?door) 
    )
)

(:action close-door
    :parameters (?from ?to - location ?door - door ?robot - robot)
    :precondition 
    (and 
      (robot_at ?robot ?from)
      (open ?door)
      (connected ?from ?to ?door)
    )
    :effect 
    (and
      (close ?door) 
    )
)

;; Elevator actions
(:action take-elevator
    :parameters (?from ?to - location ?elev - elevator ?robot - robot)
    :precondition 
    (and 
      (robot_at ?robot ?from)
      (ready ?from ?elev)
      (not-ready ?to ?elev)
      (floor-connection ?from ?to ?elev)
    )
    :effect 
    (and
      (robot_at ?robot ?to)
      (not (robot_at ?robot ?from))
      (ready ?to ?elev)
      (not-ready ?from ?elev)
    )
)

(:action wait-elevator
    :parameters (?from ?to - location ?elev - elevator ?robot - robot)
    :precondition 
    (and 
      (robot_at ?robot ?from)
      (not-ready ?from ?elev)
      (ready ?to ?elev)
      (floor-connection ?from ?to ?elev)
    )
    :effect 
    (and
      (ready ?from ?elev)
      (not-ready ?to ?elev)
    )
)

;; Object actions
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

(:action place
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
