Received: from eggs.gnu.org ([2001:4830:134:3::10]:36667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1csxat-0005u6-Oe
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1csxaq-0008JE-I8
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:19:55 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:41970
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1csxaq-0008J8-Aw
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 16:19:52 -0400
References: <20170324231943.18768-1-Andrew.Baumann@microsoft.com>
	<bb0868d1-5c56-45e5-8b6c-ee08e77dfeaa@weilnetz.de>
	<fbb1c7da-1c51-8ee5-b94d-62fd17c068e0@redhat.com>
	<DM2PR21MB0060647969F7193B509AE8AF9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
	<c95a9ea9-dce2-d6e9-9328-5deebec63950@weilnetz.de>
	<20170328231039-mutt-send-email-mst@kernel.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <3234580b-b4fc-0e7a-a479-cd76e0eca2ee@weilnetz.de>
Date: Tue, 28 Mar 2017 22:19:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170328231039-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.9] virtio: fix vring_align() on
 64-bit windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Am 28.03.2017 um 22:11 schrieb Michael S. Tsirkin:

> I'm doing a pull request a bit later today - I can pick this one up
> if you prefer. If yes, pls send your ack.
>

Yes, please.

Thanks a lot
Stefan
