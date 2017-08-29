Received: from eggs.gnu.org ([2001:4830:134:3::10]:44252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmcFE-00037v-GH
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmcFB-0000e8-E7
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:51:36 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:34120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dmcFB-0000dj-7n
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:51:33 -0400
Received: by mail-wm0-x231.google.com with SMTP id f13so18416187wme.1
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 01:51:31 -0700 (PDT)
Date: Tue, 29 Aug 2017 09:51:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170829085128.GA25960@stefanha-x1.localdomain>
References: <20170828145728.dqubknb7fruy4sfu@postretch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828145728.dqubknb7fruy4sfu@postretch>
Subject: Re: [Qemu-devel] GSOC Report: Moving I/O throttling and write
 notifiers into block filter drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Mon, Aug 28, 2017 at 05:57:28PM +0300, Manos Pitsidianakis wrote:
> Branches / Patches
> ==================
> 
> The 'throttle' and 'throttle-remove-legacy' patches should be merged soon
> after master unfreezes from the 2.10 release. The rest of the patch series
> are in final stages of review on qemu-devel except for block-insert-node
> which is an RFC [5].
> 
> Already merged patches in 2.10
>  https://github.com/qemu/qemu/commits/v2.10.0-rc4?author=epilys
> Already merged patches for 2.11
>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg470461.html
> 
> [0] [insert-node] block-insert-node and block-remove-node commands
>  https://github.com/epilys/qemu/commits/insert-node?author=epilys
> 
> [1] [throttle] add throttle filter driver
>  https://github.com/epilys/qemu/commits/throttle?author=epilys
>  Message-ID: <20170825132028.6184-1-el13635@mail.ntua.gr>
>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg476047.html
> 
> [2] [throttle-remove-legacy] remove legacy throttling interface
>  https://github.com/epilys/qemu/commits/throttle-remove-legacy?author=epilys
> 
> [3] [4] [notify] https://github.com/epilys/qemu/commits/notify?author=epilys
> 
> [5] block-insert-node RFC
>  Message-ID: <20170815074513.9055-1-el13635@mail.ntua.gr>
>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg473619.html

Thanks for your hard work, Manos!

Stefan
