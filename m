Received: from eggs.gnu.org ([2001:4830:134:3::10]:59012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWeH5-0003tf-N3
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWeH4-0001Oi-TT
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:19:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWeH4-0001Ny-NB
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:19:46 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1509369390-8285-6-git-send-email-a.perevalov@samsung.com>
	(Alexey Perevalov's message of "Mon, 30 Oct 2017 16:16:29 +0300")
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171030131650eucas1p11e65153f114fd66677a37751e4e82b2d@eucas1p1.samsung.com>
	<1509369390-8285-6-git-send-email-a.perevalov@samsung.com>
Reply-To: quintela@redhat.com
Date: Wed, 03 Jan 2018 09:19:38 +0100
Message-ID: <87lghf4an9.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v12 5/6] migration: add blocktime
 calculation into migration-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, i.maximets@samsung.com, heetae82.ahn@samsung.com, dgilbert@redhat.com

Alexey Perevalov <a.perevalov@samsung.com> wrote:
> This patch just requests blocktime calculation,
> and check it in case when UFFD_FEATURE_THREAD_ID feature is set
> on the host.
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
