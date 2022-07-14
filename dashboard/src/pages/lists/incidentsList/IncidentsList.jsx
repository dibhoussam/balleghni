import React, { useEffect } from 'react';
import "./incidentList.css";

import { DataGrid } from '@mui/x-data-grid';
import DeleteForeverIcon from '@mui/icons-material/DeleteForever';
import { Link } from 'react-router-dom';
import { useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import CircularProgress from '@mui/material/CircularProgress';

import Chip from '@mui/material/Chip';
import Avatar from '@mui/material/Avatar';

import jwt_decode from "jwt-decode";
import { deleteIncident, loadIncidents } from '../../../redux/actions/incidentsActions';



export default function IncidentsList(props) {

    const incidents = useSelector(state => state.allIncidents.incidents);
    const access = useSelector(state => state.user.user.access_token);
    const dispatch = useDispatch();
    const [currentpage, setCurrentpage] = useState(1);


    useEffect(() => {
        dispatch(loadIncidents(access, currentpage))

    }, []);

    const handleDelete = (id) =>{
        if (window.confirm(`Confirmer la suppression d'incident' ${id}` )) {
            dispatch(deleteIncident(access,id,currentpage));
        }
        
    }



    const columns = [
        { field: 'id', headerName: 'ID', width: 70 },
        {
            field: 'title',
            headerName: 'Titre',
            width: 300,
            renderCell: (params) => {
                return (
                    <>
                        <div key={params.id} style={{ display: "flex", flexWrap: "wrap" }}>
                            <div style={{ display: "flex" }}>
                                <Chip
                                    avatar={<Avatar alt="Natacha" src={params.row.icon} />}
                                    label={params.row.title}
                                    variant="outlined"
                                />
                            </div>
                        </div>

                    </>
                )
            },
        },
        {
            field: "tags",
            headerName: "Authoritie",
            width: 300,
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
            field: 'description',
            headerName: 'description',
            width: 200,
        },
        {
            field: "action",
            headerName: "Action",
            width: 150,
            renderCell: (params) => {
                // if (jwt_decode(access).hasOwnProperty("superadmin")) {
                return (
                    <>
                        <Link to={'/incident/' + params.row.id}>
                            <button className="userListEdit">Preview & Edit</button>
                        </Link>
                        <Link>
                            <DeleteForeverIcon className="userListDelete" onClick={() =>handleDelete(params.row.id)} />
                        </Link>
                    </>
                )
                //}

            },

        },


    ];


    return (
        <div className="userLista">
            {
                Object.keys(incidents).length === 0 ? (
                    <>
                        <div style={{ textAlign: "center", height: "800px" }}>
                            <CircularProgress style={{ marginTop: "400px" }} />
                        </div></>
                ) : (
                    <>
                        <div className="userTitleContainer">
                            <h1 className="userTitle">Incidents list</h1>
                            <Link to="/newIncident">
                                <button className="userAddButton">Ajouter</button>
                            </Link>
                        </div>
                        <div className="diaplayContainer">
                        <DataGrid
                            disableSelectionOnClick
                            rows={incidents}
                            columns={columns}
                            pageSize={10}
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
