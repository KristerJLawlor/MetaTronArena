using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using NETWORK_ENGINE;
using UnityEngine.UIElements;

public class NetworkRigidbody : NetworkComponent
{
    //Make variables for the states!
    Vector3 LastPosition;
    Vector3 LastRotation;
    Vector3 LastVelocity;
    Vector3 LastAng;

    //Client only variable
    Vector3 AdaptiveVelocity;
    //Speed variable - Should be the same as player controller)
    public float Speed = 5;
    //Toggle for adaptive Speed
    public bool useAdaptiveSpeed = true;
    //End of client side variables.

    //Thresholds
    public float minThreshold = .1f;
    public float maxThreshold = 3;



    //RigidBody Variable
    public Rigidbody myRig;

   
    public Vector3 ParseV(string v)
    {
        Vector3 temp = new Vector3();
        string[] args = v.Trim('(').Trim(')').Split(',');
        temp.x = float.Parse(args[0]);
        temp.y = float.Parse(args[1]);
        temp.z = float.Parse(args[2]);
        return temp;
    }
    public override void HandleMessage(string flag, string value)
    {
        if(IsClient)
        {
            if(flag == "POS")
            {
                LastPosition = ParseV(value);
                float d = (LastPosition-myRig.position).magnitude; 
                if(d> maxThreshold)
                {
                    myRig.position = LastPosition;
                    AdaptiveVelocity= Vector3.zero;
                }
                else if(d>minThreshold && useAdaptiveSpeed)
                {
                    AdaptiveVelocity= (LastPosition-myRig.position).normalized*Time.deltaTime*Speed;
                }
                //else
                //You may need to set AdaptiveVelocity to 0
            }
            if(flag == "VEL")
            {
                LastVelocity = ParseV(value);
                float d = (LastVelocity).magnitude;
                if(d<minThreshold)
                {
                    LastVelocity = Vector3.zero;
                    AdaptiveVelocity = Vector3.zero;
                }
            }
            if(flag == "ROT")
            {
                LastRotation = ParseV(value);
            }
            if(flag == "ANG")
            {
                LastAng = ParseV(value);
                if(LastAng.magnitude<minThreshold)
                {
                    LastAng = Vector3.zero;
                }
            }

        }
    }

    public override void NetworkedStart()
    {
       
    }

    public override IEnumerator SlowUpdate()
    {
        while (IsServer)
        {
            //Check position
            if( (LastPosition-myRig.position).magnitude>this.minThreshold)
            {
                LastPosition = myRig.position;
                SendUpdate("POS", LastPosition.ToString("F2"));
            }
            //Check roation
            if ((LastRotation - myRig.rotation.eulerAngles).magnitude > this.minThreshold)
            {

                LastRotation = myRig.rotation.eulerAngles;
                SendUpdate("ROT", LastRotation.ToString("F2"));
            }
            //check for vel
            if ((LastVelocity - myRig.velocity).magnitude > this.minThreshold)
            {
                LastVelocity= myRig.velocity;
                SendUpdate("VEL", LastVelocity.ToString("F2"));
            }
            //Check for ang
            if ((LastAng - myRig.angularVelocity).magnitude > this.minThreshold)
            {
                LastAng= myRig.angularVelocity;
                SendUpdate("ANG", LastAng.ToString("F2"));
            }
            if (IsDirty)
            {
                SendUpdate("POS", LastPosition.ToString("F2"));
                SendUpdate("ROT", LastRotation.ToString("F2"));
                SendUpdate("VEL", LastVelocity.ToString("F2"));
                SendUpdate("ANG", LastAng.ToString("F2"));
                IsDirty = false;
            }
            yield return new WaitForSeconds(.05f);
        }
    }

    // Start is called before the first frame update
    void Start()
    {
        myRig = GetComponent<Rigidbody>();  
    }

    // Update is called once per frame
    void Update()
    {
        if(IsClient)
        {
            myRig.velocity = LastVelocity;
            if(myRig.velocity.magnitude>minThreshold && useAdaptiveSpeed)
            {
                myRig.velocity += AdaptiveVelocity;
            }
            myRig.angularVelocity = LastAng;
            myRig.rotation = Quaternion.Euler(LastRotation); 
        }
    }
}
