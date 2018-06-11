Received: from eggs.gnu.org ([2001:4830:134:3::10]:53499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSPEt-0004mH-An
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSPEo-0002VV-HL
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:00:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58958 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSPEo-0002UH-Dc
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:00:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180501132031.13270-1-viktor.prutyanov@virtuozzo.com>
	<87h8m94coh.fsf@dusky.pond.sub.org>
Date: Mon, 11 Jun 2018 18:00:05 +0200
In-Reply-To: <87h8m94coh.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Mon, 11 Jun 2018 16:31:42 +0200")
Message-ID: <87k1r52u0q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4] dump: add Windows dump format to
 dump-guest-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, rkagan@virtuozzo.com, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> Looks stuck.  Paolo, would you be willing to take this through your
> tree?

Hmm, there appears to be a respin:
Subject: [PATCH 0/4] dump: add Windows crashdump format
Date: Thu, 17 May 2018 19:23:38 +0300 (3 weeks, 3 days, 23 hours ago)
Message-ID: <20180517162342.4330-1-viktor.prutyanov@virtuozzo.com>
