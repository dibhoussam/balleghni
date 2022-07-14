import React, { useEffect } from 'react';
import "./announcesList.css";

import Pagination from '@mui/material/Pagination';
import Stack from '@mui/material/Stack';
import { DataGrid } from '@mui/x-data-grid';
import DeleteForeverIcon from '@mui/icons-material/DeleteForever';
import { Link } from 'react-router-dom';
import { useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import CircularProgress from '@mui/material/CircularProgress';


import Chip from '@mui/material/Chip';
import Avatar from '@mui/material/Avatar';


import jwt_decode from "jwt-decode";
import { deleteAnnounce, loadAnnounces, loadDataAnnounces } from '../../../redux/actions/announcesActions';



export default function AnnouncesList(props) {

    let announ = useSelector(state => state.allAnnounces.announces);
    let added = useSelector(state => state.allAnnounces.addedAnnounce);
    let data = useSelector(state => state.allAnnounces.data);
    let userInfo = useSelector(state => state.user.userInfo)
    
    let access = useSelector(state => state.user.user.access_token);
    const dispatch = useDispatch();
    const [updated,setUpdated] = useState(1);
    const [currentpage, setCurrentpage] = useState(1);


    useEffect(() => {
        dispatch(loadAnnounces(access, currentpage))

    }, [currentpage]);

    

    const handleDelete = (row) =>{
        if (window.confirm(`Confirmer la suppression d'annonce' ${row.id}` )) {
            console.log(row);
            
            dispatch(deleteAnnounce(access,row.id,currentpage));

            //setUpdated(!updated)
        }
        
    }


    const columns = [
        { field: 'id', headerName: 'ID', width: 70 },
        { field: 'created_at', headerName: 'Date de creation', width: 200 },
        {
            field: 'description',
            headerName: 'description',
            width: 100,
        },
        {
            field: 'title',
            headerName: 'Titre',
            width: 100,
        },
        {
            field: "tags",
            headerName: "Authoritie",
            width: 400,
            renderCell: (params) => {
                return (
                    <>
                        <div key={params.id} style={{ display: "flex", flexWrap: "wrap" }}>
                            <div style={{ display: "flex" }}>
                                <Chip
                                    avatar={<Avatar alt="Natacha" src={params.row.authoritie.logo} />}
                                    label={params.row.authoritie.name}
                                    variant="outlined"
                                />
                            </div>
                        </div>

                    </>
                )
            },

        },
        {
            field: "action",
            headerName: "Action",
            width: 150,
            renderCell: (params) => {
                //  if (jwt_decode(access).hasOwnProperty("superadmin")) {
                return (
                    <>
                        {
                            userInfo.hasOwnProperty('authotitie') && userInfo.authoritie === params.row.authoritie_id &&
                            <Link to={'/announce/' + params.row.id}>
                            <button className="userListEdit">Preview & Edit</button>
                            </Link>
                        }
                        
                        <Link>
                            <DeleteForeverIcon className="userListDelete" onClick={() =>handleDelete(params.row)} />
                        </Link>
                    </>
                )
                //  }

            },

        },


    ];


    return (
        <div className="userList">

            {
                Object.keys(announ).length === 0 ? (
                    <>
                        <div style={{ textAlign: "center", height: "800px" }}>
                            <CircularProgress style={{ marginTop: "400px" }} />
                        </div></>
                ) : (
                    <>
                        <div className="userTitleContainer">
                            <h1 className="userTitle">Announces list</h1>
                            <Link to="/newAnnounce">
                                <button className="userAddButton">Ajouter</button>
                            </Link>
                        </div>
                        <div className="userTitleContainer">
                            <div style={{ marginLeft: "40%" }}>
                                <Stack >
                                    <Pagination count={announ.last_page} color="primary" onChange={(e, page) => { setCurrentpage(page) }} />
                                </Stack>
                            </div>
                        </div>
                        <div className="diaplayContainer">
                        <DataGrid
                            disableSelectionOnClick
                            rows={data}
                            columns={columns}
                            pageSize={20}
                            rowsPerPageOptions={[5]}
                            checkboxSelection
                        />
                        </div>
                    </>
                )
            }


        </div>
    );
}
