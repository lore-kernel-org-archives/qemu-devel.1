Received: from eggs.gnu.org ([209.51.188.92]:51177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hIyRX-0002Hy-0p
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hIyRW-0005QP-1H
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:38:50 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:32930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1hIyRV-0005NW-Ri
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:38:49 -0400
Received: by mail-pl1-x643.google.com with SMTP id t16so7813579plo.0
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 09:38:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190423063621.8203-1-nick.hudson@gmx.co.uk>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ef95d1db-8fca-db17-2343-565e814905fd@twiddle.net>
Date: Tue, 23 Apr 2019 09:38:42 -0700
MIME-Version: 1.0
In-Reply-To: <20190423063621.8203-1-nick.hudson@gmx.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] HPPA fixes for NetBSD/hppa emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nick Hudson <nick.hudson@gmx.co.uk>
Cc: Kamil Rytarowski <kamil@netbsd.org>, "open list:NETBSD" <qemu-devel@nongnu.org>

On 4/22/19 11:36 PM, Nick Hudson wrote:
> v3 changes:
>  - Don't use C99 comments and fix a typo in the comment
> 
> v2 changes:
>  - remove old debug code

Thanks, queued.


r~
