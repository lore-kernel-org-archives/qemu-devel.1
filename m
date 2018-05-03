Received: from eggs.gnu.org ([2001:4830:134:3::10]:60516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fE8ke-0002uv-1d
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fE8kd-0005dX-AO
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:34:04 -0400
Date: Thu, 3 May 2018 15:33:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180503073344.GK15438@lemon.usersys.redhat.com>
References: <20180427162312.18583-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427162312.18583-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block/file-posix: allow -drive
 cache.direct=off live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Sergio Lopez <slp@redhat.com>

On Fri, 04/27 17:23, Stefan Hajnoczi wrote:
> v2:
>  * Add comment on !__linux__ situation [Fam]
>  * Add file-posix.c x-check-cache-dropped=on|off option [DaveG, Kevin]

Reviewed-by: Fam Zheng <famz@redhat.com>
