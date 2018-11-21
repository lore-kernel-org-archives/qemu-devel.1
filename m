Received: from eggs.gnu.org ([2001:4830:134:3::10]:46145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gPP9L-00006w-8o
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:50:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gPP9K-0007vT-Ev
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:50:23 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:37300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1gPP9K-0007rf-8N
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:50:22 -0500
Received: by mail-wr1-x429.google.com with SMTP id j10so4945151wru.4
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 01:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20181114190912.7242-1-chen.zhang@intel.com>
	<20181115035441.GC27915@xz-x1>
In-Reply-To: <20181115035441.GC27915@xz-x1>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 21 Nov 2018 17:50:08 +0800
Message-ID: <CAK3tnvJysLD-LQMo3kTimX5T75fqbvh5aBdFczR=OEit+OwwxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration/migration.c: Add COLO dependency
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peterx@redhat.com
Cc: Zhang Chen <chen.zhang@intel.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Thu, Nov 15, 2018 at 11:55 AM Peter Xu <peterx@redhat.com> wrote:

> On Thu, Nov 15, 2018 at 03:09:12AM +0800, Zhang Chen wrote:
> > From: Zhang Chen <chen.zhang@intel.com>
> >
> > Current COLO mode(independent disk mode) need replication module work
> > together. Suggested by Dr. David Alan Gilbert <dgilbert@redhat.com>.
> >
> > Signed-off-by: Zhang Chen <chen.zhang@intel.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
>
Thanks Peter,
any comments from others?

Thanks
Zhang Chen


> Regards,
>
> --
> Peter Xu
>
>
