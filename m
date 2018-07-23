Received: from eggs.gnu.org ([2001:4830:134:3::10]:59394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhbKw-0002BR-So
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhbKw-0002rf-3U
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:57:18 -0400
Date: Mon, 23 Jul 2018 15:57:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180723135712.GH8817@localhost.localdomain>
References: <20180713191506.14484-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713191506.14484-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Disallow compat=0.10 in 223
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

Am 13.07.2018 um 21:15 hat Max Reitz geschrieben:
> 223 tests persistent dirty bitmaps which are not supported in
> compat=0.10, so that option is unsupported for this test.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Thanks, applied to the block branch.

Kevin
