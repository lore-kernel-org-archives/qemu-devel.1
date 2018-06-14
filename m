Received: from eggs.gnu.org ([2001:4830:134:3::10]:42741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTS8M-0006cP-JZ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTS8L-0002bg-Qa
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:17:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180614095544.31549-1-kwolf@redhat.com>
	<20180614095544.31549-5-kwolf@redhat.com>
Date: Thu, 14 Jun 2018 15:17:42 +0200
In-Reply-To: <20180614095544.31549-5-kwolf@redhat.com> (Kevin Wolf's message
	of "Thu, 14 Jun 2018 11:55:44 +0200")
Message-ID: <87muvxik21.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/4] block: Remove dead deprecation
 warning code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> We removed all options from the 'deprecated' array, so the code is dead
> and can be removed as well.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
