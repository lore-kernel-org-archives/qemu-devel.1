Received: from eggs.gnu.org ([2001:4830:134:3::10]:57164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gJh5m-00045J-BL
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gJh4K-0007xp-DT
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:45:39 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181101182738.70462-3-vsementsov@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
	<20181101182738.70462-3-vsementsov@virtuozzo.com>
Date: Mon, 05 Nov 2018 16:45:17 +0100
Message-ID: <w51pnvjil4i.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/7] qcow2: make more generic
 interface for qcow2_compress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

On Thu 01 Nov 2018 07:27:33 PM CET, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> Give explicit size both for source and destination buffers, to make it
> similar with decompression path and than cleanly reuse parameter
> structure for decompression threads.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
