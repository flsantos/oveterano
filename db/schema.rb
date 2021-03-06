# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110708215455) do

  create_table "assets", :force => true do |t|
    t.string   "descricao"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.integer  "usuario_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["attachable_id", "attachable_type"], :name => "index_assets_on_attachable_id_and_attachable_type"

  create_table "campi", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campi", ["id"], :name => "index_campi_on_id"

  create_table "campi_disciplinas", :id => false, :force => true do |t|
    t.integer "campus_id"
    t.integer "disciplina_id"
  end

  add_index "campi_disciplinas", ["campus_id", "disciplina_id"], :name => "index_campi_disciplinas_on_campus_id_and_disciplina_id"
  add_index "campi_disciplinas", ["disciplina_id", "campus_id"], :name => "index_campi_disciplinas_on_disciplina_id_and_campus_id"

  create_table "curriculos", :force => true do |t|
    t.integer  "habilitacao_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "curriculos", ["id"], :name => "index_curriculos_on_id"

  create_table "curriculos_disciplinas", :id => false, :force => true do |t|
    t.integer "curriculo_id"
    t.integer "disciplina_id"
  end

  add_index "curriculos_disciplinas", ["curriculo_id", "disciplina_id"], :name => "index_curriculos_disciplinas_on_curriculo_id_and_disciplina_id"
  add_index "curriculos_disciplinas", ["disciplina_id", "curriculo_id"], :name => "index_curriculos_disciplinas_on_disciplina_id_and_curriculo_id"

  create_table "cursos", :force => true do |t|
    t.integer  "codigo"
    t.string   "nome"
    t.string   "modalidade"
    t.string   "turno"
    t.integer  "campus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cursos", ["campus_id"], :name => "index_cursos_on_campus_id"
  add_index "cursos", ["id"], :name => "index_cursos_on_id"

  create_table "departamentos", :force => true do |t|
    t.integer  "codigo"
    t.string   "sigla"
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departamentos", ["id"], :name => "index_departamentos_on_id"

  create_table "disciplinas", :force => true do |t|
    t.integer  "codigo"
    t.string   "nome"
    t.integer  "departamento_id"
    t.string   "creditos"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "disciplinas", ["departamento_id"], :name => "index_disciplinas_on_departamento_id"
  add_index "disciplinas", ["id"], :name => "index_disciplinas_on_id"

  create_table "disciplinas_fluxos", :id => false, :force => true do |t|
    t.integer "fluxo_id"
    t.integer "disciplina_id"
  end

  add_index "disciplinas_fluxos", ["disciplina_id", "fluxo_id"], :name => "index_disciplinas_fluxos_on_disciplina_id_and_fluxo_id"
  add_index "disciplinas_fluxos", ["fluxo_id", "disciplina_id"], :name => "index_disciplinas_fluxos_on_fluxo_id_and_disciplina_id"

  create_table "fluxos", :force => true do |t|
    t.integer  "habilitacao_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fluxos", ["habilitacao_id"], :name => "index_fluxos_on_habilitacao_id"
  add_index "fluxos", ["id"], :name => "index_fluxos_on_id"

  create_table "grades", :force => true do |t|
    t.string   "nome"
    t.string   "semestre"
    t.integer  "usuario_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades_ofertas", :id => false, :force => true do |t|
    t.integer "oferta_id"
    t.integer "grade_id"
  end

  create_table "habilitacoes", :force => true do |t|
    t.integer  "codigo"
    t.string   "nome"
    t.integer  "curso_id"
    t.integer  "fluxo_id"
    t.integer  "curriculo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "habilitacoes", ["curriculo_id"], :name => "index_habilitacoes_on_curriculo_id"
  add_index "habilitacoes", ["curso_id"], :name => "index_habilitacoes_on_curso_id"
  add_index "habilitacoes", ["fluxo_id"], :name => "index_habilitacoes_on_fluxo_id"
  add_index "habilitacoes", ["id"], :name => "index_habilitacoes_on_id"

  create_table "horarios", :force => true do |t|
    t.integer  "dia"
    t.string   "horario_ini"
    t.string   "horario_fim"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "horarios", ["id"], :name => "index_horarios_on_id"

  create_table "horarios_ofertas", :id => false, :force => true do |t|
    t.integer "horario_id"
    t.integer "oferta_id"
  end

  add_index "horarios_ofertas", ["horario_id", "oferta_id"], :name => "index_horarios_ofertas_on_horario_id_and_oferta_id"
  add_index "horarios_ofertas", ["oferta_id", "horario_id"], :name => "index_horarios_ofertas_on_oferta_id_and_horario_id"

  create_table "ofertas", :force => true do |t|
    t.integer  "disciplina_id"
    t.string   "turma"
    t.string   "turno"
    t.integer  "vagas_totais"
    t.integer  "vagas_ocup"
    t.integer  "vagas_disp"
    t.boolean  "oferta_atual"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ofertas", ["disciplina_id", "id"], :name => "index_ofertas_on_disciplina_id_and_id"
  add_index "ofertas", ["id", "disciplina_id"], :name => "index_ofertas_on_id_and_disciplina_id"
  add_index "ofertas", ["id"], :name => "index_ofertas_on_id"

  create_table "ofertas_professores", :id => false, :force => true do |t|
    t.integer "oferta_id"
    t.integer "professor_id"
  end

  add_index "ofertas_professores", ["oferta_id", "professor_id"], :name => "index_ofertas_professores_on_oferta_id_and_professor_id"
  add_index "ofertas_professores", ["professor_id", "oferta_id"], :name => "index_ofertas_professores_on_professor_id_and_oferta_id"

  create_table "ofertas_reservas", :id => false, :force => true do |t|
    t.integer "oferta_id"
    t.integer "reserva_id"
  end

  add_index "ofertas_reservas", ["oferta_id", "reserva_id"], :name => "index_ofertas_reservas_on_oferta_id_and_reserva_id"
  add_index "ofertas_reservas", ["reserva_id", "oferta_id"], :name => "index_ofertas_reservas_on_reserva_id_and_oferta_id"

  create_table "posts", :force => true do |t|
    t.text     "mensagem"
    t.integer  "alias"
    t.integer  "alias_id"
    t.integer  "autor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["alias_id"], :name => "index_posts_on_alias_id"
  add_index "posts", ["autor_id"], :name => "index_posts_on_autor_id"
  add_index "posts", ["id"], :name => "index_posts_on_id"

  create_table "professores", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "professores", ["id"], :name => "index_professores_on_id"
  add_index "professores", ["nome"], :name => "index_professores_on_nome"

  create_table "reservas", :force => true do |t|
    t.string   "curso"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reservas", ["curso"], :name => "index_reservas_on_curso"
  add_index "reservas", ["id"], :name => "index_reservas_on_id"

  create_table "usuarios", :force => true do |t|
    t.string   "nome",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.integer  "curso_id"
    t.string   "semestre",                  :limit => 6
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "reset_code"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["id"], :name => "index_usuarios_on_id"

  create_table "votos", :force => true do |t|
    t.integer  "alias"
    t.integer  "alias_id"
    t.integer  "voto"
    t.integer  "autor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votos", ["id"], :name => "index_votos_on_id"

end
