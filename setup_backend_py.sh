#!/bin/bash

# Define project directory and database configuration
PROJECT_DIR="aerp-backend"
DB_NAME="aerp_db"
DB_USER="aerp_user"
DB_PASSWORD="password"
DB_HOST="localhost"
DB_PORT="5432"

# Define the modules (you can replace this with a JSON or configuration file)
declare -A MODULES
MODULES=(
  ["users"]="id:integer,name:string,email:string,password:string"
  ["products"]="id:integer,name:string,price:float,stock:integer"
  ["orders"]="id:integer,user_id:integer,total:float,status:string"
)

# Create database schema
echo "Creating database..."
psql -h "$DB_HOST" -U "$DB_USER" -c "CREATE DATABASE $DB_NAME;" || echo "Database $DB_NAME already exists."

# Generate models, routes, and controllers for each module
for module in "${!MODULES[@]}"; do
  MODULE_DIR="$PROJECT_DIR/$module"
  FIELDS=${MODULES[$module]}

  echo "Generating module: $module"

  # Create module directories
  mkdir -p "$MODULE_DIR"

  # Generate model
  echo "Creating model for $module..."
  MODEL_FILE="$MODULE_DIR/${module}_model.py"
  echo "from sqlalchemy import Column, Integer, String, Float, create_engine" > "$MODEL_FILE"
  echo "from sqlalchemy.ext.declarative import declarative_base" >> "$MODEL_FILE"
  echo "Base = declarative_base()" >> "$MODEL_FILE"
  echo "class ${module^}(Base):" >> "$MODEL_FILE"
  echo "    __tablename__ = '$module'" >> "$MODEL_FILE"
  for field in $(echo "$FIELDS" | tr ',' ' '); do
    NAME=$(echo "$field" | cut -d':' -f1)
    TYPE=$(echo "$field" | cut -d':' -f2)
    case "$TYPE" in
      integer) SQL_TYPE="Integer" ;;
      string) SQL_TYPE="String" ;;
      float) SQL_TYPE="Float" ;;
      *) SQL_TYPE="String" ;;
    esac
    echo "    $NAME = Column($SQL_TYPE)" >> "$MODEL_FILE"
  done

  # Generate controller
  echo "Creating controller for $module..."
  CONTROLLER_FILE="$MODULE_DIR/${module}_controller.py"
  echo "from flask import Blueprint, request, jsonify" > "$CONTROLLER_FILE"
  echo "from .${module}_model import ${module^}" >> "$CONTROLLER_FILE"
  echo "$module = Blueprint('$module', __name__)" >> "$CONTROLLER_FILE"
  echo "@$module.route('/$module', methods=['GET'])" >> "$CONTROLLER_FILE"
  echo "def get_all_$module():" >> "$CONTROLLER_FILE"
  echo "    return jsonify({'message': 'List of $module'})" >> "$CONTROLLER_FILE"
  echo "@$module.route('/$module', methods=['POST'])" >> "$CONTROLLER_FILE"
  echo "def create_$module():" >> "$CONTROLLER_FILE"
  echo "    return jsonify({'message': 'Create $module'})" >> "$CONTROLLER_FILE"

  # Generate routes
  echo "Registering routes for $module..."
  MAIN_ROUTES_FILE="$PROJECT_DIR/routes.py"
  echo "from $module.${module}_controller import $module" >> "$MAIN_ROUTES_FILE"
  echo "app.register_blueprint($module)" >> "$MAIN_ROUTES_FILE"

done

# Finalize
echo "Modules generated and integrated successfully."
echo "Don't forget to set up your database connection and migrate the schemas!"
