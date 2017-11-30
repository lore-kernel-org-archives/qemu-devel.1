Received: from eggs.gnu.org ([2001:4830:134:3::10]:47665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKMjv-0005NU-Ua
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKMjs-0005fg-3x
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:10:47 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-14-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9afddae9-d6b7-d202-f1ba-fa3cb12a1798@virtuozzo.com>
Date: Thu, 30 Nov 2017 14:10:24 +0300
MIME-Version: 1.0
In-Reply-To: <20171012185916.22776-14-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 13/20] raw: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

12.10.2017 21:59, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the raw driver accordingly.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir
