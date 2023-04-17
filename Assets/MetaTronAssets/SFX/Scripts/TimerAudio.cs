using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TimerAudio : MonoBehaviour
{

    public AudioSource PlayerAudio;

    public AudioClip TimerAudio1;

    // Start is called before the first frame update
    void Start()
    {
        PlayerAudio = GetComponent<AudioSource>();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void PlayTimerAudio()
    {
        PlayerAudio.PlayOneShot(TimerAudio1, .5f);
    }
}
