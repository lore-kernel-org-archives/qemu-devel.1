Received: from eggs.gnu.org ([2001:4830:134:3::10]:45655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dlAxW-0008OX-Dk
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dlAxR-0000IX-H4
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:31:22 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:44745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dlAxR-0000HU-0u
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:31:17 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1503602048-12268-13-git-send-email-armbru@redhat.com>
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
	<1503602048-12268-13-git-send-email-armbru@redhat.com>
Date: Fri, 25 Aug 2017 11:31:14 +0200
Message-ID: <w514lswvvrx.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 12/16] qapi-schema: Move block events
 from event.json to block.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

On Thu 24 Aug 2017 09:14:04 PM CEST, Markus Armbruster wrote:
> Cc: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

I'm not even sure about the difference between block.json and
block-core.json :) but I'm fine with the move anyway.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
