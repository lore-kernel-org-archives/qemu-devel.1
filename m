Received: from eggs.gnu.org ([2001:4830:134:3::10]:33405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdiPj-0007n7-Mu
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdiPi-0004TD-LI
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:05:23 -0500
Date: Tue, 14 Feb 2017 20:05:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170214190514.GD6189@noname.redhat.com>
References: <cover.1487088544.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1487088544.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] qemu-iotest tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 14.02.2017 um 17:21 hat Jeff Cody geschrieben:
> Some minor qemu-iotest tweaks.
> 
> The second patch makes it easier to add some upcoming protocols such as VXHS,
> that do not support .bdrv_create.

Thanks, applied to the block branch.

Kevin
