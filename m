Received: from eggs.gnu.org ([2001:4830:134:3::10]:34416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5ooC-0000AS-BO
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 04:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5oo9-0004hR-7k
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 04:39:20 -0400
Date: Tue, 10 Apr 2018 10:38:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180410083848.GB7026@localhost.localdomain>
References: <20180409114418.16615-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409114418.16615-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] iotests: blacklist bochs and cloop
 for 205 and 208
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com, eblake@redhat.com, stefanha@redhat.com

Am 09.04.2018 um 13:44 hat Vladimir Sementsov-Ogievskiy geschrieben:
> v2: move from unsupported_fmts to support "generic", like in bash tests.

Thanks, applied to the block branch.

Kevin
