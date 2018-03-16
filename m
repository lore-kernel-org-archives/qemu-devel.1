Received: from eggs.gnu.org ([2001:4830:134:3::10]:46175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewp64-00017n-Ro
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 09:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewp64-0002HZ-2c
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 09:08:36 -0400
Date: Fri, 16 Mar 2018 14:08:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180316130812.GB5851@localhost.localdomain>
References: <22815ed651022a08563b60219a5dd9dd81f92ae5.1520890118.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22815ed651022a08563b60219a5dd9dd81f92ae5.1520890118.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] block: fix iotest 146 output
 expectations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 12.03.2018 um 22:29 hat Jeff Cody geschrieben:
> Commit bff5554843 added "force_size" into the common.filter for
> _filter_img_create(), but test 146 still expects it in the output.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>

Thanks, applied to the block branch.

Kevin
