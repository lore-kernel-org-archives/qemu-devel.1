Received: from eggs.gnu.org ([209.51.188.92]:44696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hH2KF-0008AZ-6h
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hH2KE-0004vO-D6
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:23:19 -0400
Date: Thu, 18 Apr 2019 10:23:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190418082310.GB5242@linux.fritz.box>
References: <20190417171101.1254-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417171101.1254-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Saner printing of large file sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org

Am 17.04.2019 um 19:10 hat Eric Blake geschrieben:
> since v2: Fix problems pointed out by Max:
> vmdk (test 59) output had not actually been tested
> 32-bit builds of size_to_str() have been been broken since 2.10

Thanks, applied to the block branch.

Kevin
