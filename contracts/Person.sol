pragma solidity >=0.7.0 <0.8.0;

import './Transplant.sol';

contract Person {
	address[] public  doctor ;
	string public name ;
	string public email ;
	uint public phone;
	address[] public transplants ;
	address public myaddress;
	string public aadhar_number ;
	mapping(address =>bool) doctorexists;


	modifier isAdmin () {
		require(msg.sender == myaddress);
		_;
	}
	modifier restrictedDoctor () {
		require(doctorexists[tx.origin] == true );
		_;
	}

	constructor( string memory _name , string memory  _aadhar_number , address  _myaddress  )
	{
	    name = _name;
	    aadhar_number =_aadhar_number;
	    myaddress = _myaddress ;
	}
	function addTransplant( address  _transplant) public restrictedDoctor{
		transplants.push(_transplant);
	}
	function addDoctor( address  _doc) public isAdmin{
		doctor.push(_doc);
		doctorexists[_doc]= true ;
	}
	function approveStage (address _contractAddress) public isAdmin {
		Transplant tr = Transplant(_contractAddress);
		tr.currentStageApproval();
	}

	function isDoctor( address _doc) public view returns(bool) {
		return doctorexists[_doc];
	}
	
	
}
