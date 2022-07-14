import Sidebar from "./components/sidebar/Sidebar";
import Topbar from "./components/topbar/Topbar";
import "./app.css";
import {
  BrowserRouter as Router,
  Route
} from "react-router-dom";

import User from "./pages/previews/user/User"; 
import NewUser from "./pages/addNew/newUser/NewUser";

import ReportsList from "./pages/lists/reportsList/ReportsList";
import AnnouncesList from "./pages/lists/announcesList/AnnouncesList";
import IncidentsList from "./pages/lists/incidentsList/IncidentsList";
import BranchsList from "./pages/lists/branchsList/BranchsList";
import AuthoritiesList from "./pages/lists/authoritiesList/AuthoritiesList";
import Login from "./pages/login/Login";
import { useDispatch, useSelector } from "react-redux";
import Announce from "./pages/previews/announce/Announce";
import Authoritie from "./pages/previews/authoritie/Authoritie";
import Branch from "./pages/previews/branch/Branch";
import Incident from "./pages/previews/incident/Incident";
import Report from "./pages/previews/report/Report";
import NewAuthoritie from "./pages/addNew/newAuthoritie/NewAuthoritie";
import NewAnnounce from "./pages/addNew/newAnnounce/NewAnnounce";
import NewIncident from "./pages/addNew/newIncident/NewIncident";
import NewReport from "./pages/addNew/newReport/NewReport";
import NewBranch from "./pages/addNew/newBranch/NewBranch";
import { useEffect } from "react";
import { checkAutoLogin, removeTokenFromLocalStorage } from "./redux/actions/userActions";
import UsersList from "./pages/lists/usersList/UsersList";
import Stats from "./pages/lists/statistiques/Stats";
import { getAuthoritie } from "./redux/actions/authoritiesActions";

function App() {

  const dispatch = useDispatch();
  const user = useSelector(state => state.user.user)
  
  
  useEffect(() => {
    checkAutoLogin(dispatch);
    
  }, [])
  

    if (user === null) {
      console.log(process.env);
      return (<Login />)
    }else{
      return(
      <Router>
        <Topbar />
        <div className="container">
          <Sidebar />
            <Route path="/users">
              <UsersList />
            </Route> 
            <Route path="/user/:iserId">
              <User />
            </Route> 
            <Route path="/newUser">
              <NewUser />
            </Route> 
            <Route path="/reports">
              <ReportsList/>
            </Route>
            <Route path="/report/:reportId">
              <Report />
            </Route> 
            <Route path="/announces">
              <AnnouncesList />
            </Route> 
            <Route path="/announce/:announceId">
              <Announce />
            </Route> 
            <Route path="/incidents">
              <IncidentsList />
            </Route>
            <Route path="/incident/:incidentId">
              <Incident />
            </Route>
            <Route path="/branchs">
              <BranchsList />
            </Route> 
            <Route path="/branch/:branchId">
              <Branch />
            </Route> 
            <Route path="/authorities">
              <AuthoritiesList />
            </Route> 
            <Route path="/authoritie/:authoritieId">
              <Authoritie />
            </Route> 
            <Route path="/newAuthoritie">
              <NewAuthoritie />
            </Route> 
            <Route path="/newAnnounce">
              <NewAnnounce />
            </Route>
            <Route path="/newIncident">
              <NewIncident />
            </Route>
            <Route path="/newReport">
              <NewReport />
            </Route>
            <Route path="/newBranch">
              <NewBranch />
            </Route>
            <Route path="/stats">
              <Stats />
            </Route>


        </div>
        
    </Router>
      )
    }
    
}

export default App;
