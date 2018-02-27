Received: from eggs.gnu.org ([2001:4830:134:3::10]:53853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqiu0-0000qo-TQ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqitz-0002d1-Rr
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:18:56 -0500
Date: Tue, 27 Feb 2018 18:18:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180227171843.GF5269@localhost.localdomain>
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-4-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223235142.21501-4-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 03/21] blockjobs: add manual property
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
> This property will be used to opt-in to the new BlockJobs workflow
> that allows a tighter, more explicit control over transitions from
> one runstate to another.
> 
> While we're here, fix up the documentation for block_job_create
> a little bit.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
