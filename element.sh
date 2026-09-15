#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

#check if input is number
if [[ $1 =~ ^[0-9]+$ ]]
then
  ELEMENT_DATA=$($PSQL "select atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type from elements join properties using(atomic_number) join types using(type_id) where atomic_number = $1")
else
  #input is symbol or name
  ELEMENT_DATA=$($PSQL "select atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type from elements join properties using(atomic_number) join types using(type_id) where symbol = '$1' or name = '$1'")
fi

#if element not found
if [[ -z $ELEMENT_DATA ]]
then
  echo "I could not find that element in the database."
else
  #parse data
  echo "$ELEMENT_DATA" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  done
fi
# refactor comment
# fix comment
# chore comment
# final comment
