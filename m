Received: from eggs.gnu.org ([2001:4830:134:3::10]:59070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fG4JY-0005Sz-FQ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fG4JT-0007ON-TI
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fG4JT-0007Ny-Ox
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:13:59 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180502104740.12123-3-peterx@redhat.com> (Peter Xu's message of
	"Wed, 2 May 2018 18:47:18 +0800")
References: <20180502104740.12123-1-peterx@redhat.com>
	<20180502104740.12123-3-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 08 May 2018 17:16:15 +0200
Message-ID: <87r2mm6uv4.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 02/24] migration: new postcopy-pause
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Introducing a new state "postcopy-paused", which can be used when the
> postcopy migration is paused. It is targeted for postcopy network
> failure recovery.
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

> +# @postcopy-paused: during postcopy but paused. (since 2.12)
> +#

since 2.13
will fix it when I queue it.
