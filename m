Received: from eggs.gnu.org ([2001:4830:134:3::10]:40130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dMz54-0006QU-79
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dMz51-0004sY-3Z
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:59:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dMz50-0004rx-Tl
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:59:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5FBE41A53
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 15:59:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1497876588-947-1-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Mon, 19 Jun 2017 20:49:35 +0800")
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 19 Jun 2017 17:59:02 +0200
Message-ID: <87fuew9dfd.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 00/13] migration: objectify
 MigrationState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> v3 contains too much new things. So here comes a new cover letter with
> richer information.
>
> The main goal of this series is to let MigrationState be a QDev.
>
> It helps in many use cases.

Hi

I haven't reviewed the qdev part of the patches (it is a landmine for
me).  But I like the result of it.

Well done, Juan.
