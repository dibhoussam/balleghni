import "./newUser.css";


import TextField from '@mui/material/TextField';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';

import Button from '@mui/material/Button';

import { useDispatch, useSelector } from 'react-redux';
import { useEffect } from 'react';
import { loadWilayas } from '../../../redux/actions/wilayasActions';
import { addUser, loadAuthoritieUsers, loadWilayaUsers } from '../../../redux/actions/usersActions'
import { useState } from 'react';
import V from 'max-validator';
import { addBranch } from '../../../redux/actions/branchsActions'; 
import { useForm } from "react-hook-form";
import { useHistory } from "react-router-dom";

export default function NewUser() { 

    let history = useHistory()
    let validationScheme = {
        firstName: 'required|string|max:255',
        lastName: 'required|string|max:255',
        username: 'required|string|max:255',
        email: 'email',
       
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

    const { register, handleSubmit } = useForm();
    const wilayas = useSelector(state => state.allWilayas.wilayas);
    const userInfo = useSelector(state => state.user.userInfo);
    const access = useSelector(state => state.user.user.access_token);
    const dispatch = useDispatch()


    useEffect(() => {
        dispatch(loadWilayas(access))
      }, [])

    const onSubmit = (data) => {
        const result = V.validate(data, validationScheme)
    if (result.hasError) {
      console.log(result);
      

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
      setuserNameError({ ...usernameError, ["text"]: result.getError('username'), ["valid"]: true })
    else
      setuserNameError(initialState)
    }else{

      console.log("succeeded");
      console.log(data);
      if (data.hasOwnProperty("authoritie")) {
        data.attributes = {"authoritie" : Number(userInfo.authoritie)}
        data.groups = ["authoritie-admin"]
        delete data.authoritie
      }else if (data.hasOwnProperty("wilaya")) {
        data.attributes = {"wilaya" : Number(userInfo.wilaya)}
        data.groups = ["wilaya-admin"]
        delete data.wilaya
      }
      data.enabled = true
      data.credentials = [
        {
          id : 1,
          type : "password",
          value : data.password,
          temporary : false
        }
      ]
      delete data.password
      data.realmRoles=["admin"]
       

 
      dispatch(addUser(access,data))
      
      history.replace("/users")
      window.location.reload()

    }
    }

  return (
    <div className="newBranch">
      <div className="newBranchTitleContainer">
        <h1 className="newBranchTitle">New User</h1>
      </div>

      <form className="newBranchForm" >
        <div className="newBranchLeft">

        

          <div className="newBranchItem">
            {
              userInfo.hasOwnProperty("wilaya") && <>
                  <TextField
              {...register("wilaya")}
              id="outlined-basic"
              
              type="text"
              value={Number(userInfo.wilaya)}
              variant="outlined"
              size='large'
              name='wilaya'
              disabled
              error={wilayaError.valid}
              helperText={wilayaError.text}
            />
              </> 
            }
            {
              userInfo.hasOwnProperty("authoritie") && <>
                  <TextField
              {...register("authoritie")}
              id="outlined-basic"
              
              type="text"
              value={Number(userInfo.authoritie)}
              variant="outlined"
              size='large'
              name='authoritie'
              disabled
              error={wilayaError.valid}
              helperText={wilayaError.text}
            />
              </> 
            }     
          </div>

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
              label="userName"
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
            />
          </div>
          
          <Button variant="contained" onClick={handleSubmit(onSubmit)}>Creer</Button>
        </div>
        
        
      </form>
    </div>
  );
}
