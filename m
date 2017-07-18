Received: from eggs.gnu.org ([2001:4830:134:3::10]:36088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXNlD-0002iw-Mj
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 04:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXNlA-0003eq-KR
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 04:21:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dXNlA-0003eX-Dt
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 04:21:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E3DAA04F2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 08:21:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1500349150-13240-11-git-send-email-peterx@redhat.com> (Peter
	Xu's message of "Tue, 18 Jul 2017 11:39:10 +0800")
References: <1500349150-13240-1-git-send-email-peterx@redhat.com>
	<1500349150-13240-11-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 18 Jul 2017 10:21:31 +0200
Message-ID: <87iniqyx2s.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 10/10] migration: check global caps for
 validity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Checks validity for all the capabilities that we enabled with command
> line.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
