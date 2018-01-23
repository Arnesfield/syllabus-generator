// import components to be routed
import Home from './Home'
import Login from './Login'
import Dashboard from './Dashboard'
import NotFound from './errors/NotFound'

import Activities from './dashboard/Activities'
import Syllabi from './dashboard/Syllabi'
import Generator from './dashboard/Generator'
import Manage from './dashboard/Manage'

import ManageUsers from './manage/ManageUsers'

export default {
  Home,
  Login,
  Dashboard,
  Manage,

  Activities,
  Syllabi,
  Generator,
  ManageUsers,

  NotFound
}
