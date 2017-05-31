Received: from eggs.gnu.org ([2001:4830:134:3::10]:59714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG73j-0007qe-EM
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG73g-0007Qo-2P
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:05:23 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1481822644-617-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1481822644-617-2-git-send-email-mdroth@linux.vnet.ibm.com>
	<20170512102204.GG2069@work-vm> <87y3ty383w.fsf@dusky.pond.sub.org>
Date: Wed, 31 May 2017 19:05:16 +0200
In-Reply-To: <87y3ty383w.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Mon, 15 May 2017 09:13:55 +0200")
Message-ID: <87a85t0xf7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: check-qom-proplist: add checks
 for cmdline-created objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

Markus Armbruster <armbru@redhat.com> writes:

> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>
>> I notice this pair of patches doesn't seem to have gone anywhere.
>> WHile it's labelled as a monitor fix, it's all QOM stuff, so I don't
>> think it should be going via me.
>
> It's somewhere between QOM and QemuOpts.  Andreas, please have a look.
> Feel free to ask me to take the patch through my tree.

I considered applying the series to qapi-next, and realized I'm not sure
what the latest version is.  I could peruse the archives, but that's
work.  Mike, would you mind resending your latest version?
