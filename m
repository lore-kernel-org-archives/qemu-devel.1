Received: from eggs.gnu.org ([2001:4830:134:3::10]:50138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmg8a-0000IO-ME
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 09:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmg8W-0002wU-6D
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 09:01:00 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1501597152-25342-6-git-send-email-anton.nefedov@virtuozzo.com>
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1501597152-25342-6-git-send-email-anton.nefedov@virtuozzo.com>
Date: Tue, 29 Aug 2017 15:00:51 +0200
Message-ID: <w51val6frzw.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 05/15] file-posix: support
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
Cc: kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, mreitz@redhat.com

On Tue 01 Aug 2017 04:19:02 PM CEST, Anton Nefedov wrote:
> Current write_zeroes implementation is good enough to satisfy this flag too
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
