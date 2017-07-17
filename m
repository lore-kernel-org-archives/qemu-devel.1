Received: from eggs.gnu.org ([2001:4830:134:3::10]:60534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX9Rr-00036h-3Y
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX9Rm-0000m3-3X
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:04:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX9Rl-0000lf-UA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:04:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FF727CE1B
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:04:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1500279971-13875-6-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Mon, 17 Jul 2017 16:26:05 +0800")
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-6-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 17 Jul 2017 19:04:31 +0200
Message-ID: <874lub0zc0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 05/11] migration: introduce
 migrate_params_check()
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
> Helper to check the parameters. Abstracted from
> qmp_migrate_set_parameters().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
