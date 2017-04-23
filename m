Received: from eggs.gnu.org ([2001:4830:134:3::10]:34290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2LAk-000147-H3
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 13:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2LAh-00040H-DU
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 13:19:42 -0400
References: <1490060356096-474442.post@n7.nabble.com>
	<0268b783-e9fb-8c16-8198-c0bb4e6ca9d3@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <334e7a40-4e4f-c743-7d9e-ca2366effff3@msgid.tls.msk.ru>
Date: Sun, 23 Apr 2017 20:19:38 +0300
MIME-Version: 1.0
In-Reply-To: <0268b783-e9fb-8c16-8198-c0bb4e6ca9d3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5]COLO:Fix spell error in Colo doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, wangguang <wang.guang55@zte.com.cn>, qemu-devel@nongnu.org, qemu-trivial <qemu-trivial@nongnu.org>

21.03.2017 04:53, Eric Blake wrote:
> On 03/20/2017 08:39 PM, wangguang wrote:
>> Subject: [PATCH]COLO:Fix spell error in Colo doc
> 
> I added qemu-trivial in v4; you should keep it in the loop.
> 
> Still missing a space after ':' in the subject line, and still the
> awkward duplication of the subject line in the body of the commit message.
...

As Zhang Chen pointed out in the original patch submission,
this patch isn't really needed since the command is actually
different, and he'll update the doc later.

Thanks,

/mjt
