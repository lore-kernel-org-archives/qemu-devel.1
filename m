Received: from eggs.gnu.org ([2001:4830:134:3::10]:33515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcpPP-0003EI-Hy
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcpPO-0003fm-TI
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:58:11 -0400
Date: Tue, 10 Jul 2018 11:58:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180710095803.GB5852@localhost.localdomain>
References: <20180710093802.28308-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710093802.28308-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: 222: Don't run with luks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 10.07.2018 um 11:38 hat Fam Zheng geschrieben:
> Luks needs special parameters to operate the image. Since this test is
> focusing on image fleecing, skip skip that format.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
