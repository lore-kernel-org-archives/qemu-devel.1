Received: from eggs.gnu.org ([2001:4830:134:3::10]:55809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dcCme-0000as-Eu
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dcCmb-0003Mm-9j
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:39:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dcCmb-0003MS-4E
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:39:01 -0400
Date: Mon, 31 Jul 2017 17:38:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170731173850.20412b29@gondolin>
In-Reply-To: <2f00b91b-a6dc-5b3a-c631-97e600891d6b@virtuozzo.com>
References: <20170729131159.24949-1-vsementsov@virtuozzo.com>
	<20170729131159.24949-5-vsementsov@virtuozzo.com>
	<20170731114949.5edc8b1f@gondolin>
	<2f00b91b-a6dc-5b3a-c631-97e600891d6b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] trace-events: fix code style: print
 0x before hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, stefanha@gmail.com, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com

On Mon, 31 Jul 2017 18:05:46 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> 31.07.2017 12:49, Cornelia Huck wrote:
> > On Sat, 29 Jul 2017 16:11:59 +0300
> > Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> >  
> >> The only exception are groups of numers separated by symbols
> >> '.', ' ', ':', '/', like 'ab.09.7d'.
> >>  
> > (...)  
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> > s390x related changes above:
> >
> > Acked-by: Cornelia Huck <cohuck@redhat.com>  
> 
> Thank you!
> 
> Don't know, should I add 'Acked-by's into commit message for the next 
> version?

Yes, please do so.
