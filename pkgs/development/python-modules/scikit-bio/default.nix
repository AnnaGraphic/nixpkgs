{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  cython,
  oldest-supported-numpy,
  requests,
  decorator,
  natsort,
  numpy,
  pandas,
  scipy,
  h5py,
  hdmedians,
  biom-format,
  python,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "scikit-bio";
  version = "0.6.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "scikit-bio";
    repo = "scikit-bio";
    rev = "refs/tags/${version}";
    hash = "sha256-1L3AemXVqfgBDlRZorG7+8qt3f1Bm8L+Se+OwqEWwI4=";
  };

  build-system = [
    setuptools
    cython
    oldest-supported-numpy
  ];

  dependencies = [
    requests
    decorator
    natsort
    numpy
    pandas
    scipy
    h5py
    hdmedians
    biom-format
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  # only the $out dir contains the built cython extensions, so we run the tests inside there
  pytestFlagsArray = [ "${placeholder "out"}/${python.sitePackages}/skbio" ];

  pythonImportsCheck = [ "skbio" ];

  meta = {
    homepage = "http://scikit-bio.org/";
    description = "Data structures, algorithms and educational resources for bioinformatics";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ tomasajt ];
  };
}
