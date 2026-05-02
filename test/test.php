<?php

//add function to print "test" to the console
function print_test()
{
    print("test");
}

function print_teest_r()
{
    print_r("test");
}
function print_test_r()
{
    print_r("test");
    print_r("test222");
    print_r("test111");
}
function print_test_r2()
{
    print_r("test222");
    print_r("test333");
}




// This is a test script

// Print "test" to the console

// Check if 1 is equal to 1
if (1 == 1) {
    // If it is, print "true"
    print_r("true");
} else {
    // Otherwise, print "false"
    print_r("false");
}

// This function returns 1 + 1
function oneplusone()
{
    return 1 + 1;
}

// This function returns 2 + 2
function twoplustwo()
{
    return 2 + 2;
}

//create a function that adds two parameters
function fiveplusfive()
{
    return 5 + 5;
}


// create a function that adds two parameters
function add($a, $b)
{
    $tmp = $a + $b;
    return $tmp;
}



//create a subtract function with two parameters
function subtract($a, $b)
{
    return $a - $b;
}

//create a function that multiplies two variables
function multiply($a, $b)
{
    return $a * $b;
}

//create a function that divide two numbers
//make sure it cant divide by zero
function divide($a, $b)
{
    if ($b == 0) {
        return "Cannot divide by zero";
    }
    return $a / $b;
}


class Animal
{
    public $name;
    public $age;
    public $color; // fixed the incomplete line
    public $type;

    public function __construct($name, $age, $color, $type) // added color parameter to constructor
    {
        $this->name = $name;
        $this->age = $age;
        $this->color = $color; // assign color parameter
        $this->type = $type;
    }

    public function speak()
    {
        return "My name is " . $this->name . " and I am " . $this->age . " years old. I am a " . $this->type . ".";
    }
}
