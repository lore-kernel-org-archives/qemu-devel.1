Received: from eggs.gnu.org ([2001:4830:134:3::10]:34958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gTql1-0000SC-M4
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gTqkv-0002Nk-Ps
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:07:39 -0500
Date: Mon, 3 Dec 2018 17:07:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181203160724.GC6847@localhost.localdomain>
References: <20181203151209.17331-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203151209.17331-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.1 v3] iotests: simple mirror test
 with kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, dplotnikov@virtuozzo.com

Am 03.12.2018 um 16:12 hat Max Reitz geschrieben:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> This test is broken without previous commit fixing dead-lock in mirror.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Thanks, applied to the block branch.

Kevin
