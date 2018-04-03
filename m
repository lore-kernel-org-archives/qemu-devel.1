Received: from eggs.gnu.org ([2001:4830:134:3::10]:36518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Nu3-0004fz-Tq
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Nu0-0003EB-Lx
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:31:19 -0400
Date: Tue, 3 Apr 2018 17:30:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180403153055.GH11070@localhost.localdomain>
References: <1522421052-8657-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522421052-8657-1-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH for 2.12] iotests: fix 208 for luks format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, stefanha@redhat.com

Am 30.03.2018 um 16:44 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Support luks images creatins like in 205
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks, applied to the block branch.

Kevin
