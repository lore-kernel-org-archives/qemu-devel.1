Received: from eggs.gnu.org ([2001:4830:134:3::10]:53270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evh5F-0001LI-NK
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evh5E-00032Y-VN
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:23:05 -0400
Date: Tue, 13 Mar 2018 11:22:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180313102240.GA4642@localhost.localdomain>
References: <20180312165528.8969-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312165528.8969-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] vdi: Implement .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, Eric Blake <eblake@redhat.com>

Am 12.03.2018 um 17:55 hat Max Reitz geschrieben:
> I think cluster-size should not be exposed in QAPI (yet), but Kevin's
> patch does that, while I had these patches lying around, so here is my
> proposal.

Thanks, applied to the block branch.

Kevin
