using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using NETWORK_ENGINE;

public class NetworkTransform : NetworkComponent
{

    public Vector3 LastPosition;
    public Vector3 LastRotation;
    public Vector3 LastScale;
    public float threshold = .1f;
    public float maxThreshold = 5.0f;

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
        if(flag == "LOC" && IsClient)
        {
            LastPosition = ParseV(value);
        }
        if(flag == "ROT" && IsClient)
        {
            LastRotation = ParseV(value);
        }
    }

    public override void NetworkedStart()
    {
        LastPosition = new Vector3();
        LastRotation = new Vector3();
    }

    public override IEnumerator SlowUpdate()
    {
        while (IsServer)
        {
            //Did states change enough?
            if( (LastPosition-transform.position).magnitude>threshold)
            {
                LastPosition= transform.position;
                SendUpdate("LOC", LastPosition.ToString("F2"));
            }
            if(  (LastRotation-transform.rotation.eulerAngles).magnitude >threshold )
            {
                LastRotation = transform.rotation.eulerAngles;
                SendUpdate("ROT", LastRotation.ToString("F2"));
            }

            if(IsDirty)
            {
                SendUpdate("ROT", LastRotation.ToString("F2"));
                SendUpdate("LOC", LastPosition.ToString("F2"));
                IsDirty = false;
            }
            yield return new WaitForSeconds(.1f);
        }
    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(IsClient)
        {
            if ((this.transform.position - LastPosition).magnitude > maxThreshold)
            {
                this.transform.position = LastPosition;
                this.transform.rotation = Quaternion.Euler(LastRotation);
            }
            else
            {
                this.transform.position =
                    Vector3.Lerp(this.transform.position, LastPosition, 3.5f * Time.deltaTime);
                this.transform.rotation =
     Quaternion.Euler(Vector3.Lerp(this.transform.rotation.eulerAngles, LastRotation, 120 * Time.deltaTime));
            }
        }
    }
}
