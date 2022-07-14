import React, { useEffect } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { deleteUser, loadAuthoritieUsers, loadWilayaUsers } from '../../../redux/actions/usersActions'
import './UsersList.css'
import CircularProgress from '@mui/material/CircularProgress';
import { Link } from 'react-router-dom';
import { DataGrid } from '@mui/x-data-grid';
import DeleteForeverIcon from '@mui/icons-material/DeleteForever';
import { useState } from 'react';



export default function UsersList() {
    const dispatch = useDispatch();
    let access = useSelector(state => state.user.user.access_token);
    let userInfo = useSelector(state => state.user.userInfo)
    let users = useSelector(state => state.allUsers.users)
    const [updated,setUpdated] = useState(true);
    
    if (updated) {
        setUpdated(!updated)
    }
    useEffect(() =>{
        if (userInfo.hasOwnProperty('authoritie')) {
            console.log("user has onw property authoritie");
            console.log(userInfo);
            dispatch(loadAuthoritieUsers(access,1));
        }else
            dispatch(loadWilayaUsers(access,16))
        
    },[userInfo],[users])

    

   

    const handleDelete = (row) =>{
        if (window.confirm(`Confirmer la suppression d'utilisateur' ${row.id}` )) {
            console.log("handle delete !!!");
            dispatch(deleteUser(access,row.id,userInfo.wilaya))
            window.location.reload()
            
        }
        
    }


    console.log(users);

    const columns = [
        {
            field: 'userName',
            headerName: 'Username',
            width: 200,
            
        },
        {
            field: 'firstName',
            headerName: 'First name',
            width: 200,
        },
        {
            field: 'lastName',
            headerName: 'Lastname',
            width: 200,
        },
        {
            field: 'email',
            headerName: 'description',
            width: 200,
        },
        {
            field: "action",
            headerName: "Action",
            width: 150,
            renderCell: (params) => {
                //  if (jwt_decode(access).hasOwnProperty("superadmin")) {
                return (
                    <>
                        <Link to={'/user/' + params.row.id}>
                            <button className="userListEdit">Preview & Edit</button>
                        </Link>
                        
                        <DeleteForeverIcon className="userListDelete" onClick={() =>handleDelete(params.row)} />
                        
                    </>
                )
                //  }

            },

        },
    ]


  return (
    <div className="userLista">
            {
                (users === undefined) ? (
                    <>
                        <div style={{ textAlign: "center", height: "800px" }}>
                            <CircularProgress style={{ marginTop: "400px" }} />
                        </div></>
                ) : (
                    <>
                        <div className="userTitleContainer">
                            <h1 className="userTitle">Users list</h1>
                            <Link to="/newUser">
                                <button className="userAddButton">Ajouter</button>
                            </Link>
                        </div>
                        <div className="diaplayContainer">
                        <DataGrid
                            disableSelectionOnClick
                            rows={users}
                            columns={columns}
                            pageSize={15}
                            rowsPerPageOptions={[5]}
                            checkboxSelection
                            
                        />
                        </div>
                    </>
                )
            } 

        </div>
  )
}
