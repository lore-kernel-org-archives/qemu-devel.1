Received: from eggs.gnu.org ([2001:4830:134:3::10]:38674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fqbyR-0006fd-KI
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fqbyO-0001pz-VQ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:27:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35674 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fqbyO-0001or-R2
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:27:16 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1534419358-10932-4-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 16 Aug 2018 13:35:53 +0200")
References: <1534419358-10932-1-git-send-email-thuth@redhat.com>
	<1534419358-10932-4-git-send-email-thuth@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 17 Aug 2018 12:27:06 +0200
Message-ID: <87zhxluw3p.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/8] hw/timer/mc146818rtc: White space
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Thomas Huth <thuth@redhat.com> wrote:
> mc146818rtc.c still contains some TABs. Replace them with spaces.
> And while we're at it, also delete trailing whitespace in this file.
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
