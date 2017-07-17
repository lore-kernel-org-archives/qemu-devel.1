Received: from eggs.gnu.org ([2001:4830:134:3::10]:37875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXBGZ-0004WT-7j
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXBGW-0005ba-0S
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:01:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dXBGV-0005ak-Po
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:01:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A7E2C04D28B
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 19:01:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1500279971-13875-7-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Mon, 17 Jul 2017 16:26:06 +0800")
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-7-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 17 Jul 2017 21:01:06 +0200
Message-ID: <87lgnmnb0t.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 06/11] migration: provide
 migrate_params_apply()
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
> Abstracted from qmp_migrate_set_parameters().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
