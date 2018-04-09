function UseQuestReward( skill )
    net.Start("cl_chooserewardskill")
    net.WriteString(skill)
    net.SendToServer()
end