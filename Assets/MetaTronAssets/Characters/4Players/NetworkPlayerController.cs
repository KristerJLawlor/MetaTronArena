using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

using NETWORK_ENGINE;




public class NetworkPlayerController : NetworkComponent
{


    public Vector2 LastInput;
    public Rigidbody myRig;
    public float speed = 5;
    public string pname;

    public Vector2 ParseV2(string v)
    {
        Vector2 temp = new Vector2();
        string[] args = v.Trim('(').Trim(')').Split(',');
        temp.x = float.Parse(args[0]); 
        temp.y = float.Parse(args[1]);
        return temp;
    }

    public void ActionHandler(InputAction.CallbackContext c)
    {
        if(c.started || c.performed)
        {
            //Send input
            SendCommand("MVC", c.ReadValue<Vector2>().ToString("F2"));
        }
        else if(c.canceled)
        {
            //Send vector 2.zero.
            SendCommand("MVC", Vector2.zero.ToString("F2"));
        }
    }
    public override void HandleMessage(string flag, string value)
    {
        if(IsServer && flag == "MVC")
        {
            LastInput = ParseV2(value);
        }
        if(flag == "PN")
        {
            pname = value;
        }
    }

    public override void NetworkedStart()
    {
      if(IsServer)
        {
            myRig = GetComponent<Rigidbody>();
        }
    }

    public override IEnumerator SlowUpdate()
    {
        while(IsServer)
        {
            if(IsDirty)
            {
                SendUpdate("PN", pname);
            }
            yield return new WaitForSeconds(.05f);
        }
    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        myRig.velocity = new Vector3(LastInput.x, 0, LastInput.y) * speed;
    }
}
