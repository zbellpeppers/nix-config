{...}: {
  age.secrets = {
    actualbudget-password = {
      file = ../../secrets/actualbudget-password.age;
    };
    actualbudget-apikey = {
      file = ../../secrets/actualbudget-apikey.age;
    };
    actualbudget-ddclient-apitoken = {
      file = ../../secrets/actualbudget-ddclient-apitoken.age;
    };
    actualbudget-nginx-apitoken = {
      file = ../../secrets/actualbudget-nginx-apitoken.age;
    };
  };
}
