!   PassingUnderLeagueRaceF90
!   Author: Austin Smith
!   email: ThatSmittyDude@outlook.com
!   GitHub: github.com/ThatSmittyDude
!   Unix Timestamp: 1708988624

program PassingUnderLeagueRaceF90
    implicit none
    integer :: lapsEvent, stops
    real :: lapsRun, gallonsStart, gallonsRemaining, lapsPerGallon, lapTank, setTankPercent, stintLaps
    character(len=1) :: user
    character(len=100) :: TRIM 
    integer :: io_status

    ! Open the file for writing
    open(unit=10, file='event_data.csv', status='replace', action='write', iostat=io_status)
    if (io_status /= 0) then
        print *, "Error opening file"
        stop
    end if

    ! Write the header to the CSV file
    write(10, *) "lapsEvent,stops,lapTank,lapsRun,gallonsStart,gallonsRemaining,lapsPerGallon,setTankPercent,stintLaps"

    ! Loop for gathering data
    do
        ! Your code to read data and perform calculations

        ! User must run a series of test laps to determine stock fuel usage, more laps = more accuracy
        print *, "How many timed test laps were run?: "
        read(*, *) lapsRun

        ! User must enter gallons of fuel remaining in tank after test run
        print *, "How many gallons of fuel remaining after test run?: "
        read(*, *) gallonsRemaining 

        ! User Must enter amount of laps the event will be
        print *, "How many laps is the event?: "
        read(*, *) lapsEvent 

        ! User must enter how many fuel stops are desired during the event
        print *, "How many fuel stops are desired?: "
        read(*, *) stops 

        ! for trucks and xfinity cars, fuel tank capacity is 18.7 gallons
        gallonsStart = 18.7

        !setup math to calculate laps per gallon, laps per tank, laps per stint, fuel tank capacity adjustment

        ! calculate laps per gallon
        lapsPerGallon = lapsRun / (gallonsStart - gallonsRemaining)

        ! calculate stock laps per tank 
        lapTank = gallonsStart * lapsPerGallon

        ! calculate laps in one stint
        stintLaps = lapsEvent / (stops + 1)

        ! calculate % of tank capacity that's recommended based on the event
        setTankPercent = ((stintLaps / lapTank) * 100)
        print *, "==================================================="
        print *, "==================================================="
        print *, " "
        print *, " "
        print *, " "
        print *, " "
        print *, "Laps per gallon: ", lapsPerGallon 
        print *, "Fuel stops: ", stops
        print *, "Set fuel capacity % to: ", setTankPercent 
        print *, " "
        print *, " "
        print *, " "
        print *, " "
        print *, "==================================================="
        print *, "==================================================="

        ! write data to the csv file 
        write(10, *) TRIM(lapsEvent) // "," // TRIM(stops) // "," // TRIM(lapTank) // &
         "," // TRIM(lapsRun)  // "," //  TRIM(gallonsStart) // "," // & 
        TRIM(gallonsRemaining) // "," // TRIM(lapsPerGallon) // "," // TRIM(setTankPercent) // "," // TRIM(stintLaps)

        ! ask if the user wants to continue 
        print *, "Save data as a CSV and continue? y/n: "
        read(*, *) user 
        if (user /= 'y' .and. user /= 'Y') then
            exit
        end if 
    end do

    ! Close the file stream after writing all data
    close(10)
    print *, "Data exported to event_data.csv"

end program PassingUnderLeagueRaceF90 
