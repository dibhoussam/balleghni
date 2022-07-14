import './user.css';
import PermIdentityIcon from '@mui/icons-material/PermIdentity';
import { Link } from 'react-router-dom';
import { useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';

import TextField from '@mui/material/TextField';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';
import CircularProgress from '@mui/material/CircularProgress';
import Button from '@mui/material/Button';
import EmailIcon from '@mui/icons-material/Email';
import LocationOnIcon from '@mui/icons-material/LocationOn';
import PermContactCalendarIcon from '@mui/icons-material/PermContactCalendar';


import { loadWilayas } from '../../../redux/actions/wilayasActions';
import { useState } from 'react';
import V from 'max-validator';
import { useForm } from "react-hook-form";
import { loadAuthoritieUsers, loadWilayaUsers, updateUser } from '../../../redux/actions/usersActions';
import { useHistory } from 'react-router-dom';





export default function User() {
  let validationScheme = {
    firstName: 'required|string|max:255',
    lastName: 'required|string|max:255',
    username: 'required|string|max:255',
    email: 'email',
    // wilaya: 'required|numeric',
  }
  const initialState = {
    valid: false,
    text: ""
  }
  const [wilayaError, setwilayaError] = useState(initialState)
  const [firstNameError, setfirstNameError] = useState(initialState)
  const [lastNameError, setlastNameError] = useState(initialState)
  const [emailError, setemailError] = useState(initialState)
  const [usernameError, setusernameError] = useState(initialState)
  const [ConfirmPass, setComfirmPass] = useState({
    valid: false,
    text: "le mot de passe ne correspond pas",
    display: "none",
    color: "red"
  })
  const [passState, setPassState] = useState({
    password: "",
    confirmPassword: ""
  })
  

  const userId = useParams().iserId;
  console.log(userId)
  const dispatch = useDispatch();
  let history = useHistory()

  const { register, handleSubmit } = useForm();
  const wilayas = useSelector(state => state.allWilayas.wilayas);
  const userInfo = useSelector(state => state.user.userInfo);
  const access = useSelector(state => state.user.user.access_token);

  let userDetail = useSelector(state => state.allUsers.users);
  let ar_name = ""
  
 
  
 
  useEffect(() => {
    console.log("useEffect");
  }, [userId])

  useEffect(() =>{
    if (userInfo.hasOwnProperty('authoritie')) {
        console.log("user has onw property authoritie");
        console.log(userInfo);
        dispatch(loadAuthoritieUsers(access,1));
        userDetail = userDetail.filter((item) => (item.id === userId))
        ar_name = wilayas
    }else
        dispatch(loadWilayaUsers(access,16))
        userDetail = userDetail.filter((item) => (item.id === userId))

        
        console.log(userDetail);
    
},[])

  useEffect(() => {
    dispatch(loadWilayas(access))
  }, [])

  const onSubmit = (data) => {
    //console.log(data);
    const result = V.validate(data, validationScheme)
    if (result.hasError) {
      console.log(result);
      //if (result.isError('wilaya'))
      // setwilayaError({ ...wilayaError, ["text"]: result.getError('wilaya'), ["valid"]: true })
      // else
      //  setwilayaError(initialState)

      if (result.isError('email'))
        setemailError({ ...emailError, ["text"]: result.getError('email'), ["valid"]: true })
      else
        setemailError(initialState)

      if (result.isError('firstName'))
        setfirstNameError({ ...firstNameError, ["text"]: result.getError('firstName'), ["valid"]: true })
      else
        setfirstNameError(initialState)

      if (result.isError('lastName'))
        setlastNameError({ ...lastNameError, ["text"]: result.getError('lastName'), ["valid"]: true })
      else
        setlastNameError(initialState)

      if (result.isError('username'))
        setusernameError({ ...usernameError, ["text"]: result.getError('username'), ["valid"]: true })
      else
        setusernameError(initialState)
    } else {
      console.log("succeeded");
      console.log(data);

      data.credentials = [
        {
          id: 1,
          type: "password",
          value: data.password,
          temporary: false
        }
      ]
      delete data.password

      let type = -1;
      console.log(userDetail);
      if (userDetail.length > 0) {
        if (userDetail[0].hasOwnProperty("authoritie")) {
          type = 1
        } else if (userDetail[0].hasOwnProperty("wilayaId")) {
          type = 2
        } else if (userDetail[0].hasOwnProperty("superadmin"))
          type = 3

        if (ConfirmPass.valid) {
          dispatch(updateUser(access, userId, data, type))
          history.push("/users")
          window.location.reload()
        }

      }

    }
  }

  const handleChange = (e) => {
    const v = e.target.value

    if (e.target.name === "confirmPassword") {
      if (v === passState.password) {
        setComfirmPass({
          ...ConfirmPass,
          valid: true,
          text: "mot de passe correspond",
          display: "block",
          color: "green"
        })
      } else {
        setComfirmPass({
          ...ConfirmPass,
          valid: false,
          text: "le mot de passe ne correspond pas",
          display: "block",
          color: "red"
        })

      }
    }
    if (e.target.name === "password") {
      if (v === passState.confirmPassword) {
        setComfirmPass({
          ...ConfirmPass,
          valid: true,
          text: "mot de passe correspond",
          display: "block",
          color: "green"
        })
      } else {
        setComfirmPass({
          ...ConfirmPass,
          valid: false,
          text: "le mot de passe ne correspond pas",
          display: "block",
          color: "red"
        })

      }
    }
    setPassState({
      ...passState,
      [e.target.name]: v
    })

  }




  return (
    <div className="user">
      {
      Object.keys(userDetail).length === 0 ? (
                    <>
                        <div style={{ textAlign: "center", height: "800px" }}>
                            <CircularProgress style={{ marginTop: "400px" }} />
                        </div></>
                ) : (
                  <>
      <div className="userTitleContainer">
        <h1 className="userTitle">Edit User</h1>
        <Link to="/newUser">
          <button className="userAddButton">Ajouter</button>
        </Link>
      </div>
      <div className="userContainer">
        <div className="userShow">
          <div className="userShowTop">
            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/2048px-User_icon_2.svg.png" alt="" className="userShowImg" />
            <div className="userShowTopTitle">
              <span className="userShowName">
                {userDetail[0].firstName} {userDetail[0].lastName}
              </span>
            </div>
          </div>
          <div className="userShowBottom">
            <span className="userShowTitle">Informations Personnelles</span>
            <div className="userShowInfo">
              <PermIdentityIcon className="userShowIcon" />
              <span className="userShowInfoTitle">First name : {userDetail[0].firstName}</span>
            </div>
            <div className="userShowInfo">
              <PermIdentityIcon className="userShowIcon" />
              <span className="userShowInfoTitle">Last name : {userDetail[0].lastName}</span>
            </div>
            <div className="userShowInfo">
              <EmailIcon className="userShowIcon" />
              <span className="userShowInfoTitle">Email : {userDetail[0].email}</span>
            </div>
            <div className="userShowInfo">
              <PermContactCalendarIcon className="userShowIcon" />
              <span className="userShowInfoTitle">Username : {userDetail[0].userName}</span>
            </div>
            <div className="userShowInfo">
              <LocationOnIcon className="userShowIcon" />
              <span className="userShowInfoTitle">
                 {userDetail[0].hasOwnProperty('wilayaId') && wilayas.length > 0 && <>Wilaya : {wilayas[userDetail[0].wilayaId-1].ar_name} </>  }
                {userDetail[0].hasOwnProperty('authoritie') && <>Authoritie : {userDetail[0].authoritie} </>}
              </span>
            </div>
          </div>
        </div>
        <div className="userUpdate">
          <span className="userUpdateTitle">Edit</span>
          <form className="newBranchForm" >
            <div className="newBranchLeft">

              <div className="newBranchItem">
                <TextField
                  {...register("email")}
                  id="outlined-basic"
                  label="Email"
                  type="email"
                  variant="outlined"
                  size='large'
                  name='email'
                  error={emailError.valid}
                  helperText={emailError.text}
                />
              </div>
              <div className="newBranchItem">
                <TextField
                  {...register("firstName")}
                  id="outlined-basic"
                  label="firstName"
                  variant="outlined"
                  size='large'
                  name='firstName'
                  error={firstNameError.valid}
                  helperText={firstNameError.text}
                />
              </div>
              <div className="newBranchItem">
                <TextField
                  {...register("lastName")}
                  id="outlined-basic"
                  label="lastName"
                  variant="outlined"
                  size='large'
                  name='lastName'
                  error={lastNameError.valid}
                  helperText={lastNameError.text}
                />
              </div>
              <div className="newBranchItem">
                <TextField
                  {...register("username")}
                  id="outlined-basic"
                  label="username"
                  variant="outlined"
                  size='large'
                  name='username'
                  error={usernameError.valid}
                  helperText={usernameError.text}
                />
              </div>

              <div className="newBranchItem">
                <TextField
                  {...register("password")}
                  id="outlined-basic"
                  label="password"
                  type="password"
                  variant="outlined"
                  size='large'
                  name='password'
                  onChange={handleChange}
                />
              </div>
              <div className="newBranchItem">
                <TextField
                  id="outlined-basic"
                  label="Comfirm password"
                  type="password"
                  variant="outlined"
                  size='large'
                  name='confirmPassword'
                  onChange={handleChange}
                />
              </div>
              <label for="" style={{ padding: "0px", margin: "0px", color: ConfirmPass.color, display: ConfirmPass.display }}>
                {ConfirmPass.text}
              </label>
              {/* 
              <div className="newBranchItem">
                <FormControl required sx={{ m: 0, minWidth: 120 }}>
                  <InputLabel id="demo-simple-select-required-label">Wilaya</InputLabel>
                  <Select
                    {...register("wilaya")}
                    labelId="demo-simple-select-required-label"
                    id="demo-simple-select-required"
                    label="Age *"
                    name="wilaya"

                  >
                    {
                      wilayas.map((index) => {

                        return (
                          <MenuItem key={index.id} value={index.id}>{index.id} - {index.ar_name}</MenuItem>
                        )
                      })
                    }
                  </Select>
                  <label for="" style={{ color: "red", fontSize: "13px", margin: "5px 0px 0px 15px" }}>{wilayaError.text}</label>
                </FormControl>
              </div>
              */}

              <div className="newBranchItem">
                <Button variant="contained" onClick={handleSubmit(onSubmit)}>Update</Button>
              </div>

            </div>



          </form>
        </div>
      </div>
      </> )
}
    </div>
  );
}
