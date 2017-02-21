Received: from eggs.gnu.org ([2001:4830:134:3::10]:56714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg8VO-0006Vg-GE
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg8VK-0003vP-Ot
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:21:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cg8VK-0003vC-J9
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:21:10 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487597638-28323-1-git-send-email-armbru@redhat.com>
	<8ed45bc8-6051-ccae-6227-52d8553c04af@cn.fujitsu.com>
Date: Tue, 21 Feb 2017 12:21:07 +0100
In-Reply-To: <8ed45bc8-6051-ccae-6227-52d8553c04af@cn.fujitsu.com> (Zhang
	Chen's message of "Tue, 21 Feb 2017 14:57:48 +0800")
Message-ID: <871surzt5o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 0/2] QAPI patches for 2017-02-20
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org

Zhang Chen <zhangchen.fnst@cn.fujitsu.com> writes:

> Hi~ Markus.
>
> This patch set has been reviewed for a long time, can you pick up it?
>
> [PATCH V7 0/2] Add new qmp commands to suppurt Xen COLO

I think this should go through a COLO maintainer chain, or perhaps the
Xen maintainer, but not the QAPI maintainer (me).  QAPI guys should
provide review, so I just had a look.
