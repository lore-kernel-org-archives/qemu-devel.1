Received: from eggs.gnu.org ([2001:4830:134:3::10]:54200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3NS3-0001Rq-G2
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3NS2-0000v5-Se
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:02:23 -0400
Date: Tue, 3 Apr 2018 17:02:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180403150202.GG11070@localhost.localdomain>
References: <cover.1521729843.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1521729843.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v4 0/2] Update output of some
 iotests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 22.03.2018 um 15:45 hat Alberto Garcia geschrieben:
> I sent a patch a few days ago correction the output of iotests 051 and
> 186. I wanted to resend it again but I noticed that 186 needs now more
> changes due to commit ac64273c66ab136c44043259162, so I'm including
> those changes too.

[ Cc: qemu-block ]

Thanks, applied to the block branch.

Kevin
