Received: from eggs.gnu.org ([2001:4830:134:3::10]:44132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eNJen-0000AM-Nm
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eNJen-0005m8-1z
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:29:41 -0500
Date: Fri, 8 Dec 2017 15:29:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171208142926.GF4217@localhost.localdomain>
References: <20171205010820.27732-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205010820.27732-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] iotests: fix 197 for vpc
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

Am 05.12.2017 um 02:08 hat John Snow geschrieben:
> VPC has some difficulty creating geometries of particular size.
> However, we can indeed force it to use a literal one, so let's
> do that for the sake of test 197, which is testing some specific
> offsets.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, applied to block-next.

Kevin
