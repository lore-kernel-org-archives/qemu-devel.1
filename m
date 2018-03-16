Received: from eggs.gnu.org ([2001:4830:134:3::10]:50315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ewn8e-0005oC-MA
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ewn8a-0004iQ-9p
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:03:08 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1520849818-6915-8-git-send-email-anton.nefedov@virtuozzo.com>
References: <1520849818-6915-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1520849818-6915-8-git-send-email-anton.nefedov@virtuozzo.com>
Date: Fri, 16 Mar 2018 12:03:02 +0100
Message-ID: <w51h8pgp9jt.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 7/9] block: support BDRV_REQ_ALLOCATE in
 passthrough drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com

On Mon 12 Mar 2018 11:16:56 AM CET, Anton Nefedov wrote:
> Support the flag if the underlying BDS supports it
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>

This is again not the patch that I reviewed (the quorum bits were not
there), but I just check the changes and they look fine so you can keep
my Reviewed-by line.

Berto
