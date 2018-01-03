Received: from eggs.gnu.org ([2001:4830:134:3::10]:59792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWi8I-0003w2-P7
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:26:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWi8H-0002ZY-V7
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:26:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWi8H-0002Yg-ON
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:26:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1AA55F159
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 12:26:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180103122017.14794-8-peterx@redhat.com> (Peter Xu's message of
	"Wed, 3 Jan 2018 20:20:11 +0800")
References: <20180103122017.14794-1-peterx@redhat.com>
	<20180103122017.14794-8-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 03 Jan 2018 13:26:49 +0100
Message-ID: <87k1wzyvp2.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 07/13] migration: introduce
 migrate_calculate_complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Generalize the calculation part when migration complete into a
> function to simplify migration_thread().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: Juan Quintela <quintela@redhat.com>
