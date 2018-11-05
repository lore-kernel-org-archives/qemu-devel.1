Received: from eggs.gnu.org ([2001:4830:134:3::10]:53709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gJgq2-0005jj-9P
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gJgpw-0006gl-HW
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:30:48 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181101182738.70462-2-vsementsov@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
	<20181101182738.70462-2-vsementsov@virtuozzo.com>
Date: Mon, 05 Nov 2018 16:30:02 +0100
Message-ID: <w51a7mn7dad.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/7] qcow2: use Z_OK instead
 of 0 for deflateInit2 return code check
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

On Thu 01 Nov 2018 07:27:32 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> Use appropriate macro, corresponding to deflateInit2 spec.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
