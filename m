Received: from eggs.gnu.org ([2001:4830:134:3::10]:37313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e45kc-00064Z-PA
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e45kY-0005cj-S1
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:48:14 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171016133812.GB11975@redhat.com>
References: <afc33ce4-c9ab-9b35-38ec-80b16642ef00@weilnetz.de>
	<20171013113708.2dd02a17.cohuck@redhat.com>
	<20171013094400.GD20515@redhat.com>
	<20171016132246.GC5145@localhost.localdomain>
	<20171016133812.GB11975@redhat.com>
Date: Mon, 16 Oct 2017 15:47:31 +0200
Message-ID: <w51inffb3ws.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] German BSI analysed security of KVM /
 QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Cornelia Huck <cohuck@redhat.com>, QEMU Developer <qemu-devel@nongnu.org>, qemu-block@nongnu.org

On Mon 16 Oct 2017 03:38:12 PM CEST, Daniel P. Berrange wrote:
>> Another thing that made me a bit sad is that they mention qed as a
>> better performing alternative for qcow2. Even in 2017, people keep
>> spreading this nonsense. :-(
>
> Probably because when you google for QED you inevitably hit this article
> near the top:
>
>   https://www.phoronix.com/scan.php?page=news_item&px=OTY0MQ
>
> And there's little clear information on QEMU website to show that QED
> is essentially an obsolete experiment.

I remember having to ask on IRC in order to learn what the status of QED
was, I couldn't figure it out just by reading the documentation or even
the mailing list archives.

Berto
