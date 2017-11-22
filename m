Received: from eggs.gnu.org ([2001:4830:134:3::10]:42894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHXgl-0000QK-H4
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHXgk-0002YJ-Kz
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:15:51 -0500
Date: Wed, 22 Nov 2017 17:15:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171122161535.GB10954@localhost.localdomain>
References: <20171122001656.12996-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171122001656.12996-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 075 and 078
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, ldoktor@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

Am 22.11.2017 um 01:16 hat John Snow geschrieben:
> Both of these tests are for formats which now stipulate that they are
> read-only. Adjust the tests to match.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Oh, right, seems I forgot about the tests...

Thanks, applied to the block branch.

Kevin
