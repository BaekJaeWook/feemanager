const FeeManager = artifacts.require('./FeeManager.sol');

contract('FeeManager', function (accounts) {

    let manager;

    beforeEach(async () => {
        manager = await FeeManager.new(accounts[1]);
    });

    it('should allow setting fee for method', async () => {

        let method = "0x1234";
        let fee = 1 * 10**18;

        await manager.setFeeForMethod(method, fee);
        assert.equal(await manager.feeForMethod.call(method), fee);
    });

    it('should return expected collector', async () => {
        assert.equal(await manager.collector.call(), accounts[1]);
    });
});
