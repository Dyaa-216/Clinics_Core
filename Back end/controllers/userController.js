const Patient = require("../models/user");
const db = require("../config/db");
const http = require('http');
class PatientController {
    // static async getAllPatients(req, res) {
    //     try {
    //         const result = await Patient.getpatient();
    //         res.send(result);
    //     } catch (error) {
    //         // Handle any errors that occur during the database query or processing
    //         console.error(error);
    //         console.error("Error fetching patients:", error);
    //         res.status(500).send("An error occurred while fetching patients");
    //     }
    // }
    static async getAll(req, res) {
        try {
            const result = await Patient.gettest();
            res.send(result);
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);
            res.status(500).send("An error occurred while fetching patients");
        }
    }
    static async addUesr(req, res) {
        try {
            var dd = req.body.dd
            var yy = req.body.yy
            var aa = req.body.aa
          
            const result = await Patient.adduser(dd, yy ,aa);
            if (result === true) {
                res.send("AAadeedd user succesfully");

            } else {
                res.send("AAadeedd user faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async signinPateint(req, res) {
        try {
            var id = req.body.id
            var email = req.body.email
            var password = req.body.password
          
            const result = await Patient.signin_pateint(id, email ,password);
            if (result === true) {
                res.send("sinIn user succesfully");

            } else {
                res.send("AAadeedd user faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async addPatiant(req, res) {
        try {
            var id = req.body.id
            var gender = req.body.gender
            var phone_num = req.body.phone_num
            var password = req.body.password
            var tall = req.body.tall
            var weight = req.body.weight
            var Name = req.body.Name
            var email = req.body.eamil
            var age = req.body.age
            const result = await Patient.addpatiant(id,Name,weight,tall, password, phone_num,  gender, email,age);
            if (result == true) {
                res.send("AAadeedd patient succesfully");

            } else {
                
                res.send("AAadeedd patient faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async addPait(req, res) {
        try {
            var gender = req.body.gender
            var phone_num = req.body.phone_num
            var password = req.body.password
            var tall = req.body.tall
            var weight = req.body.weight
            var Name = req.body.Name
            var email = req.body.eamil
            var age = req.body.age
            const result = await Patient.addpatiant(Name ,weight ,tall, password, phone_num,  gender, email,age);
            if (result == true) {
                res.send("AAadeedd user succesfully");

            } else {
                res.send("AAadeedd user faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async signUpPatient(req, res) {
        try {
            var gender = req.body.gender
            var phone_num = req.body.phone_num
            var password = req.body.password
            var id = req.body.id
            var weight = req.body.weight
            var name = req.body.name
            var Nid = req.body.Nid
            var email = req.body.email
            var age = req.body.age
            const result = await Patient.signUP_pateint(id, email, name,Nid, password, phone_num, age, weight, gender);
            if (result == true) {
                res.send(" patient sign Up success");

            } else {
                res.send("patient sign Up  faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }


    static async signUpDoctor(req, res) {
        try {
            var Specialization = req.body.Specialization
            var phone_num = req.body.phone_num
            var password = req.body.password
            var id = req.body.id
            
            var name = req.body.name
            var email = req.body.email
            
            const result = await Patient.signUP_doctor(id, email, password, name, phone_num, Specialization);
            if (result == true) {
                res.send(" Docotor sign Up success");

            } else {
                res.send("Docotor sign Up  faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }

    static async signUpClinic(req, res) {
        try {
            var timerange = req.body.time_range
            var phone_num = req.body.phone_num
            var password = req.body.password
            var id = req.body.id
            
            var name = req.body.name
            var email = req.body.email
            var address = req.body.address
            var Specialization = req.body.Specialization
            var deamil = req.body.deamil
            
            const result = await Patient.signUp_Clinic(id, email, password, name, phone_num, timerange, address,Specialization,deamil);
            if (result == true) {
                res.send(" Clinic sign Up success");

            } else {
                res.send("Clinic sign Up  faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
   
    static async getPatient(req, res) {
        try {
            const email = req.query.email;
            console.log(email);

            const result = await Patient.get_patient(email);
            if (result) {
                //
                console.log("Send a success response");
                res.send(result);
            } else {
                // Send a failure response
                
                res.send(null);
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async login(req, res) {
        try {
            var email = req.body.email
            var password = req.body.password

            const result = await Patient.logIn(email, password);
            if (result === true) {
                res.send("log in  succesfully");
                res.send({
                    "result": res
                });

            } else {
                res.send("log in  user faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }

    static async loginPateint(req, res) {
        try {
            var email = req.body.email
            var password = req.body.password

            const result = await Patient.login_pateint(email, password);
            if (result) {
                //
                console.log("Send a success response");
                res.send(result);
            } else {
                // Send a failure response
                
                res.send(null);
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async loginTest(req, res) {
        try {
            var dd = req.body.dd
            var yy = req.body.yy

            const result = await Patient.login_test(dd, yy);
            
            if (result === true) {
                //
                console.log("Send a success response");
                res.send(result);
            } else {
                // Send a failure response
                res.status(401).json({ status: 401, message: "Log in failed" });
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async updatePatient(req, res) {
        try {
            var gender = req.body.gender
            var phone_num = req.body.phone_num
            var id = req.body.id
            var weight = req.body.weight
            var name = req.body.name
            var email = req.query.email
            var age = req.body.age
            var Nid = req.body.Nid
            const result = await Patient.update_patient(email, name,Nid, phone_num, age, weight, gender);
            if (result == true) {
                console.log(result)
                res.send(" patient updated success");

            } else {
                res.send("patient updated  faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async updateDoc2(req, res) {
        try {
            var email = req.body.email
            var timerange = req.body.time_range
            const result = await Patient.update_doc2(email,timerange);
            if (result == true) {
                console.log(result)
                res.send(" patient updated success");

            } else {
                res.send("patient updated  faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }

    static async updateDoc01(req, res) {
        try {
            var email = req.query.email
            var status = req.query.status
            const result = await Patient.update_doc01(email,status);
            if (result == true) {
                console.log(result)
                res.send(" patient updated success");

            } else {
                res.send("patient updated  faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }

    static async rescedual(req, res) {
        try {
            var id = req.query.id
            var date = req.body.date
            const result = await Patient.update_resced(date,id);
            if (result == true) {
                console.log(result)
                res.send(" patient updated success");

            } else {
                res.send("patient updated  faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async Confirm(req, res) {
        try {
            var id = req.query.id
            var complete = req.query.complete
            const result = await Patient.update_cmp(complete,id);
            if (result == true) {
                console.log(result)
                res.send(" patient updated success");

            } else {
                res.send("patient updated  faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async getcc(req, res) {
        try {
            const Specialization = req.query.Specialization;
            const result = await Patient.getcC(Specialization);
            res.send(result);
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);
            res.status(500).send("An error occurred while fetching patients");
        }
    }
    static async getClinic(req, res) {
        try {
            const Specialization = req.query.Specialization;
            const result = await Patient.getclinic(Specialization);
            res.send(result);
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);
            res.status(500).send("An error occurred while fetching patients");
        }
    }
    static async getClinicn(req, res) {
        try {
            const deamil = req.query.deamil;
            const result = await Patient.getclinicn(deamil);
            res.send(result);
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);
            res.status(500).send("An error occurred while fetching patients");
        }
    }
    static async getSlot(req, res) {
        try {
            const email = req.query.email;
            const result = await Patient.getslot(email);
            res.send(result);
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);
            res.status(500).send("An error occurred while fetching patients");
        }
    }
    static async getClinicDocs(req, res) {
        try {
            const clinicEmail = req.query.cl_email;
            console.log(clinicEmail)
            const result = await Patient.getclinicDoc(clinicEmail);
            res.send(result);
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);
            res.status(500).send("An error occurred while fetching patients");
        }
    }
    static async getDoctor(req, res) {
        try {
            const email = req.query.email;
            const result = await Patient.get_doctor(email);
            res.send(result);
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);
            res.status(500).send("An error occurred while fetching patients");
        }
    }
    static async getNot(req, res) {
        try {
            const receiver = req.query.receiver;
            const result = await Patient.getnotifications(receiver);
            res.send(result);
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);
            res.status(500).send("An error occurred while fetching patients");
        }
    }
    static async getAppp(req, res) {
        try {
            const pat_email = req.query.pat_email;
            const complete = req.query.complete;
            const result = await Patient.getappp(pat_email,complete);
            res.send(result);
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);
            res.status(500).send("An error occurred while fetching patients");
        }
    }
    static async getApppd(req, res) {
        try {
            const doc_email = req.query.doc_email;
            const complete = req.query.complete;
            const result = await Patient.getapppd(doc_email,complete);
            res.send(result);
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);
            res.status(500).send("An error occurred while fetching patients");
        }
    }
    static async getAppe(req, res) {
        try {
            console.log("LLLLLLLLLLLLLLLLLLLl");
            const cl_email = req.query.cl_email;
            const result = await Patient.getappe(cl_email);
            res.send(result);
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);
            res.status(500).send("An error occurred while fetching patients");
        }
    }
    static async getAppd(req, res) {
        try {
            const doc_email = req.query.doc_email;
            const complete = req.query.complete;
            const result = await Patient.getappd(doc_email,complete);
            res.send(result);
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);
            res.status(500).send("An error occurred while fetching patients");
        }
    }
    static async getdocPats(req, res) {
        try {
            const email = req.query.email;
            console.log(email);

            const result = await Patient.get_docPats(email);
            if (result) {
                //
                console.log("Send a success response");
                res.send(result);
            } else {
                // Send a failure response
                
                res.send(null);
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async addNot(req, res) {
        try {
            var sender = req.body.sender
            var receiver = req.body.receiver
            var sname = req.body.sname
            var rname = req.body.rname
            var contents = req.body.content
            var time = req.body.time
          
            const result = await Patient.add_not(sender,receiver,sname,rname,contents,time);
            if (result === true) {
                res.send("added not user succesfully");

            } else {
                res.send("added not faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async addapp(req, res) {
        try {
            var doc_name = req.body.doc_name
            var doc_email = req.body.doc_email
            var date	 = req.body.date	
            var complete = req.body.complete
            var pat_email = req.body.pat_email
            var dd = req.body.cl_name
           
          
            const result = await Patient.add_app(doc_name,doc_email,pat_email,date,complete,dd);
            if (result === true) {
                res.send("added not user succesfully");

            } else {
                res.send("added not faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async deleteDc(req, res) {
        try {
            
            var email = req.query.email
            const result = await Patient.delete_cd(email);
            if (result === true) {
                res.send("added not user succesfully");

            } else {
                res.send("added not faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async deleteApp(req, res) {
        try {
            
            var id = req.query.id
            const result = await Patient.delete_app(id);
            if (result === true) {
                res.send("added not user succesfully");

            } else {
                res.send("added not faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async addcldoc(req, res) {
        try {
            
            var doc_email = req.body.doc_email
            var cl_email = req.body.cl_email
           
          
            const result = await Patient.add_cldoc(cl_email,doc_email);
            if (result === true) {
                res.send("added not user succesfully");

            } else {
                res.send("added not faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async addPatdoc(req, res) {
        try {
           
            var doc_email = req.body.doc_email
            var pat_name= req.body.pat_name	
            var pat_email = req.body.pat_email
           
          
            const result = await Patient.add_aptdoc(doc_email,pat_email,pat_name);
            if (result === true) {
                res.send("added not user succesfully");

            } else {
                res.send("added not faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async imagep(req, res) {
        try {
            const name = req.body.name
            const file =req.files.img

            console.log(name)
            console.log(file)
            console.log(file.name)
            
            const result = await Patient.pic_image(name,file);
            if (result === true) {
                res.send("added not user succesfully");

            } else {
                res.send("added not faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async getNid(req, res) {
        try {
            const email = req.query.email;
            const result = await Patient.get_Nid(email);
            res.send(result);
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);
            res.status(500).send("An error occurred while fetching patients");
        }
    }
    static async getdocAdd(req, res) {
        try {
            

            const result = await Patient.get_docadd();
            if (result) {
                //
                console.log("Send a success response");
                res.send(result);
            } else {
                // Send a failure response
                
                res.send(null);
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async getAdddoctors(req, res) {
        try {
            
            var spec=req.query.spece
            const result = await Patient.get_toAdd_alldocs(spec,0);
            if (result) {
                //
                console.log("Send a success response");
                res.send(result);
            } else {
                // Send a failure response
                
                res.send(null);
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async getAlldoctors(req, res) {
        try {
            

            const result = await Patient.get_alldocs();
            if (result) {
                //
                console.log("Send a success response");
                res.send(result);
            } else {
                // Send a failure response
                
                res.send(null);
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async getAllpatients(req, res) {
        try {
            

            const result = await Patient.get_allpats();
            if (result) {
                //
                console.log("Send a success response");
                res.send(result);
            } else {
                // Send a failure response
                
                res.send(null);
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async getAllclinics(req, res) {
        try {
            

            const result = await Patient.get_allclics();
            if (result) {
                //
                console.log("Send a success response");
                res.send(result);
            } else {
                // Send a failure response
                
                res.send(null);
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
    static async addSlot(req, res) {
        try {
            var email = req.body.email
            var timerange = req.body.timerange
            var status = req.body.status
            const result = await Patient.add_slot(email,timerange,status);
            if (result === true) {
                res.send("added slot succesfully");

            } else {
                res.send("added not faild");
            }
        } catch (error) {
            // Handle any errors that occur during the database query or processing
            console.error(error);
            console.error("Error fetching patients:", error);

        }
    }
}

module.exports = PatientController;