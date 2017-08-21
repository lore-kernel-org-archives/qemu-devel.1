Received: from eggs.gnu.org ([2001:4830:134:3::10]:35075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1djwCy-0007J5-GM
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 19:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1djwCx-000771-PX
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 19:34:12 -0400
References: <20170710163029.129912-1-vsementsov@virtuozzo.com>
	<20170710163029.129912-4-vsementsov@virtuozzo.com>
	<20170711130650.GD2223@work-vm>
	<2394bb38-de82-8621-eeae-14ffea68869b@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b802048c-f5c0-efff-5550-6faed26023cd@redhat.com>
Date: Mon, 21 Aug 2017 19:34:00 -0400
MIME-Version: 1.0
In-Reply-To: <2394bb38-de82-8621-eeae-14ffea68869b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 03/16] migration: split common postcopy
 out of ram postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, mreitz@redhat.com



On 07/11/2017 09:38 AM, Vladimir Sementsov-Ogievskiy wrote:
> 11.07.2017 16:06, Dr. David Alan Gilbert wrote:
>> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>>> Split common postcopy staff from ram postcopy staff.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> I'm OK with this; I'm not sure I'd have bothered making the ping's
>> dependent on it being RAM.
>>
>> (These first few are pretty much a separable series).
> 
> It would be grate if you (or Juan?) can take them separately.
> 

Yes please. I don't think this ever happened, did it? Can we split off
1-3 and re-roll?
