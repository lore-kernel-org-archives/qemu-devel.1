Received: from eggs.gnu.org ([2001:4830:134:3::10]:38021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVxQD-00064G-Fc
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVxQC-0006Ol-Ne
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:29:49 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1479837270-79005-10-git-send-email-vsementsov@virtuozzo.com>
	(Vladimir Sementsov-Ogievskiy's message of "Tue, 22 Nov 2016 20:54:22
	+0300")
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
	<1479837270-79005-10-git-send-email-vsementsov@virtuozzo.com>
Reply-To: quintela@redhat.com
Date: Tue, 24 Jan 2017 10:29:38 +0100
Message-ID: <87inp4ajr1.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 09/17] migration: include
 migrate_dirty_bitmaps in migrate_postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> Enable postcopy if dirty bitmap migration is endabled.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
