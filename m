Received: from eggs.gnu.org ([2001:4830:134:3::10]:34535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e5cf4-0001Gi-5T
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e5cf0-0003q4-5o
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:08:50 -0400
References: <20171019222637.17890-1-eblake@redhat.com>
	<20171019222637.17890-8-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b5135e3c-6818-873a-cf54-973776519e15@virtuozzo.com>
Date: Fri, 20 Oct 2017 22:08:43 +0300
MIME-Version: 1.0
In-Reply-To: <20171019222637.17890-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 07/11] nbd/server: Include
 human-readable message in structured errors
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

20.10.2017 01:26, Eric Blake wrote:
> The NBD spec permits including a human-readable error string if
> structured replies are in force, so we might as well send the
> client the message that we logged on any error.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir
