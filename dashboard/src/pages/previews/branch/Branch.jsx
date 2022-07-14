import React from 'react'
import './branch.css';
import PermIdentityIcon from '@mui/icons-material/PermIdentity';
import { Link } from 'react-router-dom';
import { useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { getBranch, updateBranch } from '../../../redux/actions/branchsActions';

import TextField from '@mui/material/TextField';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';
import Radio from '@mui/material/Radio';
import RadioGroup from '@mui/material/RadioGroup';
import FormControlLabel from '@mui/material/FormControlLabel';
import FormLabel from '@mui/material/FormLabel';
import InputAdornment from '@mui/material/InputAdornment';
import PhoneIcon from '@mui/icons-material/Phone';
import { loadWilayas } from '../../../redux/actions/wilayasActions';
import { useState } from 'react';
import V from 'max-validator';
import { addBranch } from '../../../redux/actions/branchsActions';
import CircularProgress from '@mui/material/CircularProgress';
import { useForm } from "react-hook-form";



export default function Branch() {
  const dispatch = useDispatch();
  const branch = useSelector(state => state.allBranchs.branch);
  const userInfo = useSelector(state => state.user.userInfo);
  const access = useSelector(state => state.user.user.access_token);
  const id = useParams().branchId
  const wilayas = useSelector(state => state.allWilayas.wilayas);
  useEffect(() => {
    dispatch(loadWilayas(access))
  }, [])

  useEffect(() => {
    dispatch(getBranch(access, id))
  }, [id])

  const { register, handleSubmit } = useForm();

  //console.log(branch);

  const [isDg,setIsDg] = useState(null)
  const [dairas, setDairas] = useState([]);
  const [communes, setCommunes] = useState([]);
  
  /* ############################################ ERRORS ##################################################### */
  let validationScheme = {
    authoritie_id: 'required|numeric',
    dg: 'required',
    map_link: 'url|nullable',
    email: 'email',
    commune_id: 'required|numeric',
    daira_id: 'required|numeric',
    wilaya_id: 'required|numeric',
    address: 'required|string|max:255|',
    phone1: 'required|string|min:10|max:10|',
    phone2: 'string|min:10|max:10|nullable',
    phone3: 'string|min:10|max:10|nullable',
    phone4: 'string|min:10|max:10|nullable',
    slug: 'required|string|max:255|',
    descriptionPhone1: 'required|string|max:100',
    descriptionPhone2: 'string|max:100',
    descriptionPhone3: 'string|max:100',
    descriptionPhone4: 'string|max:100',
  }
  const initialState = {
    valid: false,
    text: ""
  }
  const [wilayaError, setwilayaError] = useState(initialState)
  const [dairaError, setdairaError] = useState(initialState)
  const [communeError, setcommuneError] = useState(initialState)
  const [emailError, setemailError] = useState(initialState)
  const [addressError, setaddressError] = useState(initialState)
  const [mapLinkError, setmapLinkError] = useState(initialState)
  const [phone1Error, setphone1Error] = useState(initialState)
  const [phone2Error, setphone2Error] = useState(initialState)
  const [phone3Error, setphone3Error] = useState(initialState)
  const [phone4Error, setphone4Error] = useState(initialState)
  const [slugError, setslugError] = useState(initialState)
  const [descriptionPhone1Error, setdescriptionPhone1Error] = useState(initialState)
  const [descriptionPhone2Error, setdescriptionPhone2Error] = useState(initialState)
  const [descriptionPhone3Error, setdescriptionPhone3Error] = useState(initialState)
  const [descriptionPhone4Error, setdescriptionPhone4Error] = useState(initialState)


  /* ############################################ ERRORS ##################################################### */
  const onSubmit = (data) => {
    
    //data.authoritie_id = Number(userInfo.authoritie)
    const result = V.validate(data, validationScheme)
    if (result.hasError) {
      console.log(result);

    if (result.isError('wilaya_id'))
      setwilayaError({ ...wilayaError, ["text"]: result.getError('wilaya_id'), ["valid"]: true })
    else
      setwilayaError(initialState)

    if (result.isError('daira_id'))
      setdairaError({ ...dairaError, ["text"]: result.getError('daira_id'), ["valid"]: true })
    else
      setdairaError(initialState)

    if (result.isError('commune_id'))
      setcommuneError({ ...communeError, ["text"]: result.getError('commune_id'), ["valid"]: true })
    else
      setcommuneError(initialState)

    if (result.isError('email'))
      setemailError({ ...emailError, ["text"]: result.getError('email'), ["valid"]: true })
    else
      setemailError(initialState)


    if (result.isError('address'))
      setaddressError({...addressError, ["text"]: result.getError('address'), ["valid"]: true })
    else
      setaddressError(initialState)

    if (result.isError('map_link'))
      setmapLinkError({ ...mapLinkError, ["text"]: result.getError('map_link'), ["valid"]: true })
    else
      setmapLinkError(initialState)

    if (result.isError('phone1'))
      setphone1Error({ ...phone1Error, ["text"]: result.getError('phone1'), ["valid"]: true })
    else
      setphone1Error(initialState)

    if (result.isError('phone2'))
      setphone2Error({ ...phone2Error, ["text"]: result.getError('phone2'), ["valid"]: true })
    else
      setphone2Error(initialState)

    if (result.isError('phone3'))
      setphone3Error({ ...phone3Error, ["text"]: result.getError('phone3'), ["valid"]: true })
    else
      setphone3Error(initialState)

    if (result.isError('phone4'))
      setphone4Error({ ...phone4Error, ["text"]: result.getError('phone4'), ["valid"]: true })
    else
      setphone4Error(initialState)

    if (result.isError('slug'))
      setslugError({ ...slugError, ["text"]: result.getError('slug'), ["valid"]: true })
    else
      setslugError(initialState)

      if (result.isError('descriptionPhone1'))
      setdescriptionPhone1Error({ ...descriptionPhone1Error, ["text"]: result.getError('descriptionPhone1'), ["valid"]: true })
    else
      setdescriptionPhone1Error(initialState)

      if (result.isError('descriptionPhone2'))
      setdescriptionPhone2Error({ ...descriptionPhone2Error, ["text"]: result.getError('descriptionPhone2'), ["valid"]: true })
    else
      setdescriptionPhone2Error(initialState)

      if (result.isError('descriptionPhone3'))
      setdescriptionPhone3Error({ ...descriptionPhone3Error, ["text"]: result.getError('descriptionPhone3'), ["valid"]: true })
    else
      setdescriptionPhone3Error(initialState)

      if (result.isError('descriptionPhone4'))
      setdescriptionPhone4Error({ ...descriptionPhone4Error, ["text"]: result.getError('descriptionPhone4'), ["valid"]: true })
    else
      setdescriptionPhone4Error(initialState)

    }else{
      let phones = []
      if (data.phone1.length === 10) {
        phones.push({"phone":data.phone1,"description":data.descriptionPhone1})
      }
      if (data.phone2.length === 10) {
        phones.push({"phone":data.phone2,"description":data.descriptionPhone2})
      }
      if (data.phone3.length === 10) {
        phones.push({"phone":data.phone3,"description":data.descriptionPhone3})
      }
      if (data.phone4.length === 10) {
        phones.push({"phone":data.phone4,"description":data.descriptionPhone4})
      }
      data.phones = phones
      data.dg = (isDg)
      console.log(data);
      
 
      
      delete data.phone1
      delete data.descriptionPhone2
      delete data.descriptionPhone3
      delete data.descriptionPhone4
      delete data.descriptionPhone1
      delete data.phone2
      delete data.phone3
      delete data.phone4  
      
      dispatch(updateBranch(access,id,data))
    }

    console.log("-------------------------------------");
    //console.log(state);
    console.log("-------------------------------------");
  } 

  const handleChange = e => {
    const value = e.target.value;
    

    if (e.target.name === "wilaya_id") {
      setDairas(wilayas[value - 1].dairas)
      setCommunes([])
      setwilayaError(initialState)
    }

    if (e.target.name === "daira_id") {
      dairas.map((index) => {
        if (index.id === value) {
          setCommunes(index.communes)
        }
      })
    }

    if (e.target.name === "dg") {
      setIsDg(e.target.value === "true")
    }
  }

  return (
    
    <div className="branch">
      {
                Object.keys(branch).length === 0 ? (
                    <>
                        <div style={{ textAlign: "center", height: "800px" }}>
                            <CircularProgress style={{ marginTop: "400px" }} />
                        </div></>
                ) : ( <>
      <div className="branchTitleContainer">
        <h1 className="branchTitle">Edit Branch</h1>
        <Link to="/newBranch">
          <button className="branchAddButton">Ajouter</button>
        </Link>
      </div>
      <div className="branchContainer">
        <div className="branchShow">
          <div className="branchShowTop">
            <img src={branch.authoritie.logo} alt="" className="branchShowImg" />
            <div className="branchShowTopTitle">
              <span className="branchShowName">
                {branch.authoritie.name} authoritie 
              </span>
            </div>
          </div>
          <div className="branchShowBottom">
            <span className="branchShowTitle">Slug & Description</span>
            <div className="branchShowInfo">
              <PermIdentityIcon className="branchShowIcon" />
              <span className="branchShowInfoTitle">{branch.authoritie.slug}</span>
            </div>
            <div className="branchShowInfo">
              <PermIdentityIcon className="branchShowIcon" />
              <span className="branchShowInfoTitle">{branch.authoritie.description}</span>
            </div>
            
            
            <span className="branchShowTitle">Contact Details</span>
            <div className="branchShowInfo">
              <PermIdentityIcon className="branchShowIcon" />
              <span className="branchShowInfoTitle">{branch.email}</span>
            </div>
            <div className="branchShowInfo">
              <PermIdentityIcon className="branchShowIcon" />
              <span className="branchShowInfoTitle">{branch.location.address}</span>
            </div>
            <div className="branchShowInfo">
              <PermIdentityIcon className="branchShowIcon" />
              <span className="branchShowInfoTitle">{branch.location.commune.ar_name} - {branch.location.daira.ar_name} - {branch.location.wilaya.ar_name}</span>
            </div>
            <div className="branchShowInfo">
              <PermIdentityIcon className="branchShowIcon" />
              <span className="branchShowInfoTitle">{branch.phones.map((index)=>{
                  return(
                    index.description + " - "
                  )
              })}</span>
            </div>
          </div>
        </div>
        <div className="userUpdate">
          <span className="userUpdateTitle">Edit</span>
          <form className="updateAuthoritieForm" onSubmit={handleSubmit(onSubmit)}>
            <div className="newBranchLeft">
              <div className="newBranchItem">
                <TextField
                {...register("authoritie_id")}
                  id="outlined-basic"
                  type="text"
                  variant="outlined"
                  size='large'
                  name='authoritie'
                  value = {branch.authoritie.id}
                  error={emailError.valid}
                  helperText={emailError.text}
                  onChange={handleChange}
                  defaultValue={branch.authoritie.id}
                  
                />
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
                  onChange={handleChange}
                />
              </div>
              <div className="newBranchItem">
                <TextField
                {...register("slug")}
                  id="outlined-basic"
                  label="Slug"
                  variant="outlined"
                  size='large'
                  name='slug'
                  error={slugError.valid}
                  helperText={slugError.text}
                  onChange={handleChange}
                />
              </div>
              
              <div className="newBranchItem">
                <TextField
                {...register("map_link")}
                  id="outlined-basic"
                  label="Map link"
                  type="text"
                  variant="outlined"
                  size='large'
                  name='map_link'
                  error={mapLinkError.valid}
                  helperText={mapLinkError.text}
                  onChange={handleChange}
                />
              </div>
              <div className="newBranchItem">
                <TextField
                {...register("address")}
                  id="outlined-basic"
                  label="Address"
                  variant="outlined"
                  size='large'
                  name='address'
                  error={addressError.valid}
                  helperText={addressError.text}
                  onChange={handleChange}
                />
              </div>
              <div className="newBranchItem">
                <FormControl required sx={{ m: 0, minWidth: 120 }}>
                  <InputLabel id="demo-simple-select-required-label">Wilaya</InputLabel>
                  <Select
                  {...register("wilaya_id")}
                    labelId="demo-simple-select-required-label"
                    id="demo-simple-select-required"
                    label="Age *"
                    name="wilaya_id"
                    onChange={handleChange}
                    error={wilayaError.valid}

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
              <div className="newBranchItem">
                <FormControl required sx={{ m: 0, minWidth: 120 }}>
                  <InputLabel id="demo-simple-select-required-label">Daira</InputLabel>
                  <Select
                  {...register("daira_id")}
                    labelId="demo-simple-select-required-label"
                    id="demo-simple-select-required"
                    label="Age *"
                    name="daira_id"
                    onChange={handleChange}
                    error={dairaError.valid}
                  >
                    {
                      dairas.map((index) => {

                        return (
                          <MenuItem key={index.id} value={index.id}>{index.id} - {index.ar_name}</MenuItem>
                        )
                      })
                    }
                  </Select>
                  <label for="" style={{ color: "red", fontSize: "13px", margin: "5px 0px 0px 15px" }}>{dairaError.text}</label>
                </FormControl>
              </div>
              <div className="newBranchItem">
                <FormControl required sx={{ m: 0, minWidth: 120 }}>
                  <InputLabel id="demo-simple-select-required-label">Commune</InputLabel>
                  <Select
                  {...register("commune_id")}
                    labelId="demo-simple-select-required-label"
                    id="demo-simple-select-required"
                    label="Commune"
                    name="commune_id"
                    onChange={handleChange}
                    error={communeError.valid}
                  >

                    {
                      communes.map((index) => {
                        return (
                          <MenuItem key={index.id} value={index.id}>{index.id} - {index.ar_name}</MenuItem>
                        )
                      })
                    }
                  </Select>
                  <label for="" style={{ color: "red", fontSize: "13px", margin: "5px 0px 0px 15px" }}>{communeError.text}</label>
                </FormControl>
              </div>



              <button className="newBranchButton" >Update</button>
            </div>
            <div className="newBranchRight">
            <div className="newBranchItem">
                <FormControl>
                  <FormLabel id="demo-row-radio-buttons-group-label">Direction generale</FormLabel>
                  <RadioGroup
                    row
                    aria-labelledby="demo-row-radio-buttons-group-label"
                    name="dg"
                    onChange={handleChange}
                  >
                    <FormControlLabel value={true} control={<Radio />} label="Oui" />
                    <FormControlLabel value={false} control={<Radio />} label="Non" />
                  </RadioGroup>
                </FormControl>
              </div>
              
              <div className="newBranchItem" >
                <TextField
                {...register("phone1")}
                  id="input-with-icon-textfield"
                  label="phone 1"
                  InputProps={{
                    startAdornment: (
                      <InputAdornment position="start">
                        <PhoneIcon />
                      </InputAdornment>
                    ),
                  }}
                  type="number"
                  variant="outlined"
                  name='phone1'
                  error={phone1Error.valid}
                  helperText={phone1Error.text}
                  onChange={handleChange}
                />
              </div>
              <div className="newBranchItem">
                <TextField
                {...register("descriptionPhone1")}
                  id="outlined-basic"
                  label="Service client"
                  type="text"
                  variant="outlined"
                  size='large'
                  name='descriptionPhone1'
                  error={descriptionPhone1Error.valid}
                  helperText={descriptionPhone1Error.text}
                  onChange={handleChange}
                />
              </div>
              <div className="newBranchItem" >
                <TextField
                {...register("phone2")}
                  id="input-with-icon-textfield"
                  label="phone 2"
                  type="number"
                  InputProps={{
                    startAdornment: (
                      <InputAdornment position="start">
                        <PhoneIcon />
                      </InputAdornment>
                    ),
                  }}
                  variant="outlined"
                  name='phone2'
                  error={phone2Error.valid}
                  helperText={phone2Error.text}
                  onChange={handleChange}
                />
              </div>
              <div className="newBranchItem">
                <TextField
                {...register("descriptionPhone2")}
                  id="outlined-basic"
                  label="Service client"
                  type="text"
                  variant="outlined"
                  size='large'
                  name='descriptionPhone2'
                  error={descriptionPhone2Error.valid}
                  helperText={descriptionPhone2Error.text}
                  onChange={handleChange}
                />
              </div>
              <div className="newBranchItem" >
                <TextField
                {...register("phone3")}
                  id="input-with-icon-textfield"
                  label="phone 3"
                  InputProps={{
                    startAdornment: (
                      <InputAdornment position="start">
                        <PhoneIcon />
                      </InputAdornment>
                    ),
                  }}
                  variant="outlined"
                  name='phone3'
                  error={phone3Error.valid}
                  helperText={phone3Error.text}
                  onChange={handleChange}
                />
              </div>
              <div className="newBranchItem">
                <TextField
                {...register("descriptionPhone3")}
                  id="outlined-basic"
                  label="Service client"
                  type="text"
                  variant="outlined"
                  size='large'
                  name='descriptionPhone3'
                  error={descriptionPhone3Error.valid}
                  helperText={descriptionPhone3Error.text}
                  onChange={handleChange}
                />
              </div>
              <div className="newBranchItem" >
                <TextField
                {...register("phone4")}
                  id="input-with-icon-textfield"
                  label="phone 4"
                  InputProps={{
                    startAdornment: (
                      <InputAdornment position="start">
                        <PhoneIcon />
                      </InputAdornment>
                    ),
                  }}
                  variant="outlined"
                  name='phone4'
                  error={phone4Error.valid}
                  helperText={phone4Error.text}
                  onChange={handleChange}
                />
              </div>
              <div className="newBranchItem">
                <TextField
                {...register("descriptionPhone4")}
                  id="otlined-basic"
                  label="Service client"
                  type="text"
                  variant="outlined"
                  size='large'
                  name='descriptionPhone4'
                  error={descriptionPhone4Error.valid}
                  helperText={descriptionPhone4Error.text}
                  onChange={handleChange}
                />
              </div>
            </div>
          </form>
        </div>
      </div>
      </>  )}
    </div>
  )
}
