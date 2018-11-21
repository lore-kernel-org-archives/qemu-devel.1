Received: from eggs.gnu.org ([2001:4830:134:3::10]:46941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPPCD-00010L-I8
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:53:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPPCA-0002Ug-Do
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:53:21 -0500
Date: Wed, 21 Nov 2018 10:48:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181121094807.GB4030@linux.fritz.box>
References: <20181119101921.31949-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119101921.31949-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-next? 0/2] qemu-img: Minor fixes to an
 amend error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org

Am 19.11.2018 um 11:19 hat Max Reitz geschrieben:
> One of the amend error paths has two issues that are fixed by this
> series.  Since they are relatively minor and have been present in 3.0
> already, I think there is no need to get them into 3.1.  OTOH they are
> bug fixes, so they could go into 3.1 if you, dear reader, insist.

Thanks, applied to the block branch (looks like the dear reader
insists).

Kevin
