import mysql.connector

# Establish a connection to the database


def create_connection():
    connection = mysql.connector.connect(
        host='localhost',
        user='root',
        password='',
        database=''
    )
    cursor = connection.cursor()
    return connection, cursor

# Close the cursor and connection


def close_connection(cursor, connection):
    cursor.close()
    connection.close()

# Function to execute SQL queries


def execute_query(query):
    connection, cursor = create_connection()
    if connection and cursor:
        try:
            cursor.execute(query)
            result = cursor.fetchall()
            for row in result:
                print(row)
        except mysql.connector.Error as err:
            print(f"Error executing query: {err}")
        finally:
            close_connection(cursor, connection)
    else:
        print("Failed to connect to the database.")

# Function for Retrieve Operations


def retrieve_operations():
    print("\nRetrieve Operations:")
    print("1. Retrieve a list of all passengers who made reservations on a specific flight.")
    print("2. Retrieve a list of all flights departing from a specific location on a given date.")
    print("3. Retrieve a list of all aircraft that require maintenance within the next week.")
    print("4. Retrieve the reservation ID and passenger name for baggage tracking.")
    print("5. Retrieve the name and phone number of employees for a particular flight to check for incidents during their shifts.")
    print("6. Retrieve the name and airport code of locations to display in a flight schedule.")
    print("7. Retrieve the aircraft's unique ID and assigned flight and airplane model name for tracking purposes.")
    print("8. Passenger Loyalty Program")
    print("9. Search Operations")
    print("0. Back to Main Menu")

    choice = input("Enter your choice (0-9): ")

    if choice == '1':
        specific_flight_id = input("Enter the specific flight ID: ")
        query = f"""
            SELECT Passenger.*
            FROM Passenger
            JOIN Reservation ON Passenger.passenger_id = Reservation.passenger_id
            WHERE Reservation.flight_id = '{specific_flight_id}';
        """
        execute_query(query)

    elif choice == '2':
        specific_location = input("Enter the specific location: ")
        given_date = input("Enter the given date (YYYY-MM-DD): ")
        query = f"""
            SELECT Flight.*
            FROM Flight
            WHERE Flight.from_location = '{specific_location}'
            AND DATE(Flight.arrival_time) = '{given_date}';
        """
        execute_query(query)

    elif choice == '3':
        query = """
            SELECT Airplane.*
            FROM Airplane
            JOIN Maintenance_History ON Airplane.airplane_number = Maintenance_History.airplane_number
            WHERE Maintenance_History.date BETWEEN CURDATE() AND CURDATE() + INTERVAL 7 DAY;
        """
        execute_query(query)
    elif choice == '4':
        query = """
            SELECT Reservation.id, Passenger.name, Baggage.tag_index
            FROM Reservation
            JOIN Passenger ON Reservation.passenger_id = Passenger.passenger_id
            JOIN Baggage ON Passenger.passenger_id = Baggage.passenger_id;
        """
        execute_query(query)
    elif choice == '5':
        specific_flight_id = input("Enter the specific flight ID: ")
        query = f"""
            SELECT Employee.e_name, Employee.phone_number
            FROM Employee
            JOIN Flight ON Employee.employee_id = Flight.id
            WHERE Flight.id = '{specific_flight_id}';
        """
        execute_query(query)
    elif choice == '6':
        specific_flight_id = input("Enter the specific flight ID: ")
        # Retrieve the arrivial and departure along with the time and location for that flight
        query = f"""
            SELECT Flight.arrival_time, Flight.from_location, Flight.to_location
            FROM Flight
            WHERE Flight.id = '{specific_flight_id}';
        """
        execute_query(query)
    elif choice == '7':
        query = """
            SELECT Airplane.airplane_number, Flight.id, Airplane.airplane_model
            FROM Airplane
            JOIN Flight ON Airplane.airplane_number = Flight.airplane_number;
        """
        execute_query(query)

    elif choice == '8':
        query = """
            SELECT Passenger.passenger_id, COUNT(Reservation.id) AS reservation_count
            FROM Passenger
            JOIN Reservation ON Passenger.passenger_id = Reservation.passenger_id
            GROUP BY Passenger.passenger_id
            HAVING COUNT(Reservation.id) > 5;  # Assuming loyalty starts after 5 reservations
        """
        execute_query(query)

    elif choice == '9':
        search_operations()

    elif choice == '0':
        # Back to Main Menu
        return

    else:
        print("Invalid choice. Please enter a number between 0 and 9.")

    # Recursive call for continuous retrieval operations
    retrieve_operations()

# Function for Search Operations


def search_operations():
    print("\nSearch Operations:")
    print("1. Retrieve the passengers whose name ends with 'Sharma', reservation ID starts with 'EMT', or flight number starts with '4'.")
    print("2. Retrieve the employees whose name starts with 'Hema', job title is 'Pilot', or department containing 'Field'.")
    print("3. Retrieve aircraft by number starting with '134' or type containing 'AB'.")
    print("4. Retrieve a list of passengers in age group 0-100 who made reservations on flights going to CCU on 21 may, 2023.")
    print("0. Back to Main Menu")

    choice = input("Enter your choice (0-4): ")

    if choice == '1':
        query = """
            SELECT *
            FROM Passenger
            WHERE Passenger.name LIKE '%Sharma'
            OR Passenger.passenger_id IN (
                SELECT passenger_id
                FROM Reservation
                WHERE id LIKE 'EMT%' OR flight_number LIKE '6E%'
            );
        """
        execute_query(query)

    elif choice == '2':
        query = """
            SELECT *
            FROM Employee
            WHERE e_name LIKE 'Hema%' OR roles = 'Pilot' OR designation LIKE '%Field%';
        """
        execute_query(query)


    elif choice == '3':
        query = """
            SELECT *
            FROM Airplane
            WHERE airplane_number LIKE '134%' OR airplane_model LIKE '%AB%';
        """
        execute_query(query)


    elif choice == '4':
        query="""
            SELECT p.name, p.age, r.date, r.flight_id
            FROM Passenger p
            JOIN Reservation r ON p.passenger_id = r.passenger_id
            JOIN Flight f ON r.flight_id = f.id
            WHERE p.age BETWEEN 0 AND 100
            AND f.to_location = 'CCU'
            AND DATE(r.date) = '2023-05-21';
        """
        execute_query(query)

    elif choice == '0':
        # Back to Main Menu
        return

    else:
        print("Invalid choice. Please enter a number between 0 and 4.")

    # Recursive call for continuous search operations
    search_operations()

def insert_operations():
    
    choice=input("Enter Table Name from Passenger, Reservation or Flight: ")

    if choice=="Passenger":
        passenger_id=input("passenger_id: ")
        phone_number=input("phone_number: ")
        age=input("age: ")
        date_of_birth=input("date_of_birth: ")
        name=input("name: ")
        insert_query = "INSERT INTO Passenger (passenger_id, phone_number, age, date_of_birth, name) VALUES (%s, %s, %s, %s, %s)"
        values = (passenger_id, phone_number, age, date_of_birth, name)

    elif choice=="Reservation":
        id=input("id: ")
        flight_id=input("flight_id: ")
        date=input("date: ")
        meal=input("meal: ")
        passenger_id=input("passenger_id: ")
        flight_number=input("flight_number: ")
        insert_query = "INSERT INTO Reservation (id, flight_id, date, meal, passenger_id, flight_number) VALUES (%s, %s, %s, %s, %s, %s)"
        values = (id, flight_id, date, meal, passenger_id, flight_number)

    elif choice=="Flight":
        id=input("id: ")
        airplane_number=input("airplane_number: ")
        from_location=input("from_location: ")
        to_location=input("to_location: ")
        arrival_time=input("arrival_time: ")
        flight_duration=input("flight_duration: ")
        number_of_layovers=input("number_of_layovers: ")
        insert_query = "INSERT INTO Flight (id, airplane_number, from_location, to_location, arrival_time, flight_duration, number_of_layovers) VALUES (%s, %s, %s, %s, %s, %s, %s)"
        values = (id, airplane_number, from_location, to_location, arrival_time, flight_duration, number_of_layovers)

    else:
        print("Invalid choice. Please enter a table from that list.")

    connection, cursor = create_connection()
    if connection and cursor:
        try:
            cursor.execute(insert_query, values)
            connection.commit()
            print("Data inserted successfully!")
        except mysql.connector.Error as error:
            print("Error inserting data:", error)
        finally:
            cursor.close()
            connection.close()
    else:
        print("Failed to connect to the database.")

def update_operations():
    
    table_name=input("Enter Table Name: ")
    column_name=input("Enter the column name you want to update: ")
    new_value=input("Enter the new value: ")
    condition=input("Enter condition: ")
    update_query = f"UPDATE {table_name} SET {column_name} = {new_value} WHERE {condition};"

    connection, cursor = create_connection()
    if connection and cursor:
        try:
            cursor.execute(update_query)
            connection.commit()
            print("Data updation successfully!")
        except mysql.connector.Error as error:
            print("Error updation data:", error)
        finally:
            cursor.close()
            connection.close()
    else:
        print("Failed to connect to the database.")

    # execute_query(update_query)

    print("1. Update query")
    print("2. Exit")
    choice=input("Enter your choice (1 or 2): ")
    
    if choice==1:
        update_operations()
    else:
        return
def aggregate_operations():
    print("press 1 to get flight with highest occupancy and 0 to return to main menu \n")
    choice = input("Enter your choice (0 or 1): ")
    
    if choice == "1":
        query = """
            SELECT
            f.id AS flight_id,
            f.airplane_number,
            f.from_location,
            f.to_location,
            f.arrival_time,
            f.flight_duration,
            f.number_of_layovers,
            COUNT(r.id) AS occupancy
        FROM
            Flight f
        JOIN
            Reservation r ON f.id = r.flight_id
        GROUP BY
            f.id, f.airplane_number, f.from_location, f.to_location, f.arrival_time, f.flight_duration, f.number_of_layovers
        ORDER BY
            occupancy DESC
        LIMIT 1;

        """
        execute_query(query)

        # connection, cursor = create_connection()
        # if connection and cursor:
        #     try:
        #         cursor.execute(query)
        #         connection.commit()
        #         print("Aggregate successfully!")
        #     except mysql.connector.Error as error:
        #         print("Error updation data:", error)
        #     finally:
        #         cursor.close()
        #         connection.close()
    elif choice == "0":
        return
    
    else:
        # print("bhaskar chutiya\n")
        aggregate_operations()
def delete_operations():

    print("1. Delete query")
    print("2. Exit")
    choice=input("Enter your choice (1 or 2): ")
    table_name=input("Enter Table Name: ")
    condition=input("Enter condition: ")
    delete_query = f"DELETE FROM {table_name} WHERE {condition};"
    connection, cursor = create_connection()
    if connection and cursor:
        try:
            cursor.execute(delete_query)
            connection.commit()
            print("Data Deleted successfully!")
        except mysql.connector.Error as error:
            print("Error updation data:", error)
        finally:
            cursor.close()
            connection.close()
    else:
        print("Failed to connect to the database.")


    if choice==1:
        delete_operations()
    else:
        return

# Main Menu
while True:
    print("\nMain Menu:")
    print("1. Retrieve Operations")
    print("2. Insert Operations")
    print("3. Update Operations")
    print("4. Delete Operations")
    print("5. Aggregate Operations")
    print("6. Exit")

    main_choice = input("Enter your choice (1-5): ")

    if main_choice == '1':
        # Retrieve Operations
        retrieve_operations()

    elif main_choice == '2':
        # Retrieve Operations
        insert_operations()

    elif main_choice == '3':
        # Retrieve Operations
        update_operations()

    elif main_choice == '4':
        # Retrieve Operations
        delete_operations()
    elif main_choice == '5':
        # Exit
       aggregate_operations()
    elif main_choice == '6':
        # Exit
        break

    else:
        print("Invalid choice. Please enter a number between 1 to 5.")
