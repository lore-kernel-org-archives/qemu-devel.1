Received: from eggs.gnu.org ([209.51.188.92]:35344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggtaU-0000CX-2h
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggtaS-0007L7-Gs
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:46:41 -0500
Date: Tue, 8 Jan 2019 16:46:28 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190108154628.GG11492@linux.fritz.box>
References: <cover.1542898669.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542898669.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Minor fixes for the mirror block job
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

Am 22.11.2018 um 16:00 hat Alberto Garcia geschrieben:
> Hi,
> 
> a couple of minor fixes for the mirror block job. I don't think these
> bugs can be reproduced at the moment so this shouldn't be 3.1
> material.

Thanks, applied to the block branch.

Kevin
