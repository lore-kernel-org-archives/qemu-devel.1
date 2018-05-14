Received: from eggs.gnu.org ([2001:4830:134:3::10]:32877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fIC0H-0005B3-7I
	for qemu-devel@nongnu.org; Mon, 14 May 2018 07:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fIC0D-0005X8-1L
	for qemu-devel@nongnu.org; Mon, 14 May 2018 07:50:57 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1525791496-125188-7-git-send-email-anton.nefedov@virtuozzo.com>
References: <1525791496-125188-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1525791496-125188-7-git-send-email-anton.nefedov@virtuozzo.com>
Date: Mon, 14 May 2018 13:50:48 +0200
Message-ID: <w51vabqcv6v.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 6/9] file-posix: support
 BDRV_REQ_ALLOCATE
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

On Tue 08 May 2018 04:58:13 PM CEST, Anton Nefedov wrote:
> Current write_zeroes implementation is good enough to satisfy this flag too
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
