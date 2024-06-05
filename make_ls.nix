{
  lib,
  buildPythonPackage,
  setuptools,
  pygls,
  loguru,
}:
buildPythonPackage {
  pname = "make_ls";
  version = "0.0.1";
  pyproject = true;

  src = ./.;

  build-system = [setuptools];
  dependencies = [pygls loguru];

  pythonImportsCheck = ["make_ls"];

  meta = with lib; {
    description = "Language Server for Make(file)";
    maintainers = with maintainers; [sigmanificient];
    mainProgram = "make_ls";
  };
}
