using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class FurnitureBehaviour : MonoBehaviour
{
    private Vector3 _dragOffset;
    public bool dragOn;

    private void OnMouseDown()
    {
        if (dragOn)
        {
            _dragOffset = transform.position - Camera.main.ScreenToWorldPoint(Input.mousePosition);
        }
    }
    private void OnMouseDrag()
    {
        if (dragOn)
        {
            transform.position = GetMousePos() + _dragOffset;

        }
    }

    //Switch out for an enum that says which game to start, 0 for none/animation
    public bool startGame;
    public string scene = "RunnerScene"; //Will be a changeable enum eventually?
    private void OnMouseUp()
    {
        if (!dragOn)
        {

            Debug.Log("I have been clicked");
            SceneManager.LoadScene(scene);
        }
    }

    private Vector3 GetMousePos()
    {
        var mousePos = Camera.main.ScreenToWorldPoint(Input.mousePosition);
        mousePos.z = 0;
        return mousePos;
    }
  

}
