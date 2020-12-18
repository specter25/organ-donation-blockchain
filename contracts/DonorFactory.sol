pragma solidity >=0.7.0 <0.8.0;

import './Transplant.sol';
import './Doctor.sol';
import './Person.sol';

contract DonateOrganFactory {
    address public admin ;
    address public authority1;
    address public authority2;

    mapping( address => address) people ;
    mapping( address => address) doctors ;
    address[] transplants;


    modifier isDoctor() {
        require(doctors[msg.sender] != address(0));
        _;
    }


    function createPerson( string memory _name , string memory  _aadhar_number ) public {
        Person person = new Person(_name , _aadhar_number , msg.sender);
        people[msg.sender] = address(person);
    }

    function createDoctor ( string memory _name , string memory  _aadhar_number , address  _myaddress ) public {
        Doctor doctor = new Doctor(_name , _aadhar_number , msg.sender);
        doctors[msg.sender] = address(doctor);
    }

    function createTransplant (address _receient , address _donor , uint _organ) public isDoctor {
        Person recepient = Person(people[_receient]);

        Transplant transplant = new Transplant( _receient , _donor , authority1 , authority2 , _organ );
        transplants.push(address(transplant));

    }
    
}