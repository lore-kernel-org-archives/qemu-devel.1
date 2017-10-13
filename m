Received: from eggs.gnu.org ([2001:4830:134:3::10]:59725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e30Rq-0004SR-Fg
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e30Rn-0008BD-Dt
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:56:22 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:52780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1e30Rn-000642-1D
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:56:19 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1506954812-6552-7-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1506954812-6552-7-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Fri, 13 Oct 2017 15:55:27 +0200
Message-ID: <w51infjjgog.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v13 6/6] fsdev: hmp interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Mon 02 Oct 2017 04:33:32 PM CEST, Pradeep Jagadeesh wrote:
> This patch introduces hmp interfaces for the fsdev
> devices.
>
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>

It seems that you changed this patch since the last time I reviewed it,
so please when you modify a patch remove the Reviewed-by lines unless
the changes are trivial.

I have anyway just checked the new one so,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
