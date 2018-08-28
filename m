Received: from eggs.gnu.org ([2001:4830:134:3::10]:33513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujXq-0006Nf-3h
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujK6-00039J-Pg
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:06:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fujK6-00038p-Hz
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:06:42 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180828120736.32323-1-armbru@redhat.com>
Date: Tue, 28 Aug 2018 21:06:41 +0200
In-Reply-To: <20180828120736.32323-1-armbru@redhat.com> (Markus Armbruster's
	message of "Tue, 28 Aug 2018 14:07:34 +0200")
Message-ID: <871sail39a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/2] qapi: A whitespace touch-up,
 and a doc update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, eblake@redhat.com

Markus Armbruster <armbru@redhat.com> writes:

> Markus Armbruster (2):
>   qapi: Emit a blank line before dummy declaration
>   qapi: Update docs for generator changes since commit 9ee86b85267
>
>  docs/devel/qapi-code-gen.txt | 131 ++++++++++++++++++++++++++---------
>  scripts/qapi/common.py       |   1 +
>  2 files changed, 101 insertions(+), 31 deletions(-)

Queued.
