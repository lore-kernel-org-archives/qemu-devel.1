Received: from eggs.gnu.org ([2001:4830:134:3::10]:53544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpAMB-0000Yy-VE
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpAM4-0008RW-FI
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:41:19 -0400
Date: Tue, 5 Sep 2017 11:40:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170905094058.GE4633@localhost.localdomain>
References: <20170831105456.9558-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170831105456.9558-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] block: document semantics of
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

Am 31.08.2017 um 12:54 hat Daniel P. Berrange geschrieben:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Thanks, applied to the block branch.

Kevin
