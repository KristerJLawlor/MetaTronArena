using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UIAudio : MonoBehaviour
{
    public AudioSource UIAudioSource;

    public AudioClip ButtonClick;
    public AudioClip TextClick;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void PlayButtonAudio()
    {
        UIAudioSource.PlayOneShot(ButtonClick);
    }

    public void PlayTextAudio()
    {
        UIAudioSource.PlayOneShot(TextClick);
    }
}
