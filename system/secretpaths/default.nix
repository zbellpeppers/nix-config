{...}: {
  age.secrets = {
    actualbudget-password = {
      file = ../../secrets/actualbudget-password.age;
    };
    actualbudget-apikey = {
      file = ../../secrets/actualbudget-apikey.age;
    };
  };
}
