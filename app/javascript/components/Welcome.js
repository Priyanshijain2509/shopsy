// app/javascript/packs/Welcome.jsx
import React from 'react';
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import Help from '../components/Help';
import About from '../components/About';
import Contact from '../components/Contact';
import Index from '../components/users/Index';
import Product_Index from '../components/products/Product_Index';
import EditForm from './products/EditForm';
import Order_Index from '../components/orders/Order_Index';
import CreateForm from './products/CreateForm';
import '../packs/index.css';
import NewOrder from './orders/NewOrder';
import CancelOrder from './orders/CancelOrder';
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
          <Route path='/all_products' element={<Product_Index />} />
          <Route path='/all_products/:id/edit' element={<EditForm />} />
          <Route path='/users/:id/products/new' element={<CreateForm current_user={current_user}/>} />
          <Route
            path='/order_list'
            element={< Order_Index current_user={current_user} />}
          />
          <Route path='/users/:user_id/products/:product_id/orders' element={< NewOrder />} />
          <Route path='/users/:user_id/products/:product_id/orders/:id' element={< CancelOrder />} />
        </Routes>
      </BrowserRouter>
    </>
  );
}

export default Welcome;
