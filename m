Received: from eggs.gnu.org ([2001:4830:134:3::10]:36698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gOsqd-0002Y4-1K
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gOsqY-0005o7-5f
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:20:55 -0500
Date: Mon, 19 Nov 2018 21:20:47 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181119232047.GN3807@habkost.net>
References: <20181115211752.1295571-1-eblake@redhat.com>
	<20181115211752.1295571-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115211752.1295571-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] numa: Match struct to typedef name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, armbru@redhat.com

On Thu, Nov 15, 2018 at 03:17:52PM -0600, Eric Blake wrote:
> There's no reason to violate our naming conventions by having a
> struct with a different name than its typedef.  Messed up since
> its introduction in commit 8c85901e, but made more obvious when
> commit 3bfe5716 promoted it to typedefs.h.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Queued on numa-next, thanks.

-- 
Eduardo
