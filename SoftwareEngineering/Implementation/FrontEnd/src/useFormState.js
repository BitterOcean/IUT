import { useState } from 'react';

const useFormState = (initialValue) => {
  const [state, setState] = useState(initialValue || {});
  const handleChange = id => value => setState(
    prevState => ({
      ...prevState,
      [id]: value,
    }),
  );
  return {
    state,
    setState,
    handleChange,
  }
};

export default useFormState;
