using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameMusicScript : MonoBehaviour
{

    public AudioSource GameMusic;

    public AudioClip MenuClip;
    public AudioClip ArenaClip;

    // Start is called before the first frame update
    void Start()
    {
        GameMusic.loop = true;
        GameMusic.Play();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

}
