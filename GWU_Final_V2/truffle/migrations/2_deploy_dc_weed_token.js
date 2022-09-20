const DcWeedToken = artifacts.require("DcWeedToken");

module.exports = function (deployer) {
  deployer.deploy(DcWeedToken);
};