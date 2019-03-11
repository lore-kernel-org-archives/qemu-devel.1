Received: from eggs.gnu.org ([209.51.188.92]:35338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3OTy-0003pK-4B
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3OHY-0006x4-8h
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:00:08 -0400
Date: Mon, 11 Mar 2019 18:00:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190311170000.GE7899@localhost.localdomain>
References: <20190311165017.32247-1-kwolf@redhat.com>
	<20190311165017.32247-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311165017.32247-4-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/10] block: Avoid useless local_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

Am 11.03.2019 um 17:50 hat Kevin Wolf geschrieben:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Forgot to apply a Reviewed-by from Berto. I've added it locally now.

Kevin
