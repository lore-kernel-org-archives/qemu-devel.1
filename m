Received: from eggs.gnu.org ([2001:4830:134:3::10]:60731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZZDe-0007QG-GL
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZZDd-0003Rg-UQ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:00:02 -0400
Date: Mon, 24 Jul 2017 10:59:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170724085950.GA4630@noname.str.redhat.com>
References: <20170717142620.6970-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717142620.6970-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Remove a few tests from 'quick'
 group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, berrange@redhat.com

Am 17.07.2017 um 16:26 hat Eric Blake geschrieben:
> A run of './check -qcow2 -g quick' on my machine produced only
> two tests that took longer than 5 seconds; 178 took 18, and
> 189 took 7.  Remove them from the quick group.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Thanks, applied to the block branch.

Kevin
