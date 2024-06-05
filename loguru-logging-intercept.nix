{
  lib,
  buildPythonPackage,
  setuptools,
  loguru,
  fetchFromGitHub,
}:
buildPythonPackage {
  pname = "loguru-logging-intercept";
  version = "0.1.4-unstable";

  src = fetchFromGitHub {
    owner = "MatthewScholefield";
    repo = "loguru-logging-intercept";
    rev = "9252ac889d4af08fd11d760d92d56a9de93a004a";
    hash = "sha256-lHACnXhXblNfzBYZ/3BTVupp6b9257jDN5kY3xvfVUg=";
  };

  build-system = [setuptools];
  dependencies = [loguru];

  pythonImportsCheck = ["loguru_logging_intercept"];

  meta = with lib; {
    description = "Language Server for Make(file)";
    license = licenses.mit;
    homepage = "https://github.com/hikari-crescent/hikari-crescent";
    maintainers = with maintainers; [sigmanificient];
  };
}
