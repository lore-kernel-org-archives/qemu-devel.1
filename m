Received: from eggs.gnu.org ([2001:4830:134:3::10]:48779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eBnr9-0004J5-Dw
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eBnr8-0007Ol-Ma
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:18:51 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171106165500.30278-1-kwolf@redhat.com>
References: <20171106165500.30278-1-kwolf@redhat.com>
Date: Mon, 06 Nov 2017 21:18:42 +0100
Message-ID: <w51mv3zkvod.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Fix error path in
 bdrv_backing_update_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

On Mon 06 Nov 2017 05:55:00 PM CET, Kevin Wolf <kwolf@redhat.com> wrote:
> error_setg_errno() takes a positive errno code.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
