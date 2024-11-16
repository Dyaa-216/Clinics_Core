const db = require("../config/db")

class patient {

    
    static async gettest() {
        return new Promise(resolve => {
            db.query("SELECT * FROM test", [], (err, res) => {
                if (!err) {
                    resolve(res)
                }
            })
        })
    }
    static async adduser(dd,yy, aa) {
        return new Promise(resolve => {
            db.query("INSERT INTO test(dd, yy, aa) VALUES (?,?,?)", [dd,yy, aa], (err, res) => {
                if (!err) {
                    resolve(true)
                    console.log("message: " + "sssssssss")
    
                } else {
                    console.log("message: " + err)
                    resolve(false)
                }
            })
        })
    }
    
    static async signin_pateint(id,email, password) {
        return new Promise(resolve => {
            db.query("INSERT INTO user(id, email, password) VALUES (?,?,?)", [id,email, password], (err, res) => {
                if (!err) {
                    resolve(true)
                    console.log("message: " + "sssssssss")
    
                } else {
                    console.log("message: " + err)
                    resolve(false)
                }
            })
        })
    }
    static async signUP_pateint(id, email, name,Nid, password, phone_num, age, weight, gender) {
        return new Promise(resolve => {
            db.query("INSERT INTO user(id, email, password) VALUES (?,?,?)", [id,email, password], (err, res) => {
                if (!err) {
                    resolve(true)
                    console.log("message: " + "user inserted")
    
                } else {
                    console.log("message: " + err)
                    resolve(false)
                }
            })
            db.query("INSERT INTO pat(id, email, name, Nid, phone_num, age, weight, gender) VALUES (?,?,?,?,?,?,?,?)", [id, email, name, Nid,phone_num, age, weight, gender], (err, res) => {
                if (!err) {
                    resolve(true)
                    console.log("message: " + "pat inserted")
    
                } else {
                    console.log("message: " + err)
                    resolve(false)
                }
            })
            
        })
    }
    
    static async signUP_doctor(id, email, password, name, phone_num, Specialization) {
        return new Promise(resolve => {
            db.query("INSERT INTO user(id, email, password) VALUES (?,?,?)", [id,email, password], (err, res) => {
                if (!err) {
                    resolve(true)
                    console.log("message: " + "user inserted")
    
                } else {
                    console.log("message: " + err)
                    resolve(false)
                }
            })
            db.query("INSERT INTO doctor(id, email, name, phone_num, Specialization,status) VALUES (?,?,?,?,?,?)", [id, email, name, phone_num, Specialization,0], (err, res) => {
                if (!err) {
                    resolve(true)
                    console.log("message: " + "doc inserted")
    
                } else {
                    console.log("message: " + err)
                    resolve(false)
                }
            })
            
        })
    }

    static async signUp_Clinic(id, email, password, name, phone_num, address ,timerange,Specialization,deamil) {
        return new Promise(resolve => {
            
            db.query("INSERT INTO clinic(id, email, name, phone_num, address, time_range, Specialization,deamil) VALUES (?,?,?,?,?,?,?,?)", [id, email, name, phone_num,address, timerange, Specialization,deamil], (err, res) => {
                if (!err) {
                    resolve(true)
                    console.log("message: " + "clinic inserted")
    
                } else {
                    console.log("message: " + err)
                    resolve(false)
                }
            })
            
        })
    }

    static async login_pateint(email,password) {
        return new Promise(resolve => {
            db.query("SELECT * FROM `user` WHERE email = ? AND password = ?", [email,password], (err, res) => {
                console.error("res:",res);
                if (err) {
                    //console.error("Error during database query:", err);
                    resolve(false); // Handle the database error and resolve with false
                } else {
                    if (res.length > 0) {
                        // User exists, resolve with true
                        //console.error("res1:",res);
                        resolve(res);
                    } else {
                        // User not found, resolve with false
                        //console.error("res2:",res);
                        resolve(false);
                    }
                }
            })
        })
    }

    static async get_patient(email) {
        return new Promise(resolve => {
            db.query("SELECT * FROM `pat` WHERE email = ?", [email], (err, res) => {
                console.error("res:",res);
                if (err) {
                    //console.error("Error during database query:", err);
                    resolve(false); // Handle the database error and resolve with false
                } else {
                    if (res.length > 0) {
                        // User exists, resolve with true
                        //console.error("res1:",res);
                        resolve(res);
                    } else {
                        // User not found, resolve with false
                        //console.error("res2:",res);
                        resolve(false);
                    }
                }
            })
        })

    }
    static async update_patient(email, name,Nid, phone_num, age, weight, gender) {
        return new Promise(resolve => {
            console.log(`Updating patient with email: ${email} and gender: ${gender}`);
            db.query(
                "UPDATE pat SET name = ?, Nid = ?, phone_num = ?, age = ?, weight = ?, gender = ? WHERE email = ?;",
                [email, name,Nid, phone_num, age, weight, gender],
                (err, res) => {
                    if (!err) {
                        console.log("Result: ", res);
                        if (res.affectedRows > 0) {
                            console.log("Patient updated successfully");
                            resolve(true);
                        } else {
                            console.log("No matching patient found to update");
                            resolve(false);
                        }
                    } else {
                        console.log("Error in update: ", err);
                        resolve(false);
                    }
                }
            );
        });
    }
    


    static async getcC(Specialization) {
        return new Promise(resolve => {
            db.query("SELECT COUNT(*) AS count FROM clinic WHERE Specialization = ?", [Specialization], (err, res) => {
                if (!err) {
                    resolve(res)
                }
            })
        })
    }
    static async getclinic(Specialization) {
        return new Promise(resolve => {
            db.query("SELECT * FROM clinic WHERE Specialization = ?", [Specialization], (err, res) => {
                if (!err) {
                    resolve(res)
                }
            })
        })
    }
    static async getclinicn(deamil) {
        return new Promise(resolve => {
            db.query("SELECT * FROM clinic WHERE deamil = ?", [deamil], (err, res) => {
                if (!err) {
                    resolve(res)
                }
            })
        })
    }
    
    static async getslot(email) {
        return new Promise(resolve => {
            db.query("SELECT * FROM `appointments` WHERE pat_email = ?", [email], (err, res) => {
                if (!err) {
                    resolve(res)
                }
            })
        })
    }
    static async getclinicDoc(clinicEmail) {
        return new Promise(resolve => {
            db.query("SELECT `doc_email` FROM `clinic_docs` WHERE cl_email = ?", [clinicEmail], (err, res) => {
                if (!err) {
                    resolve(res)
                }
            })
        })
    }
    static async get_doctor(email) {
        return new Promise(resolve => {
            db.query("SELECT * FROM doctor WHERE email = ?", [email], (err, res) => {
                console.error("res:",res);
                if (err) {
                    //console.error("Error during database query:", err);
                    resolve(false); // Handle the database error and resolve with false
                } else {
                    if (res.length > 0) {
                        // User exists, resolve with true
                        //console.error("res1:",res);
                        resolve(res);
                    } else {
                        // User not found, resolve with false
                        //console.error("res2:",res);
                        resolve(false);
                    }
                }
            })
        })

    }

    static async getnotifications(receiver) {
        return new Promise(resolve => {
            db.query("SELECT * FROM notifications WHERE receiver = ?", [receiver], (err, res) => {
                if (!err) {
                    resolve(res)
                }
            })
        })
    }
    static async getappp(pat_email,complete) {
        return new Promise(resolve => {
            db.query("SELECT * FROM `appointments` WHERE pat_email = ? AND complete = ?", [pat_email,complete], (err, res) => {
                if (!err) {
                    resolve(res)
                }
            })
        })
    }

    static async getapppd(doc_email,complete) {
        return new Promise(resolve => {
            db.query("SELECT * FROM `appointments` WHERE doc_email = ? AND complete = ?", [doc_email,complete], (err, res) => {
                if (!err) {
                    resolve(res)
                }
            })
        })
    }

    static async getappe(cl_email) {
        return new Promise(resolve => {
            db.query("SELECT * FROM `appointments` WHERE cl_name = ?", [cl_email], (err, res) => {
                if (!err) {
                    resolve(res)
                }
            })
        })
    }
    static async getappd(doc_email,complete) {
        return new Promise(resolve => {
            db.query("SELECT * FROM `appointments` WHERE doc_email = ? AND complete = ?", [doc_email,complete], (err, res) => {
                if (!err) {
                    resolve(res)
                }
            })
        })
    }
    static async get_docPats(email) {
        return new Promise(resolve => {
            db.query("SELECT * FROM `doc_pats` WHERE doc_email = ?", [email], (err, res) => {
                console.error("res:",res);
                if (err) {
                    //console.error("Error during database query:", err);
                    resolve(false); // Handle the database error and resolve with false
                } else {
                    if (res.length > 0) {
                        // User exists, resolve with true
                        //console.error("res1:",res);
                        resolve(res);
                    } else {
                        // User not found, resolve with false
                        //console.error("res2:",res);
                        resolve(false);
                    }
                }
            })
        })

    }
    static async add_not(sender,receiver,sname,rname,contents,time) {
        return new Promise(resolve => {
            db.query("INSERT INTO `notifications`(`sender`, `receiver`, `sname`, `rname`, `content`, `time`) VALUES (?,?,?,?,?,?)", [sender,receiver,sname,rname,contents,time], (err, res) => {
                if (!err) {
                    resolve(true)
                    console.log("message: " + "user inserted")
    
                } else {
                    console.log("message: " + err)
                    resolve(false)
                }
            })
            
            
        })
    }
    static async add_aptdoc(doc_email,pat_email,pat_name) {
        return new Promise(resolve => {
            db.query("INSERT INTO `doc_pats`(`doc_email`, `pat_email`, `pat_name`) VALUES (?,?,?)", [doc_email,pat_email,pat_name], (err, res) => {
                if (!err) {
                    resolve(true)
                    console.log("message: " + "user inserted")
    
                } else {
                    console.log("message: " + err)
                    resolve(false)
                }
            })
            
            
        })
    }
    static async add_app(doc_name,doc_email,pat_email,date,complete,cln) {
        console.log("doc_name:" +doc_name)
        console.log("doc_email:" +doc_email)
        return new Promise(resolve => {
            db.query("INSERT INTO `appointments`(`doc_name`, `doc_email`,`pat_email`, `date`, `complete`, `cl_name`) VALUES (?,?,?,?,?,?)", [doc_name,doc_email,pat_email,date,complete,cln], (err, res) => {
                if (!err) {
                    resolve(true)
                    console.log("message: " + "user inserted")
    
                } else {
                    console.log("message: " + err)
                    resolve(false)
                }
            })
            
            
        })
    }
    static async add_cldoc(cl_email,doc_email) {
        return new Promise(resolve => {
            db.query("INSERT INTO `clinic_docs`(`cl_email`, `doc_email`) VALUES (?,?)", [cl_email,doc_email], (err, res) => {
                if (!err) {
                    resolve(true)
                    console.log("message: " + "doccl inserted")
    
                } else {
                    console.log("message: " + err)
                    resolve(false)
                }
            })
            
            
        })
    }
    static async delete_app(id) {
        return new Promise(resolve => {
            db.query("DELETE FROM `appointments` WHERE appointments.id = ?", [id], (err, res) => {
                if (!err) {
                    resolve(true)
                    console.log("message: " + "doccl inserted")
    
                } else {
                    console.log("message: " + err)
                    resolve(false)
                }
            })
            
            
        })
    }
    static async delete_cd(email) {
        return new Promise(resolve => {
            db.query("DELETE FROM clinic_docs WHERE `clinic_docs`.`doc_email` = ?", [email], (err, res) => {
                if (!err) {
                    resolve(true)
                    console.log("message: " + "doccl inserted")
    
                } else {
                    console.log("message: " + err)
                    resolve(false)
                }
            })
            
            
        })
    }
    static async add_slot(email,timerange,status) {
        return new Promise(resolve => {
            db.query("INSERT INTO `time_slot`(`email`, `timerange`, `status`) VALUES (?,?,?)", [email,timerange,status], (err, res) => {
                if (!err) {
                    resolve(true)
                    console.log("message: " + "user inserted")
    
                } else {
                    console.log("message: " + err)
                    resolve(false)
                }
            })
            
            
        })
    }
    static async get_Nid(email) {
        return new Promise(resolve => {
            db.query("SELECT Nid FROM pat WHERE email = ?", [email], (err, res) => {
                console.error("res:",res);
                if (err) {
                    //console.error("Error during database query:", err);
                    resolve(false); // Handle the database error and resolve with false
                } else {
                    if (res.length > 0) {
                        // User exists, resolve with true
                        //console.error("res1:",res);
                        resolve(res);
                    } else {
                        // User not found, resolve with false
                        //console.error("res2:",res);
                        resolve(false);
                    }
                }
            })
        })

    }
    static async get_docadd() {
        return new Promise(resolve => {
            db.query("SELECT * FROM `doctor` WHERE status = ?", [0], (err, res) => {
                console.error("res:",res);
                if (err) {
                    //console.error("Error during database query:", err);
                    resolve(false); // Handle the database error and resolve with false
                } else {
                    if (res.length > 0) {
                        // User exists, resolve with true
                        //console.error("res1:",res);
                        resolve(res);
                    } else {
                        // User not found, resolve with false
                        //console.error("res2:",res);
                        resolve(false);
                    }
                }
            })
        })

    }
    static async get_toAdd_alldocs(spec,stat) {
        return new Promise(resolve => {
            db.query("SELECT * FROM `doctor` WHERE Specialization = ? AND status = ?", [spec,stat], (err, res) => {
                console.error("res:",res);
                if (err) {
                    //console.error("Error during database query:", err);
                    resolve(false); // Handle the database error and resolve with false
                } else {
                    if (res.length > 0) {
                        // User exists, resolve with true
                        //console.error("res1:",res);
                        resolve(res);
                    } else {
                        // User not found, resolve with false
                        //console.error("res2:",res);
                        resolve(false);
                    }
                }
            })
        })

    }
    static async get_alldocs() {
        return new Promise(resolve => {
            db.query("SELECT * FROM `doctor`", [0], (err, res) => {
                console.error("res:",res);
                if (err) {
                    //console.error("Error during database query:", err);
                    resolve(false); // Handle the database error and resolve with false
                } else {
                    if (res.length > 0) {
                        // User exists, resolve with true
                        //console.error("res1:",res);
                        resolve(res);
                    } else {
                        // User not found, resolve with false
                        //console.error("res2:",res);
                        resolve(false);
                    }
                }
            })
        })

    }
    static async get_allpats() {
        return new Promise(resolve => {
            db.query("SELECT * FROM `pat`", [0], (err, res) => {
                console.error("res:",res);
                if (err) {
                    //console.error("Error during database query:", err);
                    resolve(false); // Handle the database error and resolve with false
                } else {
                    if (res.length > 0) {
                        // User exists, resolve with true
                        //console.error("res1:",res);
                        resolve(res);
                    } else {
                        // User not found, resolve with false
                        //console.error("res2:",res);
                        resolve(false);
                    }
                }
            })
        })

    }
    static async get_allclics() {
        return new Promise(resolve => {
            db.query("SELECT * FROM `clinic`", [0], (err, res) => {
                console.error("res:",res);
                if (err) {
                    //console.error("Error during database query:", err);
                    resolve(false); // Handle the database error and resolve with false
                } else {
                    if (res.length > 0) {
                        // User exists, resolve with true
                        //console.error("res1:",res);
                        resolve(res);
                    } else {
                        // User not found, resolve with false
                        //console.error("res2:",res);
                        resolve(false);
                    }
                }
            })
        })

    }
    static async update_doc2(email,timerange) {
        return new Promise(resolve => {
            db.query(
                "UPDATE `doctor` SET `status` = '2', `time_range` = ?  WHERE `doctor`.`email` = ?",
                [timerange,email],
                (err, res) => {
                    if (!err) {
                        console.log("Result: ", res);
                        if (res.affectedRows > 0) {
                            console.log("Doctor updated successfully");
                            resolve(true);
                        } else {
                            console.log("No matching Doctor found to update");
                            resolve(false);
                        }
                    } else {
                        console.log("Error in update: ", err);
                        resolve(false);
                    }
                }
            );
        });
    }
    static async update_doc01(email,status) {
        return new Promise(resolve => {
            db.query(
                "UPDATE `doctor` SET `status` = ?  WHERE `doctor`.`email` = ?",
                [status,email],
                (err, res) => {
                    if (!err) {
                        console.log("Result: ", res);
                        if (res.affectedRows > 0) {
                            console.log("Doctor updated successfully");
                            resolve(true);
                        } else {
                            console.log("No matching Doctor found to update");
                            resolve(false);
                        }
                    } else {
                        console.log("Error in update: ", err);
                        resolve(false);
                    }
                }
            );
        });
    }
    static async update_resced(date,id) {
        return new Promise(resolve => {
            db.query(
                "UPDATE `appointments` SET `date` = ? WHERE `appointments`.`id` = ?",
                [date,id],
                (err, res) => {
                    if (!err) {
                        console.log("Result: ", res);
                        if (res.affectedRows > 0) {
                            console.log("aPP updated successfully");
                            resolve(true);
                        } else {
                            console.log("No matching Doctor found to update");
                            resolve(false);
                        }
                    } else {
                        console.log("Error in update: ", err);
                        resolve(false);
                    }
                }
            );
        });
    }

    
    static async update_cmp(complete,id) {
        return new Promise(resolve => {
            db.query(
                "UPDATE `appointments` SET `complete` = ? WHERE `appointments`.`id` = ?",
                [complete,id],
                (err, res) => {
                    if (!err) {
                        console.log("Result: ", res);
                        if (res.affectedRows > 0) {
                            console.log("aPP updated successfully");
                            resolve(true);
                        } else {
                            console.log("No matching Doctor found to update");
                            resolve(false);
                        }
                    } else {
                        console.log("Error in update: ", err);
                        resolve(false);
                    }
                }
            );
        });
    }
}
    

module.exports = patient;