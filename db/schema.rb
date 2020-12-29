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

ActiveRecord::Schema.define(version: 2020_12_29_113855) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "disciplinas", force: :cascade do |t|
    t.string "nome"
    t.bigint "professor_id"
    t.bigint "escola_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["escola_id"], name: "index_disciplinas_on_escola_id"
    t.index ["professor_id"], name: "index_disciplinas_on_professor_id"
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

  create_table "roles", force: :cascade do |t|
    t.string "permissao"
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
  add_foreign_key "laboratorys", "escolas"
  add_foreign_key "users", "escolas"
  add_foreign_key "users", "roles"
end
