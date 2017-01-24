Received: from eggs.gnu.org ([2001:4830:134:3::10]:43608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVxj4-0005oe-P4
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVxj4-00046q-0e
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:49:18 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <41b78fe3-8257-7b03-f543-c6537bd83d23@redhat.com> (John Snow's
	message of "Mon, 23 Jan 2017 12:27:29 -0500")
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
	<f3a064b5-9d01-1e6d-af5d-cbe503edf974@virtuozzo.com>
	<41b78fe3-8257-7b03-f543-c6537bd83d23@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 24 Jan 2017 10:49:07 +0100
Message-ID: <871svsaiuk.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] ping2 Re: [PATCH v4 00/17] Dirty bitmaps postcopy
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, dgilbert@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com

John Snow <jsnow@redhat.com> wrote:
> I'm really sorry, but I personally don't have the time to review this
> until February 6th.
>
> Juan, David, does this look all-ok from your end? Are we just waiting
> for block reviews at this point?

I think that I reviewed everything missed for the migration bits.
Only thing that is missing for the migration part is that Dave
agrees/disagrees to the ADVISE command having variable number of
arguments.

Later, Juan.
