const MockContract = artifacts.require('./mocks/MockContract.sol');
const FeeManager = artifacts.require('./FeeManager.sol');

contract('FeeAware', function (accounts) {

    let contract, manager;

    beforeEach(async () => {
        manager = await FeeManager.new(accounts[1]);
        contract = await MockContract.new(manager.address);
    });

    it('should handle fee for method call', async () => {

        let method = "0x1234";
        let fee = 1 * 10**18;

        await manager.setFeeForMethod(method, fee);

        let previousBalance = await web3.eth.getBalance(accounts[1]);

        await contract.sendTransaction({from: accounts[0], value: fee, data: method});

        assert.equal(await web3.eth.getBalance(accounts[1]).toString(18), previousBalance.plus(fee).toString(18));
    });
});
