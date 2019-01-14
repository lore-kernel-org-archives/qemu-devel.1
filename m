Received: from eggs.gnu.org ([209.51.188.92]:40682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1giyqi-0000lj-OY
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1giyqh-0008Dp-8c
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:48:04 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:34564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1giyqg-00080v-Gu
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:48:03 -0500
Received: by mail-wr1-x42a.google.com with SMTP id j2so22107399wrw.1
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 01:47:41 -0800 (PST)
From: remy.noel@blade-group.com
Date: Mon, 14 Jan 2019 10:48:04 +0100
Message-ID: <20190114094804.byut5p4hbyi6suit@gmail.com>
References: <20181220152030.28035-1-remy.noel@blade-group.com>
	<20190112083008.GA20193@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190112083008.GA20193@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [QEMU-devel][PATCH v4 0/2] Fix concurrent
 aio_poll/set_fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: remy.noel@blade-group.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>

On Sat, Jan 12, 2019 at 08:30:08AM +0000, Stefan Hajnoczi wrote:
>Thanks, applied to my block tree:
>https://github.com/stefanha/qemu/commits/block
>
Thanks !

Remy
