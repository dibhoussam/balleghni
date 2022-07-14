import React from 'react';
import "./Sidebar.css";
import LineStyleIcon from '@mui/icons-material/LineStyle';
import {Link} from 'react-router-dom';

export default function Sidebar() {
  return (
    <div className="sidebar">
      <div className="sidebarWrapper">
          <div className="sidebarMenu">
              <h3 className="sidebarTitle">Dashboard</h3>
              <ul className="sidebarList">
                  <Link to="/users" className="link">
                        <li className="sidebarListItem">
                              <LineStyleIcon className="sidebarIcon" />
                              Users
                        </li>
                  </Link>
                  <Link to="/authorities" className="link">
                  <li className="sidebarListItem">                 
                        <LineStyleIcon className="sidebarIcon"/>
                        Authorities
                  </li>
                  </Link>
                  <Link to="/branchs" className='link'>
                  <li className="sidebarListItem">
                        <LineStyleIcon className="sidebarIcon"/>
                        Branchs
                  </li>
                  </Link>
              </ul>
          </div>
          <div className="sidebarMenu">
              <h3 className="sidebarTitle">Dashboard</h3>
              <ul className="sidebarList">
                    <Link to="/reports" className="link">
                  <li className="sidebarListItem">
                        <LineStyleIcon className="sidebarIcon" />
                        Reports
                  </li>
                  </Link>
                  <Link to="/announces" className='link'>
                  <li className="sidebarListItem">
                        <LineStyleIcon className="sidebarIcon"/>
                        Announces
                  </li>
                  </Link>
                  <Link to="/incidents" className='link'>
                  <li className="sidebarListItem">
                        <LineStyleIcon className="sidebarIcon"/>
                        Incidents
                  </li>
                  </Link>
                  <Link to="/stats" className="link">
                  <li className="sidebarListItem">
                        <LineStyleIcon className="sidebarIcon" />
                        Statistique
                  </li>
                  </Link>
              </ul>
          </div>
          
      </div>
    </div>
  );
}
