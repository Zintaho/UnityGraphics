using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

#region V6.0
using static EventManager.CustomEventType;
#endregion

public class Player : MonoBehaviour
{
#region Event & Awake
    private UnityAction moveAction;
    private void Awake()
    {
        moveAction = new UnityAction(Move);
    }
    private void OnEnable()
    {
        EventManager.StartListening(MOVE, moveAction);
    }
    private void OnDisable()
    {
        EventManager.StopListening(MOVE, moveAction);
    }

    private void Move()
    {
        Vector3 dest = OnscreenRay.hitPosition;

        transform.position = dest;
    }
#endregion
}
