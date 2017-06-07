Received: from eggs.gnu.org ([2001:4830:134:3::10]:43798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIaXu-0006yK-J7
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIaXq-000824-OO
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:58:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIaXq-00081V-IM
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:58:42 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496828798-27548-9-git-send-email-a.perevalov@samsung.com>
	(Alexey Perevalov's message of "Wed, 07 Jun 2017 12:46:35 +0300")
References: <1496828798-27548-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607094730eucas1p2126d9850427e7b4af92898b64b7b805a@eucas1p2.samsung.com>
	<1496828798-27548-9-git-send-email-a.perevalov@samsung.com>
Reply-To: quintela@redhat.com
Date: Wed, 07 Jun 2017 14:58:40 +0200
Message-ID: <87h8zseyyn.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 08/11] migration: postcopy_place_page
 factoring out
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, dgilbert@redhat.com

Alexey Perevalov <a.perevalov@samsung.com> wrote:
> Need to mark paged copied as closer as possible place where it
> tracks down. That will be necessary in futher patch.
>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
