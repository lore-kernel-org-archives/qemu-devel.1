Received: from eggs.gnu.org ([2001:4830:134:3::10]:49919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evPiu-0007oB-QJ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evPiF-00072F-TG
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:50:52 -0400
References: <20180205202232.19254-1-mreitz@redhat.com>
	<73838a0c-d960-d24d-b706-a0ecbcbe7aaf@redhat.com>
	<20180307100424.GA7917@localhost.localdomain>
	<2d97780c-4a06-1b08-8211-760fc3567c2a@redhat.com>
	<20180308021241.GM13844@lemon.usersys.redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d062c042-e69f-566d-7a1f-518e20778f60@redhat.com>
Date: Mon, 12 Mar 2018 11:47:58 -0400
MIME-Version: 1.0
In-Reply-To: <20180308021241.GM13844@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] block/ssh: Implement
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 03/07/2018 09:12 PM, Fam Zheng wrote:
> On Wed, 03/07 12:50, John Snow wrote:
>> It's something I'd like to see patchew do, actually:
>>
>> "Here's a list of what's on the list that has no reviews or NACKs, and
>> needs some love"
> 
> It's not hard to define a search condition for that:
> 
> http://patchew.org/search-help
> 
> http://patchew.org/search?q=project%3AQEMU+age%3A%3E1m+not%3Areviewed+not%3Areplied+not%3Amerged+is%3Atested+to%3Aqemu-block
> 
>>
>> coupled with a 30 day "Hey, nobody looked at this" ping to the list
>> before it NACKs a set for being too old.
> 
> If the initial landing of the patch didn't get enough attention, chances are the
> pings will not change much about it especially it's from a bot.
> 
> A summary list sounds good, though.
> 
> Fam
> 

It's not really to *get* the patch attention as much as it's meant to
inform the sender that it's not under consideration anymore.

"Yeah, but everyone knows this...?"

Consider it a formalization of the process.

--js
