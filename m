Received: from eggs.gnu.org ([2001:4830:134:3::10]:40491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgW7R-0007Xg-M0
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgW7Q-0008JR-RL
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:34:05 -0500
Date: Wed, 22 Feb 2017 13:33:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170222123356.GK4112@noname.str.redhat.com>
References: <20170216220000.1004-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170216220000.1004-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: Fix another race in
 030
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

Am 16.02.2017 um 23:00 hat John Snow geschrieben:
> We can't rely on a non-paused job to be present and running for us.
> Assume that if the job is not present that it completed already.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Thanks, applied to the block branch.

Kevin
