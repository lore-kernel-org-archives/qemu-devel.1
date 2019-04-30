Received: from eggs.gnu.org ([209.51.188.92]:47182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQoq-0001QH-Go
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQop-0002KO-5P
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:21:04 -0400
Date: Tue, 30 Apr 2019 13:20:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190430112056.GG5607@linux.fritz.box>
References: <cover.1556540297.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556540297.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] commit: Make base read-only if
 there is an early failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 29.04.2019 um 15:51 hat Alberto Garcia geschrieben:
> Hi,
> 
> Here's v3 of this series, the only changes are the corrections in the
> iotest suggested by Max.

Thanks, applied to the block branch.

Kevin
