Received: from eggs.gnu.org ([2001:4830:134:3::10]:55374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dz6Ny-0006ME-5b
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dz6Nx-0003lT-I7
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:28:14 -0400
Date: Mon, 2 Oct 2017 15:28:07 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171002192807.GA22777@stefanha-x1.localdomain>
References: <20170930195345.23338-1-eblake@redhat.com>
	<20170930195345.23338-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170930195345.23338-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/4] qemu-io: Add -C for
 opening with copy-on-read
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Sat, Sep 30, 2017 at 02:53:42PM -0500, Eric Blake wrote:
> Make it easier to enable copy-on-read during iotests, by
> exposing a new bool option to main and open.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-io.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
