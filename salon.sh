#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

echo -e "\n~~~~~ Salon Appointment ~~~~~"

MAIN_MENU () {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo -e "\nWhat service would you like to do today?"
  echo "$($PSQL "SELECT * FROM services")" | while IFS="|" read SERVICE_ID SERVICE_NAME
  do
    echo -e "$SERVICE_ID) $SERVICE_NAME"
  done

  read SERVICE_ID_SELECTED
}

MAIN_MENU

# user input was not a number
if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
then
  MAIN_MENU "That is not a valid option."
else
  VALID_SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id = $SERVICE_ID_SELECTED")
  SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

  # user input not included in the service list
  if [[ -z $VALID_SERVICE_ID ]]
  then
    MAIN_MENU "Please enter a valid option."
  else
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

    # new customer
    if [[ -z $CUSTOMER_NAME ]]
    then 
      echo -e "\nWhat's your name?"
      read CUSTOMER_NAME
      
      echo -e "\nWhat time do you like to book?"
      read SERVICE_TIME

      INSERT_CUSTOMER_INFO=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
      
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
      INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

      echo -e "\nI have put you down for a $SERVICE_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."
    else
      echo -e "\nWhat time would you like your $SERVICE_SELECTED, $CUSTOMER_NAME?"
      read SERVICE_TIME

      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
      INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
      
      echo -e "\nI have put you down for a $SERVICE_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."
    fi
  fi
fi

