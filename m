Received: from eggs.gnu.org ([2001:4830:134:3::10]:59800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dPQgg-0000Fg-PS
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dPQgd-0001su-OY
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:52:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dPQgd-0001s7-IG
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:52:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7371E80B29
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 09:52:01 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170624181008.25497-1-eblake@redhat.com>
Date: Mon, 26 Jun 2017 11:51:55 +0200
In-Reply-To: <20170624181008.25497-1-eblake@redhat.com> (Eric Blake's message
	of "Sat, 24 Jun 2017 12:10:06 -0600")
Message-ID: <87shinxeis.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/2] qobject coccinelle followups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, stefanha@redhat.com

Eric Blake <eblake@redhat.com> writes:

> v1 was here:
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02589.html
>
> Since then:
> - reorder the series
> - add R-b on patch 1

You missed Max's.  Adding it in my tree.

> - patch 2 updated to catch recent introduction of longhand usage

Applied to qapi-next.  Thanks!
