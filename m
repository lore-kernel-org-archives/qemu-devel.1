Received: from eggs.gnu.org ([2001:4830:134:3::10]:38282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1foJsa-0004lV-CB
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 22:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1foJsW-00053v-FY
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 22:43:48 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:44869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1foJsW-00053I-5A
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 22:43:44 -0400
Received: by mail-pl0-x244.google.com with SMTP id ba4-v6so4741099plb.11
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 19:43:44 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180810222502.19663-1-laurent@vivier.eu>
	<8a16ea91-abdb-826e-cf2e-b5b25e1c6a74@physik.fu-berlin.de>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d043cfa6-5ec6-8876-984e-4cdad54a167b@twiddle.net>
Date: Fri, 10 Aug 2018 19:43:41 -0700
MIME-Version: 1.0
In-Reply-To: <8a16ea91-abdb-826e-cf2e-b5b25e1c6a74@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sh4: fix use_icount with linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 08/10/2018 03:47 PM, John Paul Adrian Glaubitz wrote:
> Fantastic, this fixes it! Can we get this into 3.0.0 before release?

Probably not, as -rc4 was supposed to be the last pre-release on Tuesday.  But
perhaps a revised version can make 3.0.1 (I see problems with this fix).


r~
