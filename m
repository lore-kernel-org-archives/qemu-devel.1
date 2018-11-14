Received: from eggs.gnu.org ([2001:4830:134:3::10]:59978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gMsjW-0008W1-FV
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gMsjS-00061q-1X
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:49:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gMsjR-00061P-So
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:49:13 -0500
Date: Wed, 14 Nov 2018 18:48:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181114104857.GC3955@xz-x1>
References: <20181114071611.5352-1-peterx@redhat.com>
	<20181114103723.GB2390@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114103723.GB2390@work-vm>
Subject: Re: [Qemu-devel] [PATCH] replication: Make --disable-replication
 compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Yanan Fu <yfu@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Nov 14, 2018 at 10:37:23AM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > We've fixed it before like 38bb54f323 ("replication: Make
> > --disable-replication compile again", 2017-04-28) but it's failing
> > again.  So fix it again.
> > 
> > There could be even cleaner way to fix this but current way is the
> > simplest.  Let's start from simple.
> 
> This is I think the same as the patch posted 1st November:
>   Fix compilation issue when disable replication

Yep, thanks for pointing out.  Please ignore this patch.

Regards,

-- 
Peter Xu
