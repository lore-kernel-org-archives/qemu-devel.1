Received: from eggs.gnu.org ([2001:4830:134:3::10]:42947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fb3zG-0008L8-BR
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fb3zC-0007KE-DF
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:07:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48450 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fb3zC-0007Ip-7f
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:07:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2DF64023132
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 13:07:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180705031755.3254-8-peterx@redhat.com> (Peter Xu's message of
	"Thu, 5 Jul 2018 11:17:53 +0800")
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180705031755.3254-8-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 05 Jul 2018 15:07:42 +0200
Message-ID: <878t6p25lt.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 7/9] tests: introduce
 wait_for_migration_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> It's generalized from wait_for_migration_complete() to allow us to wait
> for any migration status besides failure.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
