Received: from eggs.gnu.org ([2001:4830:134:3::10]:44334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpdXM-00016t-6R
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpdX7-0004hF-5k
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:55:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49502 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpdX7-0004h9-0u
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:55:05 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1534258018-22859-1-git-send-email-thuth@redhat.com>
	<1534258018-22859-4-git-send-email-thuth@redhat.com>
Date: Tue, 14 Aug 2018 19:55:02 +0200
In-Reply-To: <1534258018-22859-4-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Tue, 14 Aug 2018 16:46:55 +0200")
Message-ID: <87600cu93d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/6] hw/timer/mc146818rtc: White space
 clean-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> mc146818rtc.c still contains some TABs. Replace them with spaces.

Also delete trailing whitespace.

>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

With the commit message amended:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
