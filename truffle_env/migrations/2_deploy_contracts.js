var Ownable = artifacts.require("./Ownable.sol");
var SafeMath = artifacts.require("./SafeMath.sol");
var PubFree = artifacts.require("./PubFree.sol");

module.exports = function(deployer) {
  deployer.deploy(Ownable);
  deployer.deploy(SafeMath);

  deployer.link(Ownable, PubFree);
  deployer.link(SafeMath, PubFree);
  deployer.deploy(PubFree);
};
