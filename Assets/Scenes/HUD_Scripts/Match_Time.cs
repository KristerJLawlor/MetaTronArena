using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Match_Time : MonoBehaviour
{
    public Text MTimer;
    public float StartTime = 900f;
    public float timer = 0f;
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(Timing());
    }

    // Update is called once per frame
    void Update()
    {

    }
    public IEnumerator Timing()
    {
        timer = StartTime;
        do
        {
            timer -= Time.deltaTime;
            FormatText();
            yield return null;
        }
        while (timer > 0);
    }
    public void FormatText()
    {
        int minutes = (int)(timer / 60) % 60;
        int seconds = (int)(timer % 60);

        MTimer.text = minutes + ":" + seconds;
    }
}
