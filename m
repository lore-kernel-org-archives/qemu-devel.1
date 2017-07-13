Received: from eggs.gnu.org ([2001:4830:134:3::10]:44205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVdcW-0007gY-FK
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVdcT-000122-8s
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:53:28 -0400
References: <20170707203049.534-1-eblake@redhat.com>
	<20170707203049.534-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <bb672e46-af19-a3ae-482d-7180016be38d@virtuozzo.com>
Date: Thu, 13 Jul 2017 15:53:23 +0300
MIME-Version: 1.0
In-Reply-To: <20170707203049.534-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 4/9] nbd: Simplify trace of client flags
 in negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org

07.07.2017 23:30, Eric Blake wrote:
> Simplify the tracing of client flags in the server, and return -EINVAL
> instead of -EIO if we successfully read but don't like those flags.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir
