using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ScoreBoardScript : MonoBehaviour
{
    public Text ScoreBoard;
    public SortedList<string, int> ScoreList;
    //public NetworkPlayerController Owner;
    // Start is called before the first frame update
    void Start()
    {
        ScoreList = new SortedList<string, int>();
        //Owner = transform.parent.parent.gameObject.GetComponent<NetworkPlayerController>();
        foreach (NetworkPlayerController npc in FindObjectsOfType<NetworkPlayerController>())
        {
            ScoreList.Add(npc.pname, npc.Score);
        }
        if (ScoreList.Count > 1)
        {
            foreach (KeyValuePair<string, int> t in ScoreList)
            {
                Debug.Log(t.Key + "," + t.Value);
            }
            ScoreBoard.text = "ScoreBoard: \n";
            foreach (KeyValuePair<string, int> scores in ScoreList)//NetworkPlayerController npc in FindObjectsOfType<NetworkPlayerController>()
            {
                ScoreBoard.text += "  " + scores.Key + "          Score:" + scores.Value + "\n";
            }
        }
    }

    // Update is called once per frame
    void Update()
    {
        /*
            foreach (NetworkPlayerController npc in FindObjectsOfType<NetworkPlayerController>())
            {
                ScoreList.Add(npc.pname, npc.Score);
            }
            if (ScoreList.Count > 1)
            {
                foreach (KeyValuePair<string, int> t in ScoreList)
                {
                    Debug.Log(t.Key + "," + t.Value);
                }
            ScoreBoard.text = "ScoreBoard: \n";
                foreach (KeyValuePair<string, int> scores in ScoreList)//NetworkPlayerController npc in FindObjectsOfType<NetworkPlayerController>()
                {
                    ScoreBoard.text += "  " + scores.Key + "          Score:" + scores.Value + "\n";
                }
            }
    */
    }
}
