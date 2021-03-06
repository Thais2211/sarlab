# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_18_024539) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "anexos", force: :cascade do |t|
    t.integer "equipament_id"
    t.integer "disciplina_id"
    t.integer "laboratory_id"
    t.integer "lesson_id"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "disciplinas", force: :cascade do |t|
    t.string "nome"
    t.bigint "professor_id"
    t.bigint "escola_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.index ["escola_id"], name: "index_disciplinas_on_escola_id"
    t.index ["professor_id"], name: "index_disciplinas_on_professor_id"
  end

  create_table "equipaments", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "brand"
    t.string "model"
    t.string "capacity"
    t.string "patrimony"
    t.bigint "laboratory_id"
    t.integer "simultaneous_use"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.boolean "active", default: true
    t.index ["laboratory_id"], name: "index_equipaments_on_laboratory_id"
  end

  create_table "escolas", force: :cascade do |t|
    t.string "nome"
    t.string "endereco"
    t.integer "numero"
    t.string "bairro"
    t.string "cidade"
    t.string "responsavel"
    t.string "telefone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "laboratorys", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "active", default: true
    t.bigint "escola_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "local"
    t.index ["escola_id"], name: "index_laboratorys_on_escola_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.date "data"
    t.time "start_time"
    t.time "end_time"
    t.bigint "laboratory_id"
    t.bigint "disciplina_id"
    t.boolean "review", default: false
    t.bigint "users_id"
    t.date "date_review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disciplina_id"], name: "index_lessons_on_disciplina_id"
    t.index ["laboratory_id"], name: "index_lessons_on_laboratory_id"
    t.index ["users_id"], name: "index_lessons_on_users_id"
  end

  create_table "logged_exceptions", force: :cascade do |t|
    t.string "exception_class"
    t.string "controller_name"
    t.string "action_name"
    t.text "message"
    t.text "backtrace"
    t.text "environment"
    t.text "request"
    t.datetime "created_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string "permissao"
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.bigint "equipament_id"
    t.bigint "laboratory_id"
    t.bigint "user_id"
    t.string "status"
    t.bigint "type_reservation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lesson_id"
    t.integer "admin_aproved"
    t.string "reason_rejected"
    t.integer "admin_rejected"
    t.string "reason_cancel"
    t.integer "admin_cancel"
    t.index ["equipament_id"], name: "index_schedules_on_equipament_id"
    t.index ["laboratory_id"], name: "index_schedules_on_laboratory_id"
    t.index ["type_reservation_id"], name: "index_schedules_on_type_reservation_id"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "type_reservations", force: :cascade do |t|
    t.string "description"
    t.string "color"
  end

  create_table "users", force: :cascade do |t|
    t.string "nome", null: false
    t.integer "ra"
    t.string "email", default: "", null: false
    t.string "celular"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "ativo"
    t.bigint "escola_id"
    t.bigint "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["escola_id"], name: "index_users_on_escola_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "disciplinas", "escolas"
  add_foreign_key "disciplinas", "users", column: "professor_id"
  add_foreign_key "equipaments", "laboratorys"
  add_foreign_key "laboratorys", "escolas"
  add_foreign_key "lessons", "disciplinas"
  add_foreign_key "lessons", "laboratorys"
  add_foreign_key "schedules", "users"
  add_foreign_key "users", "escolas"
  add_foreign_key "users", "roles"
end
