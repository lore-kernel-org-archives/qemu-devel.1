Received: from eggs.gnu.org ([209.51.188.92]:36974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj9Ig-0005pl-6Q
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj9If-00035r-3W
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 15:57:38 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190114133257.30299-3-stefanha@redhat.com>
References: <20190114133257.30299-1-stefanha@redhat.com>
	<20190114133257.30299-3-stefanha@redhat.com>
Date: Mon, 14 Jan 2019 21:57:21 +0100
Message-ID: <w51ef9f7ya6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: add 238 for throttling tgm
 unregister iothread segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Mon 14 Jan 2019 02:32:57 PM CET, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Hot-unplug a scsi-hd using an iothread.  The previous patch fixes a
> segfault in this scenario.
>
> This patch adds a regression test.
>
> Suggested-by: Alberto Garcia <berto@igalia.com>
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
