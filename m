Received: from eggs.gnu.org ([2001:4830:134:3::10]:35251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ebsTk-0000T3-JD
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 13:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ebsTj-0001Mi-Op
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 13:30:28 -0500
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-14-vsementsov@virtuozzo.com>
	<20171228063330.GL9192@lemon>
	<e7950241-1eee-a415-3e28-9468f1020d1b@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <17c25946-8cce-21e8-d70f-856fb1924b8c@redhat.com>
Date: Wed, 17 Jan 2018 13:30:02 -0500
MIME-Version: 1.0
In-Reply-To: <e7950241-1eee-a415-3e28-9468f1020d1b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 13/13] iotests: add dirty bitmap
 postcopy test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com



On 12/28/2017 06:49 AM, Vladimir Sementsov-Ogievskiy wrote:
> Thank you for reviewing my code!
> 

Time for the re-spin? There's pretty good pressure to get this into 2.12
and say the non-nbd workflow model is feature complete.
