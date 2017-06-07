Received: from eggs.gnu.org ([2001:4830:134:3::10]:37923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIaA2-0004as-Ll
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIaA1-0005Lg-U9
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:34:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIaA1-0005L2-Ot
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:34:05 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496828798-27548-6-git-send-email-a.perevalov@samsung.com>
	(Alexey Perevalov's message of "Wed, 07 Jun 2017 12:46:32 +0300")
References: <1496828798-27548-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607094728eucas1p228f096ea7eebf7e791392c9193cefec0@eucas1p2.samsung.com>
	<1496828798-27548-6-git-send-email-a.perevalov@samsung.com>
Reply-To: quintela@redhat.com
Date: Wed, 07 Jun 2017 14:34:00 +0200
Message-ID: <87y3t4f03r.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 05/11] migration: introduce
 postcopy-blocktime capability
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
> Right now it could be used on destination side to
> enable vCPU blocktime calculation for postcopy live migration.
> vCPU blocktime - it's time since vCPU thread was put into
> interruptible sleep, till memory page was copied and thread awake.
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
