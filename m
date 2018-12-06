Received: from eggs.gnu.org ([2001:4830:134:3::10]:38282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUnd4-0001tz-PT
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUncy-0001AJ-HL
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:59:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUncv-0000yJ-LL
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:59:13 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181205194701.17836-1-danielhb413@gmail.com>
Date: Thu, 06 Dec 2018 07:59:02 +0100
In-Reply-To: <20181205194701.17836-1-danielhb413@gmail.com> (Daniel Henrique
	Barboza's message of "Wed, 5 Dec 2018 17:46:58 -0200")
Message-ID: <87pnufjg3t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 0/3] wakeup-from-suspend and
 system_wakeup changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, mdroth@linux.vnet.ibm.com, imammedo@redhat.com

Daniel Henrique Barboza <danielhb413@gmail.com> writes:

> changes in v11:
> - fixed typos, changed version to 4.0 in patches 1 and 3
> - changed text in patch 2 to be less alarming
> - patch 3: changed error handling
> - previous version link:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg01774.html

Looks ready to me.  Who's going to merge it?
