
int switch1val;

void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT_PULLUP);
  pinMode(13, OUTPUT);
}
void loop() {
  // read the switch value
  switch1val = digitalRead(2);
  // print out the switch value
  Serial.write(switch1val);
  


 
  delay(100); 

}

