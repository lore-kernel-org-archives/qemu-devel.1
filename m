Received: from eggs.gnu.org ([2001:4830:134:3::10]:59026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9Dtb-0006M0-RB
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9Dtb-0006Ep-1y
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:30:43 -0400
References: <20171027104037.8319-1-eblake@redhat.com>
	<20171027104037.8319-8-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <db6b8756-b6ad-2495-d5f5-baafef9b6270@virtuozzo.com>
Date: Mon, 30 Oct 2017 20:30:30 +0300
MIME-Version: 1.0
In-Reply-To: <20171027104037.8319-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v6 07/12] nbd: Minimal structured read for
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org

27.10.2017 13:40, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Minimal implementation of structured read: one structured reply chunk,
> no segmentation.
> Minimal structured error implementation: no text message.
> Support DF flag, but just ignore it, as there is no segmentation any
> way.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

ok for me.



-- 
Best regards,
Vladimir
