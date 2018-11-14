Received: from eggs.gnu.org ([2001:4830:134:3::10]:39547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMwGl-0000OF-Ei
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMwGk-0003aw-Bx
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:35:51 -0500
Date: Wed, 14 Nov 2018 15:35:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181114143526.GD10481@dhcp-200-186.str.redhat.com>
References: <20181113230319.1008531-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113230319.1008531-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 3.1 v3 0/3] minor qcow2 compression
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, berto@igalia.com, qemu-block@nongnu.org, mreitz@redhat.com

Am 14.11.2018 um 00:03 hat Eric Blake geschrieben:
> As the added iotests shows, we have a (corner case) data corruption
> that is user triggerable, therefore, this is still appropriate for
> inclusion in 3.1.

Thanks, applied to the block branch.

Kevin
