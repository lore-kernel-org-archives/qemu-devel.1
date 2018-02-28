Received: from eggs.gnu.org ([2001:4830:134:3::10]:36463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er4GV-0006Cc-Sy
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er4GR-0003Fe-O1
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:07:35 -0500
Date: Wed, 28 Feb 2018 17:07:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180228160727.GG4855@localhost.localdomain>
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-14-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223235142.21501-14-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 13/21] blockjobs: add commit, abort,
 clean helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

Am 24.02.2018 um 00:51 hat John Snow geschrieben:
> The completed_single function is getting a little mucked up with
> checking to see which callbacks exist, so let's factor them out.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
