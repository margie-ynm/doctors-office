require('sinatra')
require('sinatra/reloader')
require('./lib/doctor')
require('./lib/patient')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => "doctors_office"})

get('/') do
  @doctors = Doctor.all()
  erb(:index)
end

get('/doctors/new') do
  erb(:doctor_form)
end

post('/doctors') do
  name = params.fetch('name')
  specialty = params.fetch('specialty')
  @doctor = Doctor.new({:name => name, :specialty => specialty}).save()
  erb(:success)
end

get('/doctors/:id') do
 @doctor = Doctor.find(params.fetch('id').to_i)
 erb(:doctor)
end



post('/doctors/:id') do
  name = params.fetch("name")
  doctor_id = params.fetch('doctor_id').to_i
  birthday = params.fetch("birthday")
  @doctor = Doctor.find(doctor_id)
  @patient = Patient.new({:name => name, :birthday => birthday, :doctor_id => doctor_id})
  @patient.save
  erb(:doctor)
end
