using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;
using UnityEngine.UIElements;
using UnityEngine.Events;
using NETWORK_ENGINE;
using static UnityEngine.Rendering.DebugUI;

public class NPMScript : NetworkComponent
{

    public string PName;
    public bool IsReady;
    public int ClassSelected;
    public override void HandleMessage(string flag, string value)
    {
        if (flag == "READY")
        {
            IsReady = bool.Parse(value);
            if (IsServer)
            {
                SendUpdate("READY", value);
                Debug.Log("Sending Update READY" + value.ToString());
            }
        }

        if (flag == "NAME")
        {
            PName = value;
            if (IsServer)
            {
                SendUpdate("NAME", value);
                Debug.Log("Sending Update NAME" + value.ToString());
            }
        }

        if (flag == "CLASS")
        {
            ClassSelected = int.Parse(value);
            if (IsServer)
            {
                SendUpdate("CLASS", value);
                Debug.Log("Sending Update CLASS" + value.ToString());
            }
        }

    }

    public override void NetworkedStart()
    {
        //Dont let other players interact with your UI
        if (!IsLocalPlayer)
        {
            this.transform.GetChild(0).gameObject.SetActive(false);
        }
    }

    public override IEnumerator SlowUpdate()
    {
        while (IsConnected)
        {
            if (IsServer)
            {

                if (IsDirty)
                {
                    SendUpdate("NAME", PName);
                    SendUpdate("CLASS", ClassSelected.ToString());

  

                    IsDirty = false;
                }
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
        
    }

    public void UI_NameInput(string s)
    {
        if (IsLocalPlayer)
        {
            SendCommand("NAME", s);
            Debug.Log("NAME EVENT TRIGGER");
        }

    }

    public void UI_ClassSelect(int i)
    {
        if (IsLocalPlayer)
        {
            SendCommand("CLASS", i.ToString());
            Debug.Log("CLASS EVENT TRIGGER");
        }
    }

    public void UI_Ready(bool r)
    {
        if (IsLocalPlayer)
        {
            SendCommand("READY", r.ToString());
            Debug.Log("READY EVENT TRIGGER");
        }
    }
}
