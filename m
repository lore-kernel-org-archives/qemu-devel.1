Received: from eggs.gnu.org ([209.51.188.92]:49746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpcP2-00062o-IO
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpcP0-000132-Sp
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:14:56 -0500
Date: Fri, 1 Feb 2019 18:14:45 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190201171445.GB31750@localhost.localdomain>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-4-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548942405-760115-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v11 3/3] qemu-img info: bitmaps extension
 new test 239
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Am 31.01.2019 um 14:46 hat Andrey Shinkevich geschrieben:
> A new test file 239 added to the qemu-iotests set. It checks
> the output format of 'qemu-img info' for bitmaps extension of
> qcow2 specific information.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

239 is already taken, so please rename this one. I usually search the
mailing list for "239.out" etc. until I find a number that nobody has
used even in a patch series yet.

Kevin
