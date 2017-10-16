Received: from eggs.gnu.org ([2001:4830:134:3::10]:45540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e43Gs-0004m1-Ve
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e43Go-0000Og-VM
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:09:22 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-7-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cd52c47b-656a-e61f-f9bf-dffa29b15c09@virtuozzo.com>
Date: Mon, 16 Oct 2017 14:09:16 +0300
MIME-Version: 1.0
In-Reply-To: <20171015010131.12172-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 6/8] nbd/client: refactor
 nbd_receive_starttls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

15.10.2017 04:01, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Split out nbd_request_simple_option to be reused for structured reply
> option.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>

ok for me.


-- 
Best regards,
Vladimir
