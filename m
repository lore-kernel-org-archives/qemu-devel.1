Received: from eggs.gnu.org ([2001:4830:134:3::10]:53041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8COf-0002rv-8B
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8COe-0008J1-GN
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:10:17 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8COe-0008Io-C8
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:10:16 -0400
Received: by mail-qk0-x241.google.com with SMTP id u75so1925023qka.1
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 14:10:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-12-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cb723018-5188-103d-4548-b9b459e9ccec@twiddle.net>
Date: Tue, 9 May 2017 14:10:13 -0700
MIME-Version: 1.0
In-Reply-To: <20170506111431.12548-12-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/14] target/sh4: generate fences for
 SH4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/06/2017 04:14 AM, Aurelien Jarno wrote:
> synco is a SH4-A only instruction.
> 
> Reviewed-by: Philippe Mathieu-Daudé<f4bug@amsat.org>
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/translate.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
