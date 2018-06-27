Received: from eggs.gnu.org ([2001:4830:134:3::10]:47761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fY9vh-0006ga-VH
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fY9vh-0006Mq-AT
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:52:14 -0400
Date: Wed, 27 Jun 2018 14:52:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180627125200.GD4340@localhost.localdomain>
References: <20180627035752.1425-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627035752.1425-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] block: Two copy offloading corrections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 27.06.2018 um 05:57 hat Fam Zheng geschrieben:
> Fam Zheng (2):
>   qcow2: Remove dead check on !ret
>   block: Move request tracking to children in copy offloading

Thanks, applied to the block branch.

Kevin
