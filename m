Received: from eggs.gnu.org ([2001:4830:134:3::10]:56824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTqsa-0001va-Nv
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTqsZ-0001Nd-Vs
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:43:12 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <152891543944.690.7624030804989659934@d39dc562802a>
	<f14e04cc-fc3a-4c69-b3a7-0980346bf4f9@virtuozzo.com>
Date: Fri, 15 Jun 2018 17:43:01 +0200
In-Reply-To: <f14e04cc-fc3a-4c69-b3a7-0980346bf4f9@virtuozzo.com> (Anton
	Nefedov's message of "Thu, 14 Jun 2018 09:44:42 +0300")
Message-ID: <87wov0xdh6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 0/8] discard blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, berto@igalia.com, den@virtuozzo.com, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, famz@redhat.com, jsnow@redhat.com

Anton Nefedov <anton.nefedov@virtuozzo.com> writes:

> well, build tests failed due to the lack of qapi patches this series is
> based on :)
> (http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg03638.html)

Try adding

    Based-on: <1528905228-25694-1-git-send-email-anton.nefedov@virtuozzo.com>

to your cover letter next time.  That's the prerequisite patch's
Message-Id.  Cover letter requires the complete series.
