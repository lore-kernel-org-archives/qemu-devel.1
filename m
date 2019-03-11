Received: from eggs.gnu.org ([209.51.188.92]:55356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3Lno-0000Sx-Mi
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3Lka-0005GB-UT
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:17:58 -0400
References: <20190308131445.17502-1-armbru@redhat.com>
	<20190308131445.17502-6-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9e3ba11b-b3c1-a07b-671d-fb894cb56f7f@redhat.com>
Date: Mon, 11 Mar 2019 15:17:40 +0100
MIME-Version: 1.0
In-Reply-To: <20190308131445.17502-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/12] vl: Improve legibility of
 BlockdevOptions queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

On 08/03/19 14:14, Markus Armbruster wrote:
> Give the queue head type a name: BlockdevOptionsQueue.

No particular need for this, but no huge objections either.

> Rename the queue entry type from BlockdevOptions_queue to
> BlockdevOptionsQueueEntry.

This is welcome. ;)

Paolo
