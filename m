Received: from eggs.gnu.org ([2001:4830:134:3::10]:37052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqbEE-0007lH-0A
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 04:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqbEA-0003q7-3n
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 04:02:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqbE9-0003q3-VG
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 04:02:42 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490115473-24839-1-git-send-email-armbru@redhat.com>
	<1694034280.9874888.1490162829201.JavaMail.zimbra@oxygem.tv>
Date: Wed, 22 Mar 2017 09:02:38 +0100
In-Reply-To: <1694034280.9874888.1490162829201.JavaMail.zimbra@oxygem.tv>
	(Alexandre DERUMIER's message of "Wed, 22 Mar 2017 07:07:09 +0100
	(CET)")
Message-ID: <87tw6lagdd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: Declare blockdev-add and
 blockdev-del supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-devel <qemu-devel@nongnu.org>, mreitz <mreitz@redhat.com>

Alexandre DERUMIER <aderumier@odiso.com> writes:

> Pretty awesome news ! Congrat !

Thanks!

> So, can we update the wiki changelog ?

We need to get the patch merged first.

> http://wiki.qemu-project.org/ChangeLog/2.9
>
> "QMP command blockdev-add is still a work in progress. It doesn't support all block drivers, it lacks a matching blockdev-del, and more. It might change incompatibly."
