import React from 'react';
import { createContext, useContext, useState } from 'react';

const UserContext = createContext();

export const UserProvider = ({ children }) => {
  const [current_user, setCurrentUser] = useState(null);

  const updateUser = (newUserData) => {
    setCurrentUser(newUserData);
  };

  return (
    <UserContext.Provider value={{ current_user, updateUser }}>
      {children}
    </UserContext.Provider>
  );
};

export const useUser = () => {
  return useContext(UserContext);
};
