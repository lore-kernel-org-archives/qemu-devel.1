Received: from eggs.gnu.org ([2001:4830:134:3::10]:53305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CPn-0003fE-Sd
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CPm-000053-PF
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:11:27 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8CPm-00004z-Ko
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:11:26 -0400
Received: by mail-qt0-x241.google.com with SMTP id j13so1648325qta.3
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 14:11:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-14-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8a500856-ca53-345e-8bad-7e45d254351f@twiddle.net>
Date: Tue, 9 May 2017 14:11:23 -0700
MIME-Version: 1.0
In-Reply-To: <20170506111431.12548-14-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/14] target/sh4: movua.l is an SH4-A
 only instruction
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
> At the same time change the comment describing the instruction the same
> way than other instruction, so that the code is easier to read and search.
> 
> Reviewed-by: Philippe Mathieu-Daudé<f4bug@amsat.org>
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/translate.c | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
