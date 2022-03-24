(define (problem move-probl)
(:domain project)
(:objects 
    Room1 Room2 Room3 Room4 Room5 Room6 Room7 Room8 Room9 - room
    Corridor1 Corridor2 Corridor3 - corridor
    door1 door2 door3 door4 door5 door6 door7 - door
    zone1 zone2 zone3 zone4 zone5 - zone
    elevator - elevator
    object - object
    hand - gripper
    wall_E - robot
)
(:init 
    ;; Initial state
    (robot_at wall_E Room3)
    (gripper_at hand wall_E)
    (gripper_free hand)
    (open None)
    (object_at object zone2)

    ;; Doors
    (close door1)
    (close door2)
    (close door3)
    (close door4)
    (close door5)
    (close door6)
    (close door7)

    ;; Zones - Rooms
    (in Room1 zone1)
    (in Room1 zone2)
    (in Room2 zone3)
    (in Room2 zone4)
    (in Room2 zone5)

    (in zone1 Room1)
    (in zone2 Room1)
    (in zone3 Room2)
    (in zone4 Room2)
    (in zone5 Room2)

    ;; Connections between every location
    ;; -- 1st Floor
    (connected Corridor1 Room2 None)
    (connected Room2 Corridor1 None)
    (connected Room2 Room4 None)
    (connected Room4 Room2 None)

    (connected Room1 Room3 door2)
    (connected Room3 Room1 door2)
    (connected Room1 Corridor1 door1)
    (connected Corridor1 Room1 door1)

    ;; -- 2nd Floor
    (connected Corridor2 Corridor3 None)
    (connected Corridor3 Corridor2 None)

    (connected Room5 Corridor2 door4)
    (connected Corridor2 Room5 door4)
    (connected Room6 Corridor2 door3)
    (connected Corridor2 Room6 door3)

    (connected Room7 Corridor3 door5) 
    (connected Corridor3 Room7 door5) 
    (connected Room9 Corridor3 door6) 
    (connected Corridor3 Room9 door6)
    (connected Room8 Corridor3 door7)
    (connected Corridor3 Room8 door7)    

    ;; Elevator
    (ready Corridor2 elevator)
    (not-ready Corridor1 elevator)
    (floor-connection Corridor1 Corridor2 elevator)
    (floor-connection Corridor2 Corridor1 elevator)
)

(:goal 
  (and 
    (object_at object Room9)
  )
)
)
