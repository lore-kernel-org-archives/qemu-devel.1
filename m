Received: from eggs.gnu.org ([2001:4830:134:3::10]:36263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gC8li-0006Xi-DL
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gC8lh-0005fF-R6
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:43:10 -0400
Date: Mon, 15 Oct 2018 16:43:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181015194300.GZ31060@habkost.net>
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015141453.32632-3-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/9] iotests: Flush in iotests.py's
 QemuIoInteractive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Mon, Oct 15, 2018 at 04:14:46PM +0200, Max Reitz wrote:
> After issuing a command, flush the pipe.  This does not change anything
> in Python 2, but it makes a difference in Python 3.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
