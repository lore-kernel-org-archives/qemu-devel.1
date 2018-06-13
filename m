Received: from eggs.gnu.org ([2001:4830:134:3::10]:40713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fT6O9-0007Gc-4e
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fT6Nz-0002Rr-Ph
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:04:41 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180613123458.24685-1-kwolf@redhat.com>
	<20180613123458.24685-3-kwolf@redhat.com>
Date: Wed, 13 Jun 2018 16:04:26 +0200
In-Reply-To: <20180613123458.24685-3-kwolf@redhat.com> (Kevin Wolf's message
	of "Wed, 13 Jun 2018 14:34:57 +0200")
Message-ID: <87tvq6ixzp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/3] block: Remove deprecated -drive option
 addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> The -drive option addr was deprecated in QEMU 2.10. It's time to remove
> it.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

One of my first additions to QEMU...  and a bit of an embarrassment.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
