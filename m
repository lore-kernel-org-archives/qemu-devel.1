Received: from eggs.gnu.org ([2001:4830:134:3::10]:55232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfMxd-0005aI-05
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfMxY-0000uI-UM
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:07:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfMxY-0000ts-Ne
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:07:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C881DC0733FC
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 09:07:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-8-eblake@redhat.com>
Date: Wed, 09 Aug 2017 11:07:18 +0200
In-Reply-To: <20170804012551.2714-8-eblake@redhat.com> (Eric Blake's message
	of "Thu, 3 Aug 2017 20:25:36 -0500")
Message-ID: <87tw1hun21.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 07/22] numa-test: Use hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> Don't open-code something that has a convenient helper available.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
