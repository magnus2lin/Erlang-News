<li>
    <div>

    <div class="right_row" style="background-color:transparent" onclick="openUpStuff(<?php echo '{id},{index}' ?>);">
                <div style="padding:0.5em;line-height:80%;">
                        <a class="right_title">{title}</a></br>
                        <span class="right_source" style="margin-left:12px;"> 
                        <a onclick="openBox(<?php echo '{id},{index}' ?>)">{host}</a></span>  
                </div>  
    </div>
    </div>
    <div id="{location}_{id}_expand" class="right_content">
        <div id="{id}_content">
            <div class="blue-seperator"></div>
            <table>
                <tr>

                    <td class="voting">
                        <div>
                            <div id="{location}_{id}_{action1}" class="thumb-up" onclick="articleAction(this,1,false)"></div>
                            <div id="{location}_{id}_{action1}_active" class="thumb-up-active" onclick="articleAction(this,1,true)"></div>
                            <div id="{location}_{id}_{action0}" class="thumb-down" onclick="articleAction(this,0,false)"></div>
                            <div id="{location}_{id}_{action0}_active" class="thumb-down-active" onclick="articleAction(this,0,true)"></div>
                        </div>
                    </td>
                    <td>
                    <div style="width:100%;">
                        <div class="blue-desc" style="line-height:130%;">{description}</div><span class="blue-readMore" ><a style="cursor:pointer;"  target="_blank" onmouseover="JavaScript:windows.status='this link blaber';
                            return true;" onmouseout="window.status=''" onclick="openBox(<?php echo '{id},{index}' ?>)">Read more..</a></span>
                        <div class="seperator" style="margin-top:20px"></div>
                        
                        <div class="right_source" style="font-family:'Times New Roman';font-style:italic;font-size:6pt;color:rgba(0,0,0,0.4);margin-right:10px;">Published: {pubdate}</div>


                    </div>
                    </td>
                </tr>
            </table>
            <table id="{id}_all_vote_buttons" style="display:none;">
                                <tr>
                                    <td>
                                        <div id="{location}_{id}_{action1}_extra" class="thumb-up-shadowed" onclick="articleAction(this,1,false);getNewsJSON(false, true)"></div>
                                        <div id="{location}_{id}_{action1}_extra_active" class="thumb-up-active-shadowed" onclick="articleAction(this,1,true);getNewsJSON(false, true)"></div>
                                    </td>
                                    <td>
                                        <div id="{location}_{id}_{action0}_extra" class="thumb-down-shadowed" onclick="articleAction(this,0,false);getNewsJSON(false, true)"></div>
                                        <div id="{location}_{id}_{action0}_extra_active" class="thumb-down-active-shadowed" onclick="articleAction(this,0,true);getNewsJSON(false, true)"></div>
                                    </td>
                                </tr>
                            </table>
            <div align="right" class="arrow-container">
                <div class="arrow-up"></div>
            </div>

        </div>
    </div>
    </div>
</li>