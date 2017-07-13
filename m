Received: from eggs.gnu.org ([2001:4830:134:3::10]:43986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVdbi-00072l-SM
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVdbf-0000n5-Lg
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:52:38 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:18026 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dVdbf-0000mX-8u
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:52:35 -0400
References: <20170707203049.534-1-eblake@redhat.com>
	<20170707203049.534-4-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7d63edb2-17c5-05df-f032-d71dd58d4010@virtuozzo.com>
Date: Thu, 13 Jul 2017 15:52:29 +0300
MIME-Version: 1.0
In-Reply-To: <20170707203049.534-4-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 3/9] nbd: Expose and debug more NBD
 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

07.07.2017 23:30, Eric Blake wrote:
> The NBD protocol has several constants defined in various extensions
> that we are about to implement.  Expose them to the code, along with
> an easy way to map various constants to strings during diagnostic
> messages.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

(with or without addition for trace_nbd_send_request)

-- 
Best regards,
Vladimir
