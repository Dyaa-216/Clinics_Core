const router = require('express').Router();
const { json } = require('body-parser');
const patie = require("../controllers/userController");

//router.get("/allpat", patie.getAllPatients)
router.get("/", patie.getAll)

router.get("/all", (req, res) => {
    res.send('dsa')
})
//router.post("/addpat", patie.addUesr)
router.post("/vv", patie.addUesr)
router.post("/sign", patie.signinPateint)

// patient sign up 
router.post("/signUpPatient", patie.signUpPatient)

// Doctor sign up 
router.post("/signUpDoctor", patie.signUpDoctor)

// Clinic sign up 
router.post("/signUpClinic", patie.signUpClinic)


router.post("/logIn/pateint", patie.loginPateint)

// router.get("/pateintProfile", (req)=>{
//     console.log(req.body.email)
// })
router.get("/pateintProfile",  patie.getPatient)

router.post("/pateintUpdate",  patie.updatePatient)

router.post("/updateDoc2",  patie.updateDoc2)

router.post("/updateDoc01",  patie.updateDoc01)

router.get("/clinicCount",  patie.getcc)

router.get("/clinic",  patie.getClinic)

router.get("/getClinicn",  patie.getClinicn)

router.get("/getslot",  patie.getSlot)

router.get("/clinicdocs",  patie.getClinicDocs)

router.get("/getdoctor",  patie.getDoctor)

router.get("/pNots",  patie.getNot)

router.get("/getNots", patie.getdocPats)

router.get("/getdocAdds", patie.getdocAdd)

router.get("/getAlldoctors", patie.getAlldoctors)

router.get("/getAdddoctors", patie.getAdddoctors)

router.get("/getAllpatients", patie.getAllpatients)

router.get("/getAllclinics", patie.getAllclinics)

router.post("/addNot", patie.addNot)

router.post("/addApp", patie.addapp)

router.post("/rescedual", patie.rescedual)

router.post("/Confirm", patie.Confirm)

router.post("/addcldoc", patie.addcldoc)

router.post("/deleteApp", patie.deleteApp)

router.post("/deleteDc", patie.deleteDc)

router.post("/addPatdoc", patie.addPatdoc)

router.post("/addSlot", patie.addSlot)

router.get("/getNid", patie.getNid)

router.get("/getAppp", patie.getAppp)

router.get("/getAppe", patie.getAppe)

router.get("/getAppd", patie.getAppd)

router.get("/chatpy", function (req, res) {
    const message = req.query.message;
    var chat=""

    // Construct the URL with the encoded message as a query parameter
    const apiUrl = `http://127.0.0.1:5000/chatbot?dyaa=`+message;
 
    fetch(apiUrl)
        .then(response => {
            // Check if the request was successful
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json(); // Parse the JSON response
        })
        .then(data => {
            chat=data
            // Handle the data from the API
            res.send(data);
            
            
        })
        .catch(error => {
            console.error('Error fetching data:', error);
        });
// Handle the data from the API

})


module.exports = router;