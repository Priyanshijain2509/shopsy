// app/javascript/packs/Welcome.jsx
import React from 'react';
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import Help from '../components/Help';
import About from '../components/About';
import Contact from '../components/Contact';
import Index from '../components/users/Index';
import ProductIndex from '../components/products/ProductIndex';
import EditForm from './products/EditForm';
import OrderIndex from '../components/orders/OrderIndex';
import CreateForm from './products/CreateForm';
import '../packs/index.css';
function Welcome({ current_user }) {
  console.log('Current User from welcome:', current_user);

  return (
    <>
      <BrowserRouter>
        <Routes>
          <Route path='/help' element={<Help />} />
          <Route path='/about' element={<About />} />
          <Route path='/contact' element={<Contact />} />
          <Route path='/all_users' element={<Index />} />
          <Route path='/all_products' element={<ProductIndex />} />
          <Route path='/all_products/:id/edit' element={<EditForm />} />
          <Route path='/users/:id/products/new' element={<CreateForm current_user={current_user}/>} />
          <Route
            path='/order_list'
            element={< OrderIndex current_user={current_user} />}
          />
          </Routes>
      </BrowserRouter>
    </>
  );
}

export default Welcome;
