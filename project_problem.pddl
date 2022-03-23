(define (problem move-probl)
(:domain project)
(:objects 
    Room1 Room2 Room3 Room4 - room
    Corridor1 Corridor2 - corridor
    door1 door2 - door
    zone1 zone2 zone3 zone4 zone5 - zone
    elevator - elevator
)
(:init 
    ;; Initial state
    (at Room3)
    (open None)

    (close door1)
    (close door2)

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
    (connected Corridor1 Room2 None)
    (connected Room2 Corridor1 None)
    (connected Room2 Room4 None)
    (connected Room4 Room2 None)

    (connected Room1 Room3 door2)
    (connected Room3 Room1 door2)
    (connected Room1 Corridor1 door1)
    (connected Corridor1 Room1 door1)

    ;; Elevator
    (ready Corridor2 elevator)
    (not-ready Corridor1 elevator)
    (floor-connection Corridor1 Corridor2 elevator)
    (floor-connection Corridor2 Corridor1 elevator)
)

(:goal 
  (and 
    (at Corridor2)
  )
)
)
