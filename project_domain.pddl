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
  (at ?l - location) 
  (in ?l1 ?l2 - location)
  (connected ?l1 ?l2 - location ?d - door)
  (open ?d - door)
  (close ?d - door)

  ;; Robot
  (robot_at ?r - robot ?l - location)
  (gripper_free ?g - gripper)
  (gripper_at ?g - gripper ?r - robot)
  
  ;; Elevator
  (floor-connection ?l1 ?l2 - location ?e - elevator)
  (ready ?l - location ?e - elevator)
  (not-ready ?l - location ?e - elevator)

  ;; Object
  (object_at ?o - object ?l - location)
)

(:constants None - door)

(:action move
  :parameters (?from ?to - location ?door - door ?robot - robot)
  :precondition 
    (and 
      ;;(at ?from)
      (robot_at ?robot ?from)
      (connected ?from ?to ?door)  
      (open ?door)
    )
  :effect 
    (and 
      ;;(at ?to)
      ;;(not (at ?from))
      (robot_at ?robot ?to)
      (not (robot_at ?robot ?from))
    )
)

(:action move-to-zone
  :parameters (?room - room ?zone - zone ?robot - robot)
  :precondition 
    (and 
      ;; (at ?room)
      (robot_at ?robot ?room)
      (in ?room ?zone)  
    )
  :effect 
    (and 
      (robot_at ?robot ?zone)
      (not (robot_at ?robot ?room))
    )
      ;; (at ?zone)
      ;; (not (at ?room)))
)

(:action leave-zone
  :parameters (?room - room ?zone - zone ?robot - robot)
  :precondition 
    (and 
      ;; (at ?zone)
      (robot_at ?robot ?zone)
      (in ?zone ?room)  
    )
  :effect 
    (and 
      ;; (at ?room)
      ;; (not (at ?zone))
      (robot_at ?robot ?room)
      (not (robot_at ?robot ?zone))
    )
)

(:action open-door
    :parameters (?from ?to - location ?door - door ?robot - robot)
    :precondition 
    (and 
      ;; (at ?from)
      (robot_at ?robot ?from)
      (close ?door)
      (connected ?from ?to ?door)
    )
    :effect 
    (and
      (open ?door) 
    )
)

;; Elevator actions
(:action take-elevator
    :parameters (?from ?to - location ?elev - elevator ?robot - robot)
    :precondition 
    (and 
      ;; (at ?from)
      (robot_at ?robot ?from)
      (ready ?from ?elev)
      (not-ready ?to ?elev)
      (floor-connection ?from ?to ?elev)
    )
    :effect 
    (and
      ;; (at ?to) 
      ;; (not (at ?from))
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
      ;; (at ?from)
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
)
