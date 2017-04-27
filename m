Received: from eggs.gnu.org ([2001:4830:134:3::10]:52509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3jkn-0004pL-Sx
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3jkn-0003hU-7y
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:46:41 -0400
Date: Thu, 27 Apr 2017 15:46:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170427134632.GD4805@noname.str.redhat.com>
References: <20170426221046.4596-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426221046.4596-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix typo in 026
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Am 27.04.2017 um 00:10 hat Eric Blake geschrieben:
> s/refcout/refcount/
> 
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>

Thanks, applied to block-next.

Kevin
